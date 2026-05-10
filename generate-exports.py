#!/usr/bin/env python3
"""generate-exports.py — Extract SQL from FINAL-SYNTHESIS.md properly.

Extracts each complete ```sql block and writes:
  - schema.sql — all DDL (CREATE TYPE, CREATE TABLE, CREATE INDEX)
  - seed.sql — all DML (INSERT, SELECT used as subqueries)
  - export/*.json — per-table JSON data
"""

import json
import os
import re

OUTDIR = os.path.dirname(os.path.abspath(__file__))
SYNTHESIS_FILE = os.path.join(OUTDIR, "FINAL-SYNTHESIS.md")
EXPORT_DIR = os.path.join(OUTDIR, "export")
SCHEMA_FILE = os.path.join(OUTDIR, "schema.sql")
SEED_FILE = os.path.join(OUTDIR, "seed.sql")

os.makedirs(EXPORT_DIR, exist_ok=True)

with open(SYNTHESIS_FILE) as f:
    content = f.read()

# Extract each complete ```sql ... ``` block
sql_blocks = re.findall(r'```sql\n(.*?)\n```', content, re.DOTALL)

ddl_blocks = []
dml_blocks = []

for block in sql_blocks:
    stripped = block.strip()
    if not stripped:
        continue
    first_keyword = stripped.split()[0].upper() if stripped.split() else ""
    if first_keyword in ("CREATE", "--"):
        ddl_blocks.append(stripped)
    elif first_keyword in ("INSERT", "BEGIN", "COMMIT"):
        dml_blocks.append(stripped)
    else:
        # Mixed or unlabeled — detect content
        if "CREATE" in stripped:
            ddl_blocks.append(stripped)
        elif "INSERT" in stripped:
            dml_blocks.append(stripped)

# Write schema.sql
with open(SCHEMA_FILE, 'w') as f:
    f.write('-- DeerFlow ModelDB Schema\n')
    f.write('-- Generated 2026-05-09 from FINAL-SYNTHESIS.md\n')
    f.write('-- PostgreSQL-compatible DDL\n\n')
    f.write('\n\n'.join(ddl_blocks))
    f.write('\n')
print(f"Schema: {SCHEMA_FILE} ({len(ddl_blocks)} blocks)")

# Write seed.sql — wrap in transaction
with open(SEED_FILE, 'w') as f:
    f.write('-- DeerFlow ModelDB Seed Data\n')
    f.write('-- Generated 2026-05-09 from FINAL-SYNTHESIS.md\n')
    f.write('-- Run AFTER schema.sql\n\n')
    f.write("BEGIN;\n\n")
    f.write('\n\n'.join(dml_blocks))
    f.write("\n\nCOMMIT;\n")
print(f"Seed: {SEED_FILE} ({len(dml_blocks)} blocks)")

# Parse INSERT INTO ... VALUES into structured JSON
# Match: INSERT INTO table_name (col1, col2, ...) VALUES (...), (...), ...;
table_data = {}

for block in dml_blocks:
    # Each block may have multiple INSERT statements
    inserts = re.findall(
        r"INSERT INTO (\w+)\s*\(([^)]+)\)\s*VALUES\s*(.*?);",
        block, re.DOTALL
    )
    for table_name, columns_str, values_str in inserts:
        if table_name not in table_data:
            table_data[table_name] = {"columns": [], "rows": []}

        cols = [c.strip().strip('"') for c in columns_str.split(',')]
        if not table_data[table_name]["columns"]:
            table_data[table_name]["columns"] = cols

        # Parse value tuples
        # Handle multi-line tuples: ('val1', val2), ('val3', val4);
        # Also handle subquery-based VALUES like SELECT m.id, ...
        if values_str.strip().upper().startswith("SELECT"):
            # Subquery pattern — note as dynamic
            table_data[table_name].setdefault("dynamic_rows", []).append(values_str.strip())
        else:
            # Tuple pattern
            tuples = []
            depth = 0
            current = ""
            for ch in values_str:
                if ch == '(':
                    if depth == 0:
                        current = ""
                    depth += 1
                if depth > 0:
                    current += ch
                if ch == ')':
                    depth -= 1
                    if depth == 0 and current:
                        tuples.append(current.strip())
            for tup in tuples:
                # Simple CSV parse
                vals = []
                for v in tup.strip('()').split(','):
                    v = v.strip()
                    vals.append(v)
                table_data[table_name]["rows"].append(vals)

# Write JSON exports
for table_name, data in table_data.items():
    filepath = os.path.join(EXPORT_DIR, f"{table_name}.json")
    rows_json = []

    for row_vals in data.get("rows", []):
        obj = {}
        for i, col in enumerate(data["columns"]):
            val = row_vals[i] if i < len(row_vals) else None
            # Clean SQL literals
            if val is not None:
                val = val.strip()
                if val.upper() in ('NULL', ''):
                    val = None
                elif val.startswith("'") and val.endswith("'"):
                    val = val[1:-1]
                elif val.upper() == 'TRUE':
                    val = True
                elif val.upper() == 'FALSE':
                    val = False
                else:
                    # Try number
                    try:
                        if '.' in val:
                            val = float(val)
                        else:
                            val = int(val)
                    except (ValueError, TypeError):
                        pass
            obj[col] = val
        rows_json.append(obj)

    entry = {
        "table": table_name,
        "export_date": "2026-05-09",
        "columns": data["columns"],
        "row_count": len(rows_json),
        "dynamic_count": len(data.get("dynamic_rows", [])),
        "rows": rows_json
    }

    with open(filepath, 'w') as f:
        json.dump(entry, f, indent=2, default=str)
    print(f"  export/{table_name}.json — {len(rows_json)} rows parsed + {len(data.get('dynamic_rows', []))} dynamic blocks")

# Manifest
manifest = {
    "project": "deerflow-modeldb",
    "description": "Comprehensive AI Provider / Model / Plan / Pricing Database for Hermes Modeler",
    "generated": "2026-05-09",
    "task_hash": "001-deerflow-modeldb",
    "tables": list(table_data.keys()),
    "total_rows": sum(len(v["rows"]) + len(v.get("dynamic_rows", [])) for v in table_data.values()),
    "files": {
        "schema_sql": "schema.sql",
        "seed_sql": "seed.sql",
        "synthesis": "FINAL-SYNTHESIS.md",
    }
}

with open(os.path.join(EXPORT_DIR, "manifest.json"), 'w') as f:
    json.dump(manifest, f, indent=2)

print(f"\nManifest: export/manifest.json")
print(f"Done — {list(table_data.keys())}")
