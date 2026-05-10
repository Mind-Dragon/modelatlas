#!/usr/bin/env python3
"""Generate ModelAtlas JSON exports from seed.sql.

Two modes:
  1. Standalone (no args): regex-parses seed.sql INSERT statements into JSON.
     Works without PostgreSQL. Handles literal tuples and subquery-based INSERTs.
  2. PG-backed (--database-url): loads schema+seed into real PostgreSQL,
     then exports deterministic JSON via SQL queries with ORDER BY.
     Produces cleaner JSON with resolved FK references.

Usage:
  python3 generate-exports.py                          # regex mode
  python3 generate-exports.py --database-url <URL>     # PG mode
  python3 generate-exports.py --verify                 # PG mode + run verify-release.py
"""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from contextlib import contextmanager
from pathlib import Path
from typing import Any, Iterator

OUTDIR = Path(__file__).resolve().parent
SEED_FILE = OUTDIR / "seed.sql"
SCHEMA_FILE = OUTDIR / "schema.sql"
EXPORT_DIR = OUTDIR / "export"

TABLE_ORDER = [
    "providers",
    "provider_plans",
    "models",
    "model_capabilities",
    "model_pricing",
    "endpoints",
    "model_endpoint_map",
    "model_aliases",
]

ORDER_BY = {
    "providers": 'id collate "C"',
    "provider_plans": 'provider_id collate "C", slug collate "C"',
    "models": 'provider_id collate "C", slug collate "C"',
    "model_capabilities": 'model_id, capability::text collate "C"',
    "model_pricing": (
        'model_id, endpoint_type::text collate "C", region collate "C", '
        "coalesce(plan_id, 0), effective_date, currency, "
        "price_per_1m_input_tokens, price_per_1m_output_tokens"
    ),
    "endpoints": 'provider_id collate "C", slug collate "C"',
    "model_endpoint_map": (
        'model_id, endpoint_id, coalesce(plan_id, 0), '
        'is_default desc, routing_weight, coalesce(notes, \'\') collate "C"'
    ),
    "model_aliases": 'model_id, alias collate "C"',
}

SURROGATE_ID_TABLES = {
    "model_capabilities",
    "model_pricing",
    "model_endpoint_map",
    "model_aliases",
}


# ── Standalone mode: regex-parsed ──────────────────────────────


def parse_seed_file() -> dict[str, Any]:
    """Parse seed.sql INSERT statements via regex. Returns table_data dict."""
    seed_text = SEED_FILE.read_text(encoding="utf-8")
    # Strip transaction wrapper
    seed_text = re.sub(r"(?is)^\s*BEGIN;?\s*", "", seed_text)
    seed_text = re.sub(r"(?is)\s*COMMIT;?\s*$", "", seed_text)

    insert_pattern = re.compile(
        r"INSERT\s+INTO\s+(\w+)\s*\(([^)]+)\)\s*(VALUES\s*.*?|SELECT\s+.*?);",
        re.DOTALL | re.IGNORECASE,
    )

    table_data: dict[str, Any] = {}

    for match in insert_pattern.finditer(seed_text):
        table_name = match.group(1)
        columns_str = match.group(2)
        body = match.group(3).strip()

        if table_name not in table_data:
            table_data[table_name] = {"columns": [], "literal_rows": [], "subquery_blocks": []}

        cols = [c.strip().strip('"') for c in columns_str.split(",")]
        if not table_data[table_name]["columns"]:
            table_data[table_name]["columns"] = cols

        if body.upper().startswith("VALUES"):
            values_text = body[6:].strip().rstrip(";")
            tuples = _parse_tuples(values_text)
            for tup in tuples:
                vals = _parse_values(tup)
                table_data[table_name]["literal_rows"].append(vals)
        elif body.upper().startswith("SELECT"):
            table_data[table_name]["subquery_blocks"].append(body.rstrip(";").strip())

    return table_data


def _parse_tuples(values_text: str) -> list[str]:
    """Parse top-level SQL tuples respecting nesting depth."""
    tuples = []
    depth = 0
    current = ""
    for ch in values_text:
        if ch == "(":
            if depth == 0:
                current = "("
            else:
                current += ch
            depth += 1
        elif ch == ")":
            current += ch
            depth -= 1
            if depth == 0:
                tuples.append(current.strip())
        else:
            if depth > 0:
                current += ch
    return tuples


def _parse_values(tup: str) -> list[str | None]:
    """Parse values inside a SQL tuple, respecting quoted strings."""
    vals: list[str | None] = []
    buf = ""
    in_string = False
    str_char: str | None = None
    for ch in tup.strip("()"):
        if in_string:
            buf += ch
            if ch == str_char and (len(buf) < 2 or buf[-2] != "\\"):
                str_char = None
                in_string = False
            continue
        if ch in ("'", '"'):
            in_string = True
            str_char = ch
            buf += ch
            continue
        if ch == ",":
            vals.append(buf.strip())
            buf = ""
            continue
        buf += ch
    if buf.strip():
        vals.append(buf.strip())
    return vals


