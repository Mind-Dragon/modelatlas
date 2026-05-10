#!/usr/bin/env python3
"""Generate ModelAtlas SQL and JSON artifacts from FINAL-SYNTHESIS.md.

The synthesis file is the human-readable source. This script extracts SQL blocks,
splits DDL from DML, writes schema.sql and seed.sql, loads them into a temporary
PostgreSQL database, then exports every table to deterministic JSON.
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
from typing import Iterator

ROOT = Path(__file__).resolve().parent
SYNTHESIS_FILE = ROOT / "FINAL-SYNTHESIS.md"
EXPORT_DIR = ROOT / "export"
SCHEMA_FILE = ROOT / "schema.sql"
SEED_FILE = ROOT / "seed.sql"

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
        'model_id, endpoint_type::text collate "C", region collate "C", coalesce(plan_id, 0), '
        "effective_date, currency, price_per_1m_input_tokens, price_per_1m_output_tokens"
    ),
    "endpoints": 'provider_id collate "C", slug collate "C"',
    "model_endpoint_map": (
        'model_id, endpoint_id, coalesce(plan_id, 0), is_default desc, routing_weight, '
        'coalesce(notes, \'\') collate "C"'
    ),
    "model_aliases": 'model_id, alias collate "C"',
}
SURROGATE_ID_TABLES = {
    "model_capabilities",
    "model_pricing",
    "model_endpoint_map",
    "model_aliases",
}


def run(cmd: list[str], *, cwd: Path = ROOT, env: dict[str, str] | None = None) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        cmd,
        cwd=cwd,
        env=env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=True,
    )


def synthesis_date(content: str) -> str:
    match = re.search(r"Generated:\s*(\d{4}-\d{2}-\d{2})", content)
    if match:
        return match.group(1)
    match = re.search(r"Generated\s+(\d{4}-\d{2}-\d{2})", content)
    return match.group(1) if match else "unknown"


def sql_blocks(content: str) -> list[str]:
    return re.findall(r"```sql\n(.*?)\n```", content, re.DOTALL)


def split_sql_statements(sql: str) -> list[str]:
    statements: list[str] = []
    current: list[str] = []
    in_single_quote = False
    index = 0
    while index < len(sql):
        char = sql[index]
        current.append(char)
        if char == "'":
            next_char = sql[index + 1] if index + 1 < len(sql) else ""
            if in_single_quote and next_char == "'":
                current.append(next_char)
                index += 2
                continue
            in_single_quote = not in_single_quote
        elif char == ";" and not in_single_quote:
            statement = "".join(current).strip()
            if statement:
                statements.append(statement)
            current = []
        index += 1
    tail = "".join(current).strip()
    if tail:
        statements.append(tail)
    return statements


def strip_leading_comments(statement: str) -> str:
    lines = statement.strip().splitlines()
    while lines and (not lines[0].strip() or lines[0].strip().startswith("--")):
        lines.pop(0)
    return "\n".join(lines).strip()


def statement_keyword(statement: str) -> str:
    body = strip_leading_comments(statement)
    return body.split(None, 1)[0].upper() if body else ""


def insert_table(statement: str) -> str | None:
    body = strip_leading_comments(statement)
    match = re.match(r"INSERT\s+INTO\s+(\w+)", body, flags=re.IGNORECASE)
    return match.group(1) if match else None


def split_artifacts(content: str) -> tuple[list[str], dict[str, list[str]]]:
    ddl: list[str] = []
    dml_by_table: dict[str, list[str]] = {table: [] for table in TABLE_ORDER}
    unknown_dml: list[str] = []

    for block in sql_blocks(content):
        for statement in split_sql_statements(block):
            keyword = statement_keyword(statement)
            if not keyword:
                continue
            if keyword in {"CREATE", "ALTER", "DROP", "COMMENT"}:
                ddl.append(statement)
            elif keyword == "INSERT":
                table = insert_table(statement)
                if table in dml_by_table:
                    dml_by_table[table].append(statement)
                else:
                    unknown_dml.append(statement)
            elif keyword in {"BEGIN", "COMMIT"}:
                continue
            else:
                raise SystemExit(f"unclassified SQL statement starts with {keyword!r}: {strip_leading_comments(statement)[:80]}")

    if unknown_dml:
        tables = [insert_table(statement) or "unknown" for statement in unknown_dml]
        raise SystemExit(f"unknown DML target tables: {tables}")
    missing = [table for table in TABLE_ORDER if not dml_by_table[table]]
    if missing:
        raise SystemExit(f"missing DML for tables: {missing}")
    return ddl, dml_by_table


def write_sql_files(content: str) -> None:
    export_date = synthesis_date(content)
    ddl, dml_by_table = split_artifacts(content)

    SCHEMA_FILE.write_text(
        "-- ModelAtlas Schema\n"
        f"-- Generated {export_date} from FINAL-SYNTHESIS.md\n"
        "-- PostgreSQL-compatible DDL only. Load seed.sql after this file.\n\n"
        + "\n\n".join(ddl)
        + "\n",
        encoding="utf-8",
    )

    ordered_dml: list[str] = []
    for table in TABLE_ORDER:
        ordered_dml.extend(dml_by_table[table])
    SEED_FILE.write_text(
        "-- ModelAtlas Seed Data\n"
        f"-- Generated {export_date} from FINAL-SYNTHESIS.md\n"
        "-- Run AFTER schema.sql\n\n"
        "BEGIN;\n\n"
        + "\n\n".join(ordered_dml)
        + "\n\nCOMMIT;\n",
        encoding="utf-8",
    )
    print(f"Schema: {SCHEMA_FILE} ({len(ddl)} DDL statements)")
    print(f"Seed: {SEED_FILE} ({len(ordered_dml)} DML statements)")


@contextmanager
def managed_database_url(explicit_url: str | None) -> Iterator[str]:
    if explicit_url:
        yield explicit_url
        return

    missing = [cmd for cmd in ("initdb", "pg_ctl", "createdb", "psql") if shutil.which(cmd) is None]
    if missing:
        raise SystemExit(
            "PostgreSQL server tools are required to export JSON. Missing: " + ", ".join(missing)
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


def psql(url: str, sql: str) -> str:
    env = os.environ.copy()
    env["PGTZ"] = "UTC"
    return run(["psql", url, "-v", "ON_ERROR_STOP=1", "-At", "-c", sql], env=env).stdout.strip()


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


def export_table(url: str, table: str, export_date: str) -> tuple[int, dict[str, object]]:
    order_by = ORDER_BY[table]
    rows_text = psql(
        url,
        "select coalesce(jsonb_agg(to_jsonb(t)), '[]'::jsonb)::text "
        f"from (select * from {table} order by {order_by}) t;",
    )
    rows = json.loads(rows_text)
    payload: dict[str, object] = {
        "table": table,
        "export_date": export_date,
        "row_count": len(rows),
        "rows": rows,
    }
    (EXPORT_DIR / f"{table}.json").write_text(
        json.dumps(payload, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    return len(rows), payload


def write_json_exports(content: str, url: str) -> None:
    export_date = synthesis_date(content)
    EXPORT_DIR.mkdir(exist_ok=True)
    load_database(url)
    stabilize_database(url, export_date)
    row_counts: dict[str, int] = {}
    for table in TABLE_ORDER:
        row_count, _payload = export_table(url, table, export_date)
        row_counts[table] = row_count
        print(f"  export/{table}.json — {row_count} rows")

    manifest = {
        "project": "modelatlas",
        "description": "Comprehensive AI provider, model, plan, pricing, and endpoint database",
        "generated": export_date,
        "source": "FINAL-SYNTHESIS.md",
        "tables": TABLE_ORDER,
        "row_counts": row_counts,
        "total_rows": sum(row_counts.values()),
        "files": {
            "schema_sql": "schema.sql",
            "seed_sql": "seed.sql",
            "synthesis": "FINAL-SYNTHESIS.md",
            "exports": {table: f"export/{table}.json" for table in TABLE_ORDER},
        },
    }
    (EXPORT_DIR / "manifest.json").write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    print("Manifest: export/manifest.json")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--database-url",
        default=os.environ.get("MODELATLAS_DATABASE_URL"),
        help="Existing PostgreSQL database URL. Defaults to an isolated temporary local cluster.",
    )
    args = parser.parse_args()

    content = SYNTHESIS_FILE.read_text(encoding="utf-8")
    write_sql_files(content)
    with managed_database_url(args.database_url) as url:
        write_json_exports(content, url)
    print("Done")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        print(exc.stdout, file=sys.stderr)
        print(exc.stderr, file=sys.stderr)
        raise SystemExit(exc.returncode)
