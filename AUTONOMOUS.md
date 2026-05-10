# ModelAtlas Autonomous Rules

## Swarm boundary

No swarm may operate on this project until PROJECT.yaml passes project-doctor
and the suite lock is clean.

## Rules

- No push without explicit approval.
- No external mutation without explicit approval.
- Controller owns final verification.
- Subagents are advisory until verified.
- Scout script (scout.py) is the only automated external caller. It hits
  read-only public API endpoints (OpenRouter, aggregator catalogs).
- verify-release.py must pass before any commit that changes schema.sql,
  seed.sql, or export/*.json.
- Gap monitor is read-only. It never modifies data.
- All automated PRs go to non-main branches with `automated-update` label.