def _clean_sql_val(val: str | None) -> Any:
    """Convert a SQL literal string to a Python value."""
    if val is None:
        return None
    val = val.strip()
    if val.upper() in ("NULL", ""):
        return None
    if (val.startswith("'") and val.endswith("'")) or (val.startswith('"') and val.endswith('"')):
        return val[1:-1]
    if val.upper() == "TRUE":
        return True
    if val.upper() == "FALSE":
        return False
    try:
        if "." in val:
            return float(val)
        return int(val)
    except (ValueError, TypeError):
        return val


def write_standalone_exports(table_data: dict[str, Any]) -> dict[str, int]:
    """Write JSON exports from regex-parsed data. Returns row counts."""
    EXPORT_DIR.mkdir(exist_ok=True)
    total_literal = 0
    total_dynamic = 0

    for table_name, data in table_data.items():
        rows_json: list[dict[str, Any]] = []
        for row_vals in data["literal_rows"]:
            obj: dict[str, Any] = {}
            for i, col in enumerate(data["columns"]):
                val = _clean_sql_val(row_vals[i] if i < len(row_vals) else None)
                obj[col] = val
            rows_json.append(obj)

        total_literal += len(rows_json)
        total_dynamic += len(data["subquery_blocks"])

        entry: dict[str, Any] = {
            "table": table_name,
            "export_date": "2026-05-10",
            "columns": data["columns"],
            "row_count": len(rows_json),
            "dynamic_insert_count": len(data["subquery_blocks"]),
            "rows": rows_json,
        }

        if data["subquery_blocks"]:
            entry["generator_notes"] = (
                "Some INSERT statements use subqueries for FK resolution "
                "(e.g., SELECT m.id FROM models m WHERE slug = '...'). "
                "Run seed.sql in PostgreSQL to materialize."
            )
            entry["subquery_inserts"] = data["subquery_blocks"]

        (EXPORT_DIR / f"{table_name}.json").write_text(
            json.dumps(entry, indent=2, default=str) + "\n", encoding="utf-8"
        )
        flags = ""
        if data["subquery_blocks"]:
            flags = f" + {len(data['subquery_blocks'])} dynamic"
        print(f"  export/{table_name}.json — {len(rows_json)} literal rows{flags}")

    row_counts = {
        table: len(table_data.get(table, {}).get("literal_rows", []))
        for table in table_data
    }
    return row_counts


# ── PG-backed mode: deterministic JSON via SQL ─────────────────


def run(cmd: list[str], *, cwd: Path = OUTDIR, env: dict[str, str] | None = None) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        cmd,
        cwd=cwd,
        env=env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=True,
    )


def psql(url: str, sql: str) -> str:
    env = os.environ.copy()
    env["PGTZ"] = "UTC"
    return run(["psql", url, "-v", "ON_ERROR_STOP=1", "-At", "-c", sql], env=env).stdout.strip()


@contextmanager
def managed_database_url(explicit_url: str | None) -> Iterator[str]:
    if explicit_url:
        yield explicit_url
        return

    missing = [cmd for cmd in ("initdb", "pg_ctl", "createdb", "psql") if shutil.which(cmd) is None]
    if missing:
        raise SystemExit(
            "PostgreSQL server tools required for PG mode. Missing: " + ", ".join(missing)
        )

    with tempfile.TemporaryDirectory(prefix="modelatlas-pg-") as tmp:
        base = Path(tmp)
        data = base / "data"
        run(["initdb", "-D", str(data), "-A", "trust", "--no-locale"], cwd=base)
        subprocess.run(
            ["pg_ctl", "-D", str(data), "-o", f"-h '' -k {base}", "-w", "start"],
            cwd=base,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            text=True,
            check=True,
        )
        try:
            run(["createdb", "-h", str(base), "modelatlas"], cwd=base)
            yield f"postgresql:///modelatlas?host={base}"
        finally:
            subprocess.run(
                ["pg_ctl", "-D", str(data), "-m", "fast", "stop"],
                cwd=base,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                check=False,
            )


def load_database(url: str) -> None:
    psql(url, "drop schema if exists public cascade; create schema public;")
    run(["psql", url, "-v", "ON_ERROR_STOP=1", "-f", str(SCHEMA_FILE)])
    run(["psql", url, "-v", "ON_ERROR_STOP=1", "-f", str(SEED_FILE)])


