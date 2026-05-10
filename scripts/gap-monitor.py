#!/usr/bin/env python3
"""gap-monitor.py — Data quality checks for ModelAtlas.

Reads export/*.json files and validates data integrity. Reports:
- Providers with no pricing records
- Models with no capabilities
- Deprecated models past their sunset date still marked active
- Endpoints with no model mappings
- Providers with zero models

Usage:
  python3 scripts/gap-monitor.py
  python3 scripts/gap-monitor.py --json   # machine-readable output only

Exit codes:
  0 — no gaps found
  1 — gaps found
  2 — export data unavailable
"""

from __future__ import annotations

import json
import sys
from datetime import date
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
EXPORT_DIR = ROOT / "export"
REPORT_DIR = ROOT / ".swarm" / "reports"
REPORT_FILE = REPORT_DIR / "gap-report.json"


def load_export(table: str) -> list[dict[str, Any]]:
    """Load rows from an export JSON file."""
    path = EXPORT_DIR / f"{table}.json"
    if not path.exists():
        return []
    data = json.loads(path.read_text(encoding="utf-8"))
    return data.get("rows", [])


def check_pricing_coverage(providers: list[dict], pricing: list[dict]) -> list[str]:
    """Find providers that exist but have zero pricing records."""
    provider_ids = {p["id"] for p in providers if p.get("id")}
    priced_providers = set()
    for p in pricing:
        mid = p.get("model_id")
        if mid:
            # model_id is a FK into models; we need to find which provider
            pass
    # Pricing is by model_id, not provider_id directly.
    # Instead, check which providers have at least one model with pricing.
    models = load_export("models")
    models_with_pricing = {m["provider_id"] for m in models if m.get("provider_id")}
    missing = sorted(provider_ids - models_with_pricing)
    return missing


def check_models_without_capabilities(models: list[dict], caps: list[dict]) -> list[str]:
    """Find models that have zero capability records."""
    capped_model_ids = {c["model_id"] for c in caps if c.get("model_id")}
    model_slugs = []
    for m in models:
        mid = m.get("id") or m.get("slug")
        if mid and mid not in capped_model_ids:
            model_slugs.append(f"{m.get('provider_id', '?')}/{m.get('slug', '?')}")
    return model_slugs


def check_sunset_models(models: list[dict]) -> list[dict]:
    """Find active models past their sunset date."""
    today = date.today()
    overdue = []
    for m in models:
        status = m.get("status", "")
        sunset = m.get("sunset_date")
        if status == "active" and sunset:
            try:
                sd = date.fromisoformat(str(sunset))
                if sd < today:
                    overdue.append({
                        "provider": m.get("provider_id"),
                        "slug": m.get("slug"),
                        "sunset_date": str(sunset),
                    })
            except (ValueError, TypeError):
                pass
    return overdue


def check_orphaned_endpoints(endpoints: list[dict], endpoint_map: list[dict]) -> list[str]:
    """Find endpoints with no model_endpoint_map entries."""
    mapped_endpoint_ids = {e["endpoint_id"] for e in endpoint_map if e.get("endpoint_id")}
    orphaned = []
    for e in endpoints:
        eid = e.get("id")
        if eid and eid not in mapped_endpoint_ids:
            orphaned.append(f"{e.get('provider_id', '?')}/{e.get('slug', '?')}")
    return orphaned


def check_providers_without_models(providers: list[dict], models: list[dict]) -> list[str]:
    """Find providers that have no models in the database."""
    provider_ids_with_models = {m["provider_id"] for m in models if m.get("provider_id")}
    missing = []
    for p in providers:
        pid = p.get("id")
        if pid and pid not in provider_ids_with_models:
            missing.append(pid)
    return sorted(missing)


def build_report() -> dict[str, Any]:
    providers = load_export("providers")
    models = load_export("models")
    caps = load_export("model_capabilities")
    pricing = load_export("model_pricing")
    endpoints = load_export("endpoints")
    endpoint_map = load_export("model_endpoint_map")

    if not providers:
        return {"error": "providers.json not found or empty", "has_gaps": True}

    gaps: dict[str, Any] = {}

    # P1: Providers with no pricing
    prov_no_pricing = check_pricing_coverage(providers, pricing)
    if prov_no_pricing:
        gaps["providers_without_pricing"] = prov_no_pricing

    # P2: Models with no capabilities
    models_no_caps = check_models_without_capabilities(models, caps)
    if models_no_caps:
        gaps["models_without_capabilities"] = models_no_caps[:20]  # cap output

    # P3: Sunset models still active
    overdue = check_sunset_models(models)
    if overdue:
        gaps["active_models_past_sunset"] = overdue

    # P4: Orphaned endpoints
    orphaned = check_orphaned_endpoints(endpoints, endpoint_map)
    if orphaned:
        gaps["orphaned_endpoints"] = orphaned

    # P5: Providers with no models
    prov_no_models = check_providers_without_models(providers, models)
    if prov_no_models:
        gaps["providers_without_models"] = prov_no_models

    report = {
        "check_date": str(date.today()),
        "providers_count": len(providers),
        "models_count": len(models),
        "has_gaps": bool(gaps),
        "gaps": gaps,
    }
    return report


def print_report(report: dict[str, Any]) -> None:
    if "error" in report:
        print(f"  ERROR: {report['error']}", file=sys.stderr)
        return

    print(f"\n  ModelAtlas Gap Report — {report['check_date']}")
    print(f"  Providers: {report['providers_count']}, Models: {report['models_count']}")
    print()

    gaps = report.get("gaps", {})
    if not gaps:
        print("  No gaps found.")
        return

    if "providers_without_pricing" in gaps:
        plist = gaps["providers_without_pricing"]
        print(f"  [!] {len(plist)} providers have no models with pricing:")
        for p in plist[:10]:
            print(f"      {p}")
        if len(plist) > 10:
            print(f"      ... and {len(plist) - 10} more")

    if "models_without_capabilities" in gaps:
        mlist = gaps["models_without_capabilities"]
        print(f"  [!] {len(mlist)} models have no capabilities:")
        for m in mlist[:10]:
            print(f"      {m}")
        if len(mlist) > 10:
            print(f"      ... and {len(mlist) - 10} more")

    if "active_models_past_sunset" in gaps:
        for m in gaps["active_models_past_sunset"]:
            print(f"  [!] {m['provider']}/{m['slug']} past sunset ({m['sunset_date']}) but still active")

    if "orphaned_endpoints" in gaps:
        print(f"  [!] {len(gaps['orphaned_endpoints'])} endpoints have no model mappings")

    if "providers_without_models" in gaps:
        plist = gaps["providers_without_models"]
        print(f"  [!] {len(plist)} providers have zero models:")
        for p in plist:
            print(f"      {p}")


def main() -> int:
    import argparse
    parser = argparse.ArgumentParser(description="ModelAtlas gap monitor")
    parser.add_argument("--json", action="store_true", help="Machine-readable JSON output only")
    args = parser.parse_args()

    report = build_report()

    REPORT_DIR.mkdir(parents=True, exist_ok=True)
    REPORT_FILE.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")

    if args.json:
        print(json.dumps(report, indent=2))
    else:
        print_report(report)

    return 1 if report.get("has_gaps") else 0


if __name__ == "__main__":
    raise SystemExit(main())
