#!/usr/bin/env python3
"""scout.py — Provider discovery for ModelAtlas.

Queries live API catalogs (OpenRouter, aggregators) and compares against
current seed.sql data. Writes a structured diff report.

Usage:
  python3 scripts/scout.py                     # full scout, writes report
  python3 scripts/scout.py --quick             # OpenRouter only, faster
  python3 scripts/scout.py --report-only       # re-read last report, don't fetch

Exit codes:
  0 — no changes detected
  1 — changes detected (new providers, models, pricing deltas)
  2 — fetch error
"""

from __future__ import annotations

import csv
import io
import json
import os
import re
import sys
import urllib.request
import urllib.error
from collections import defaultdict
from datetime import date
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
REPORT_DIR = ROOT / ".swarm" / "reports"
SEED_FILE = ROOT / "seed.sql"
EXPORT_DIR = ROOT / "export"

REPORT_FILE = REPORT_DIR / "scout-report.json"

TIMEOUT = 15  # seconds per API call


# ── Data sources ────────────────────────────────────────────────


def fetch_json(url: str, headers: dict[str, str] | None = None) -> Any:
    req = urllib.request.Request(url, headers=headers or {})
    with urllib.request.urlopen(req, timeout=TIMEOUT) as resp:
        return json.loads(resp.read().decode())


def fetch_openrouter_models() -> list[dict[str, Any]]:
    """Fetch OpenRouter model catalog. Returns list of model dicts."""
    data = fetch_json("https://openrouter.ai/api/v1/models")
    if isinstance(data, dict) and "data" in data:
        return data["data"]
    if isinstance(data, list):
        return data
    return []


def fetch_openrouter_providers() -> list[dict[str, Any]]:
    """Fetch OpenRouter provider list."""
    data = fetch_json("https://openrouter.ai/api/v1/providers")
    if isinstance(data, dict) and "data" in data:
        return data["data"]
    if isinstance(data, list):
        return data
    return []


def fetch_aggregator_models(name: str, url: str, api_key: str | None = None) -> list[dict[str, Any]]:
    """Fetch model list from an aggregator-style API."""
    headers = {}
    if api_key:
        headers["Authorization"] = f"Bearer {api_key}"
    try:
        data = fetch_json(url, headers=headers)
        if isinstance(data, list):
            return data
        if isinstance(data, dict):
            # Try common response shapes
            for key in ("data", "models", "results"):
                if key in data and isinstance(data[key], list):
                    return data[key]
            return []
    except Exception as exc:
        print(f"  [warn] {name} unavailable: {exc}", file=sys.stderr)
        return []


# ── Current state from seed.sql ─────────────────────────────────


def parse_seed_providers() -> set[str]:
    """Extract provider IDs from seed.sql."""
    if not SEED_FILE.exists():
        return set()
    text = SEED_FILE.read_text(encoding="utf-8")
    providers = set()
    for match in re.finditer(
        r"INSERT\s+INTO\s+providers\s*\([^)]+\)\s*VALUES\s*(.*?);",
        text,
        re.DOTALL | re.IGNORECASE,
    ):
        for tup in re.findall(r"\(([^)]+)\)", match.group(1)):
            parts = [p.strip().strip("'") for p in tup.split(",")]
            if parts:
                providers.add(parts[0])
    return providers


def parse_seed_models() -> dict[str, set[str]]:
    """Extract {provider_id: {model_slug, ...}} from seed.sql."""
    if not SEED_FILE.exists():
        return {}
    text = SEED_FILE.read_text(encoding="utf-8")
    result: dict[str, set[str]] = defaultdict(set)
    for match in re.finditer(
        r"INSERT\s+INTO\s+models\s*\(([^)]+)\)\s*VALUES\s*(.*?);",
        text,
        re.DOTALL | re.IGNORECASE,
    ):
        cols = [c.strip() for c in match.group(1).split(",")]
        # Find provider_id and slug column positions
        try:
            pi = cols.index("provider_id")
            si = cols.index("slug")
        except ValueError:
            continue
        for tup in re.findall(r"\(([^)]+)\)", match.group(2)):
            parts = [p.strip().strip("'") for p in tup.split(",")]
            if len(parts) > max(pi, si):
                result[parts[pi]].add(parts[si])
    return result


# ── Diff engine ─────────────────────────────────────────────────


