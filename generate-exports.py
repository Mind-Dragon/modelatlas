#!/usr/bin/env python3
"""generate-exports.py — Parse seed.sql and generate JSON exports.

Reads the standalone schema.sql and seed.sql files, extracts per-table
INSERT data, and writes export/*.json files. Handles both literal tuple
INSERTs and subquery-based INSERTs (documenting the latter as raw SQL).
"""

import json
import os
import re

OUTDIR = os.path.dirname(os.path.abspath(__file__))
SEED_FILE = os.path.join(OUTDIR, "seed.sql")
SCHEMA_FILE = os.path.join(OUTDIR, "schema.sql")
EXPORT_DIR = os.path.join(OUTDIR, "export")

os.makedirs(EXPORT_DIR, exist_ok=True)

# ── Parse seed.sql ──────────────────────────────────────────────
with open(SEED_FILE) as f:
    seed_text = f.read()

# Strip the outer BEGIN / COMMIT transaction wrapper
seed_text = re.sub(r'(?is)^\s*BEGIN;\s*', '', seed_text)
seed_text = re.sub(r'(?is)\s*COMMIT;\s*$', '', seed_text)

# Extract each INSERT statement
# Pattern: INSERT INTO table (cols) VALUES ...
#        or INSERT INTO table (cols) SELECT ...
insert_pattern = re.compile(
    r'INSERT\s+INTO\s+(\w+)\s*\(([^)]+)\)\s*(VALUES\s*.*?|SELECT\s+.*?);',
    re.DOTALL | re.IGNORECASE
)

table_data = {}  # table_name -> {columns, literal_rows, subquery_blocks}

for match in insert_pattern.finditer(seed_text):
    table_name = match.group(1)
    columns_str = match.group(2)
    body = match.group(3).strip()

    if table_name not in table_data:
        table_data[table_name] = {
            "columns": [],
            "literal_rows": [],
            "subquery_blocks": [],
        }

    cols = [c.strip().strip('"') for c in columns_str.split(',')]
    if not table_data[table_name]["columns"]:
        table_data[table_name]["columns"] = cols

    if body.upper().startswith("VALUES"):
        # Literal tuple INSERT  —  e.g. INSERT ... VALUES ('a', 1), ('b', 2);
        # Strip the VALUES keyword
        values_text = body[6:].strip().rstrip(';')

        # Parse top-level tuples, respecting nesting depth
        tuples = []
        depth = 0
        current = ""
        for ch in values_text:
            if ch == '(':
                if depth == 0:
                    current = "("
                else:
                    current += ch
                depth += 1
            elif ch == ')':
                current += ch
                depth -= 1
                if depth == 0:
                    tuples.append(current.strip())
            else:
                if depth > 0:
                    current += ch

        for tup in tuples:
            # Parse individual values inside the tuple, respecting quoted strings
            vals = []
            buf = ""
            in_string = False
            str_char = None
            for ch in tup.strip("()"):
                if in_string:
                    buf += ch
                    if ch == str_char and (len(buf) < 2 or buf[-2] != '\\'):
                        # end of string
                        str_char = None
                        in_string = False
                    continue
                if ch in ("'", '"'):
                    in_string = True
                    str_char = ch
                    buf += ch
                    continue
                if ch == ',':
                    vals.append(buf.strip())
                    buf = ""
                    continue
                buf += ch
            if buf.strip():
                vals.append(buf.strip())
            table_data[table_name]["literal_rows"].append(vals)

    elif body.upper().startswith("SELECT"):
        # Subquery-based INSERT — document the raw SQL
        table_data[table_name]["subquery_blocks"].append(body.rstrip(';').strip())

# ── Write JSON exports ──────────────────────────────────────────
total_literal = 0
total_dynamic = 0

for table_name, data in table_data.items():
    rows_json = []
    for row_vals in data["literal_rows"]:
        obj = {}
        for i, col in enumerate(data["columns"]):
            val = row_vals[i] if i < len(row_vals) else None
            if val is not None:
                val = val.strip()
                if val.upper() in ('NULL', ''):
                    val = None
                elif val.startswith("'") and val.endswith("'"):
                    val = val[1:-1]
                elif val.startswith('"') and val.endswith('"'):
                    val = val[1:-1]
                elif val.upper() == 'TRUE':
                    val = True
                elif val.upper() == 'FALSE':
                    val = False
                else:
                    try:
                        if '.' in val:
                            val = float(val)
                        else:
                            val = int(val)
                    except (ValueError, TypeError):
                        pass
            obj[col] = val
        rows_json.append(obj)

    total_literal += len(rows_json)
    total_dynamic += len(data["subquery_blocks"])

    entry = {
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
            "Run seed.sql in PostgreSQL to materialize. The raw SQL is "
            "included below for reference."
        )
        # Keep the raw SQL inline so downstream tooling can re-materialise
        entry["subquery_inserts"] = data["subquery_blocks"]

    filepath = os.path.join(EXPORT_DIR, f"{table_name}.json")
    with open(filepath, 'w') as f:
        json.dump(entry, f, indent=2, default=str)
    print(f"  export/{table_name}.json — {len(rows_json)} literal rows"
          f"{' + ' + str(len(data['subquery_blocks'])) + ' dynamic' if data['subquery_blocks'] else ''}")

# ── Manifest ────────────────────────────────────────────────────
manifest = {
    "project": "deerflow-modeldb",
    "description": "Comprehensive AI Provider / Model / Plan / Pricing Database for Hermes Modeler",
    "generated": "2026-05-10",
    "task_hash": "001-deerflow-modeldb",
    "tables": list(table_data.keys()),
    "total_literal_rows": total_literal,
    "total_dynamic_inserts": total_dynamic,
    "files": {
        "schema_sql": "schema.sql",
        "seed_sql": "seed.sql",
        "synthesis": "FINAL-SYNTHESIS.md",
    },
}

with open(os.path.join(EXPORT_DIR, "manifest.json"), 'w') as f:
    json.dump(manifest, f, indent=2)

print(f"\nManifest: export/manifest.json")
print(f"Done — {list(table_data.keys())}")
print(f"Literal rows: {total_literal}, Dynamic inserts: {total_dynamic}")
