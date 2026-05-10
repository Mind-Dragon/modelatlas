#!/usr/bin/env python3
"""Fail-closed release verification for ModelAtlas.

Checks that the checked-in database artifacts match the public README claims,
load into PostgreSQL, and do not expose obvious secrets or local machine paths.
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

ROOT = Path(__file__).resolve().parents[1]
EXPECTED_TABLES = [
    "providers",
    "provider_plans",
    "models",
    "model_capabilities",
    "model_pricing",
    "endpoints",
    "model_endpoint_map",
    "model_aliases",
]
MIN_COUNTS = {
    "providers": 25,
    "provider_plans": 100,
    "models": 80,
    "endpoints": 29,
}
SECRET_PATTERNS = {
    "private_key": re.compile(r"-----BEGIN (?:RSA |OPENSSH |EC |DSA )?PRIVATE KEY-----"),
    "aws_access_key": re.compile(r"AKIA[0-9A-Z]{16}"),
    "github_token": re.compile(r"\b(?:ghp|github_pat|gho|ghu|ghs|ghr)_[A-Za-z0-9_]{20,}\b"),
    "openai_like_key": re.compile(r"\bsk-[A-Za-z0-9_-]{20,}\b"),
    "jwt": re.compile(r"\beyJ[A-Za-z0-9_=-]+\.[A-Za-z0-9_=-]+\.[A-Za-z0-9_=-]+\b"),
}
PRIVATE_PATH_RE = re.compile(r"/(?:home|Users)/[A-Za-z0-9._-]+")


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


def fail(message: str) -> None:
    raise AssertionError(message)


def strip_sql_comments(sql: str) -> str:
    lines = []
    for line in sql.splitlines():
        stripped = line.strip()
        if stripped.startswith("--"):
            continue
        lines.append(line)
    return "\n".join(lines)


def current_branch_allows_history_scan() -> bool:
    return (ROOT / ".git").exists()


@contextmanager
def database_url(explicit_url: str | None):
    if explicit_url:
        yield explicit_url
        return

    for command in ("initdb", "pg_ctl", "createdb", "dropdb", "psql"):
        if shutil.which(command) is None:
            fail(f"PostgreSQL command missing: {command}")

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
    result = run(["psql", url, "-v", "ON_ERROR_STOP=1", "-At", "-c", sql])
    return result.stdout.strip()


def load_database(url: str) -> None:
    psql(url, "drop schema if exists public cascade; create schema public;")
    run(["psql", url, "-v", "ON_ERROR_STOP=1", "-f", "schema.sql"])
    run(["psql", url, "-v", "ON_ERROR_STOP=1", "-f", "seed.sql"])


def row_counts_from_database(url: str) -> dict[str, int]:
    counts: dict[str, int] = {}
    for table in EXPECTED_TABLES:
        counts[table] = int(psql(url, f"select count(*) from {table};"))
    return counts


def check_sql_split() -> None:
    schema = (ROOT / "schema.sql").read_text(encoding="utf-8")
    seed = (ROOT / "seed.sql").read_text(encoding="utf-8")
    schema_body = strip_sql_comments(schema)
    if re.search(r"\bINSERT\s+INTO\b", schema_body, re.IGNORECASE):
        fail("schema.sql contains INSERT statements; schema must be DDL only")
    if not re.search(r"\bCREATE\s+TABLE\s+providers\b", schema_body, re.IGNORECASE):
        fail("schema.sql does not create providers")
    tables = re.findall(r"\bINSERT\s+INTO\s+(\w+)", seed, flags=re.IGNORECASE)
    missing = [table for table in EXPECTED_TABLES if table not in tables]
    if missing:
        fail(f"seed.sql missing inserts for tables: {missing}")


def check_exports_and_manifest(counts: dict[str, int]) -> None:
    manifest = json.loads((ROOT / "export" / "manifest.json").read_text(encoding="utf-8"))
    if manifest.get("project") != "modelatlas":
        fail("manifest project must be modelatlas")
    if manifest.get("tables") != EXPECTED_TABLES:
        fail(f"manifest tables mismatch: {manifest.get('tables')}")
    manifest_counts = manifest.get("row_counts") or {}
    if manifest_counts != counts:
        fail(f"manifest row_counts mismatch: manifest={manifest_counts} db={counts}")
    if manifest.get("total_rows") != sum(counts.values()):
        fail("manifest total_rows does not match database counts")

    for table in EXPECTED_TABLES:
        path = ROOT / "export" / f"{table}.json"
        if not path.exists():
            fail(f"missing JSON export: {path.relative_to(ROOT)}")
        data = json.loads(path.read_text(encoding="utf-8"))
        rows = data.get("rows")
        if not isinstance(rows, list):
            fail(f"{path.relative_to(ROOT)} does not contain a rows array")
        if data.get("row_count") != counts[table] or len(rows) != counts[table]:
            fail(f"{table} export count mismatch")
    for table, minimum in MIN_COUNTS.items():
        if counts.get(table, 0) < minimum:
            fail(f"{table} has {counts.get(table, 0)} rows; expected at least {minimum}")


def check_docs(counts: dict[str, int]) -> None:
    readme = (ROOT / "README.md").read_text(encoding="utf-8")
    final = (ROOT / "FINAL-SYNTHESIS.md").read_text(encoding="utf-8")
    joined_docs = readme + "\n" + final
    if ".swarm" in readme:
        fail("README references .swarm, but .swarm is not published")
    if "DeerFlow ModelDB" in readme or "deerflow-modeldb" in readme:
        fail("README still exposes old DeerFlow ModelDB branding")
    if PRIVATE_PATH_RE.search(joined_docs):
        fail("public docs contain local absolute paths")
    for table, minimum in MIN_COUNTS.items():
        if counts[table] < minimum:
            fail(f"README claim impossible: {table} below {minimum}")
    if "Apache License 2.0" not in readme:
        fail("README must state Apache License 2.0")


def check_ci_workflow() -> None:
    workflows = list((ROOT / ".github" / "workflows").glob("*.yml")) + list(
        (ROOT / ".github" / "workflows").glob("*.yaml")
    )
    if not workflows:
        fail("missing GitHub Actions workflow")
    contents = "\n".join(path.read_text(encoding="utf-8") for path in workflows)
    for needle in ("generate-exports.py", "schema.sql", "seed.sql", "git diff --exit-code"):
        if needle not in contents:
            fail(f"CI workflow missing check: {needle}")


def iter_public_text_files() -> list[Path]:
    files = []
    for path in ROOT.rglob("*"):
        if ".git" in path.parts or path.is_dir():
            continue
        if path.suffix.lower() in {".md", ".py", ".sql", ".json", ".yml", ".yaml", ".txt"} or path.name in {
            ".gitignore",
            "LICENSE",
        }:
            files.append(path)
    return files


def check_public_safety() -> None:
    findings: list[str] = []
    for path in iter_public_text_files():
        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
        for index, line in enumerate(text.splitlines(), start=1):
            for name, pattern in SECRET_PATTERNS.items():
                if pattern.search(line):
                    findings.append(f"{path.relative_to(ROOT)}:{index}:{name}")
    if findings:
        fail("secret-like values found in public files: " + ", ".join(findings[:20]))

    if current_branch_allows_history_scan():
        output = run(["git", "rev-list", "--objects", "--all"]).stdout.splitlines()
        for entry in output:
            sha = entry.split(maxsplit=1)[0]
            blob = subprocess.run(
                ["git", "cat-file", "-p", sha],
                cwd=ROOT,
                stdout=subprocess.PIPE,
                stderr=subprocess.DEVNULL,
                check=False,
            ).stdout
            if b"\0" in blob[:4096]:
                continue
            for name, pattern in SECRET_PATTERNS.items():
                if pattern.search(blob.decode("utf-8", "ignore")):
                    fail(f"secret-like value found in git history blob {sha[:12]} ({name})")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--database-url", default=os.environ.get("MODELATLAS_DATABASE_URL"))
    args = parser.parse_args()

    check_sql_split()
    with database_url(args.database_url) as url:
        load_database(url)
        counts = row_counts_from_database(url)
    check_exports_and_manifest(counts)
    check_docs(counts)
    check_ci_workflow()
    check_public_safety()
    print("VERIFY_OK", json.dumps(counts, sort_keys=True))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except AssertionError as exc:
        print(f"VERIFY_FAIL: {exc}", file=sys.stderr)
        raise SystemExit(1)