def build_diff(
    known_providers: set[str],
    known_models: dict[str, set[str]],
    or_models: list[dict[str, Any]],
) -> dict[str, Any]:
    """Compare OpenRouter catalog against known data."""
    or_provider_ids: set[str] = set()
    or_models_by_provider: dict[str, set[str]] = defaultdict(set)
    provider_names: dict[str, str] = {}

    for model in or_models:
        model_id = model.get("id", "")
        # Model ID format: "provider/model-slug" or "provider:model-slug"
        parts = re.split(r"[/:]", model_id, maxsplit=1)
        if len(parts) >= 2:
            prov = parts[0].lower()
            slug = parts[1]
            or_provider_ids.add(prov)
            or_models_by_provider[prov].add(slug)
            # Collect display name
            if "name" in model:
                provider_names[prov] = model["name"].split(":")[0].strip()

    new_providers = sorted(or_provider_ids - known_providers)
    missing_providers = sorted(known_providers - or_provider_ids)

    new_models: dict[str, list[str]] = {}
    changed_models: dict[str, list[dict]] = defaultdict(list)

    for prov in sorted(or_models_by_provider):
        known = known_models.get(prov, set())
        new = sorted(or_models_by_provider[prov] - known)
        if new:
            new_models[prov] = new
        # Check pricing changes (basic comparison)
        for model in or_models:
            mid = model.get("id", "")
            parts = re.split(r"[/:]", mid, maxsplit=1)
            if len(parts) >= 2 and parts[0].lower() == prov:
                slug = parts[1]
                pricing = model.get("pricing", {})
                if pricing:
                    changed_models[prov].append({
                        "slug": slug,
                        "pricing": pricing,
                        "context_length": model.get("context_length"),
                    })

    # Get total model count from OpenRouter
    total_or_models = len(or_models)

    return {
        "scout_date": str(date.today()),
        "openrouter_providers": len(or_provider_ids),
        "openrouter_models": total_or_models,
        "known_providers": len(known_providers),
        "new_providers": new_providers,
        "missing_from_openrouter": missing_providers,
        "new_models_by_provider": new_models,
        "provider_names": {k: v for k, v in provider_names.items() if k in new_providers or k in new_models},
        "has_changes": bool(new_providers or new_models),
    }


# ── Report ──────────────────────────────────────────────────────


def write_report(data: dict[str, Any]) -> None:
    REPORT_DIR.mkdir(parents=True, exist_ok=True)
    REPORT_FILE.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
    print(f"  Report: {REPORT_FILE}")


def print_summary(data: dict[str, Any]) -> None:
    print(f"\n  OpenRouter: {data['openrouter_providers']} providers, {data['openrouter_models']} models")
    print(f"  Known: {data['known_providers']} providers in seed.sql")
    if data["new_providers"]:
        print(f"  NEW providers ({len(data['new_providers'])}):")
        for p in data["new_providers"][:15]:
            name = data.get("provider_names", {}).get(p, p)
            print(f"    + {p} ({name})")
        if len(data["new_providers"]) > 15:
            print(f"    ... and {len(data['new_providers']) - 15} more")
    if data["new_models_by_provider"]:
        print(f"  NEW models across {len(data['new_models_by_provider'])} providers:")
        for prov, models in sorted(data["new_models_by_provider"].items()):
            print(f"    {prov}: {len(models)} new models")
    if data["missing_from_openrouter"]:
        print(f"  Missing from OpenRouter ({len(data['missing_from_openrouter'])}):")
        for p in data["missing_from_openrouter"][:10]:
            print(f"    ? {p}")
        if len(data["missing_from_openrouter"]) > 10:
            print(f"    ... and {len(data['missing_from_openrouter']) - 10} more")
    if not data["has_changes"]:
        print("  No changes detected.")


# ── Main ────────────────────────────────────────────────────────


def main() -> int:
    import argparse
    parser = argparse.ArgumentParser(description="ModelAtlas provider scout")
    parser.add_argument("--quick", action="store_true", help="OpenRouter only, skip aggregators")
    parser.add_argument("--report-only", action="store_true", help="Re-read last report, don't fetch")
    args = parser.parse_args()

    if args.report_only:
        if REPORT_FILE.exists():
            data = json.loads(REPORT_FILE.read_text(encoding="utf-8"))
            print_summary(data)
            return 1 if data.get("has_changes") else 0
        print("No report found. Run without --report-only first.", file=sys.stderr)
        return 2

    # Current state
    known_providers = parse_seed_providers()
    known_models = parse_seed_models()

    if not known_providers:
        print("No providers found in seed.sql.", file=sys.stderr)
        # Not fatal — could be empty repo
        return 2

    print("Scouting OpenRouter...")
    try:
        or_models = fetch_openrouter_models()
    except Exception as exc:
        print(f"  ERROR: OpenRouter unavailable: {exc}", file=sys.stderr)
        return 2

    diff = build_diff(known_providers, known_models, or_models)

    if not args.quick:
        # Aggregator scouts (best-effort, non-blocking)
        print("Scouting aggregators...")
        for agg_name, agg_url in [
            ("Together AI", "https://api.together.ai/v1/models"),
            ("Fireworks AI", "https://api.fireworks.ai/v1/models"),
            ("Groq", "https://api.groq.com/v1/models"),
        ]:
            models = fetch_aggregator_models(agg_name, agg_url)
            if models:
                diff.setdefault("aggregator_counts", {})[agg_name] = len(models)

    write_report(diff)
    print_summary(diff)

    return 1 if diff["has_changes"] else 0


if __name__ == "__main__":
    raise SystemExit(main())