def stabilize_database(url: str, export_date: str) -> None:
    timestamp = f"{export_date}T00:00:00Z" if export_date != "unknown" else "1970-01-01T00:00:00Z"
    for table in TABLE_ORDER:
        columns = psql(
            url,
            "select string_agg(column_name, ',' order by column_name) "
            "from information_schema.columns "
            f"where table_schema = 'public' and table_name = '{table}' "
            "and column_name in ('created_at', 'updated_at');",
        )
        if columns:
            assignments = ", ".join(
                f"{column} = timestamptz '{timestamp}'" for column in columns.split(",")
            )
            psql(url, f"update {table} set {assignments};")

    for table in sorted(SURROGATE_ID_TABLES):
        order_by = ORDER_BY[table]
        psql(
            url,
            "with ordered as ("
            f"select id, row_number() over (order by {order_by}) as rn from {table}"
            ") "
            f"update {table} t set id = -ordered.rn "
            "from ordered where t.id = ordered.id;",
        )
        psql(url, f"update {table} set id = -id;")
        psql(
            url,
            "select setval(pg_get_serial_sequence("
            f"'{table}', 'id'), coalesce((select max(id) from {table}), 1), true);",
        )


def export_table_pg(url: str, table: str, export_date: str) -> int:
    order_by = ORDER_BY[table]
    rows_text = psql(
        url,
        "select coalesce(jsonb_agg(to_jsonb(t)), '[]'::jsonb)::text "
        f"from (select * from {table} order by {order_by}) t;",
    )
    rows = json.loads(rows_text)
    payload: dict[str, Any] = {
        "table": table,
        "export_date": export_date,
        "row_count": len(rows),
        "rows": rows,
    }
    (EXPORT_DIR / f"{table}.json").write_text(
        json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(f"  export/{table}.json — {len(rows)} rows (PG-backed)")
    return len(rows)


def write_pg_exports(url: str) -> dict[str, int]:
    """Load schema+seed into PG, stabilize, export deterministic JSON. Returns row counts."""
    export_date = "2026-05-10"
    EXPORT_DIR.mkdir(exist_ok=True)
    load_database(url)
    stabilize_database(url, export_date)
    row_counts: dict[str, int] = {}
    for table in TABLE_ORDER:
        row_counts[table] = export_table_pg(url, table, export_date)

    manifest = {
        "project": "modelatlas",
        "description": "Comprehensive AI provider, model, plan, pricing, and endpoint database",
        "generated": export_date,
        "source": "seed.sql",
        "tables": TABLE_ORDER,
        "row_counts": row_counts,
        "total_rows": sum(row_counts.values()),
        "files": {
            "schema_sql": "schema.sql",
            "seed_sql": "seed.sql",
            "exports": {table: f"export/{table}.json" for table in TABLE_ORDER},
        },
    }
    (EXPORT_DIR / "manifest.json").write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print("Manifest: export/manifest.json")
    return row_counts


# ── Main ────────────────────────────────────────────────────────


def main() -> int:
    parser = argparse.ArgumentParser(description="Generate ModelAtlas JSON exports")
    parser.add_argument(
        "--database-url",
        default=os.environ.get("MODELATLAS_DATABASE_URL"),
        help="PostgreSQL URL for PG-backed deterministic exports",
    )
    parser.add_argument(
        "--verify",
        action="store_true",
        help="Export via PG, then run scripts/verify-release.py",
    )
    args = parser.parse_args()

    if args.database_url or args.verify:
        # PG-backed mode
        url = args.database_url
        with managed_database_url(url) as db_url:
            write_pg_exports(db_url)

        if args.verify:
            print("\n--- Running verify-release.py ---")
            verify = OUTDIR / "scripts" / "verify-release.py"
            if verify.exists():
                env = os.environ.copy()
                env["MODELATLAS_DATABASE_URL"] = db_url
                result = subprocess.run(
                    [sys.executable, str(verify)],
                    cwd=OUTDIR,
                    env=env,
                    text=True,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                )
                print(result.stdout)
                if result.stderr:
                    print(result.stderr, file=sys.stderr)
                if result.returncode != 0:
                    print("VERIFY_FAILED", file=sys.stderr)
                    return 1
                print("VERIFY_OK")
            else:
                print("scripts/verify-release.py not found, skipping verification")
    else:
        # Standalone regex mode
        table_data = parse_seed_file()
        row_counts = write_standalone_exports(table_data)

        manifest = {
            "project": "deerflow-modeldb",
            "description": "Comprehensive AI Provider / Model / Plan / Pricing Database for Hermes Modeler",
            "generated": "2026-05-10",
            "task_hash": "001-deerflow-modeldb",
            "tables": list(table_data.keys()),
            "total_literal_rows": sum(len(v["literal_rows"]) for v in table_data.values()),
            "total_dynamic_inserts": sum(len(v["subquery_blocks"]) for v in table_data.values()),
            "files": {
                "schema_sql": "schema.sql",
                "seed_sql": "seed.sql",
                "synthesis": "FINAL-SYNTHESIS.md",
            },
        }
        (EXPORT_DIR / "manifest.json").write_text(
            json.dumps(manifest, indent=2) + "\n", encoding="utf-8"
        )

        print(f"\nManifest: export/manifest.json")
        print("Standalone mode — exports from regex-parsed INSERT statements.")
        print("Use --database-url for PG-backed deterministic exports.")

    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        print(exc.stdout, file=sys.stderr)
        print(exc.stderr, file=sys.stderr)
        raise SystemExit(exc.returncode)
