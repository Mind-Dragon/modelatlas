# ModelAtlas — Architecture

## Overview

ModelAtlas is a PostgreSQL-backed registry of AI model providers, their models,
pricing, capabilities, and API endpoints. It operates as a Zero Human Company
using Hermes Agent's autonomous capabilities.

## Data Flow

```
External APIs                       ModelAtlas Repo
─────────────                       ─────────────

OpenRouter API ─┐
Together AI   ──┤
Fireworks     ──┤─── SCOUT ───→ .swarm/reports/scout-report.json
Groq          ──┤        │
HF Providers  ──┘        │
                          ▼
                 DEEP RESEARCH
                 (delegate_task × N)
                          │
                          ▼
                   ┌──────────┐
                   │ SYNTHESIS │
                   └────┬─────┘
                        │
                        ▼
              ┌──────────────────┐
              │  seed.sql        │
              │  export/*.json   │
              │  verify-release  │
              └────────┬─────────┘
                       │
                       ▼
              ┌──────────────────┐
              │ PR BOT           │
              │ auto/update-*    │
              │ → GitHub PR      │
              └──────────────────┘
```

## Component Architecture

### 1. Data Layer

```
PostgreSQL 16
  ├── providers          (25 rows, PK: id)
  ├── provider_plans     (115 rows, FK: providers.id)
  ├── models             (124 rows, FK: providers.id)
  ├── model_capabilities (158 rows, FK: models.id)
  ├── model_pricing      (44 rows, FK: models.id, provider_plans.id)
  ├── endpoints          (29 rows, FK: providers.id)
  ├── model_endpoint_map (215 rows, FK: models.id, endpoints.id)
  └── model_aliases      (11 rows, FK: models.id)
```

### 2. Export Layer

`generate-exports.py` reads `seed.sql`, parses INSERT statements, and writes
deterministic JSON to `export/*.json`. Two INSERT types:
- **Literal tuples**: parsed into JSON rows (providers, endpoints, plans, models)
- **Subquery-based**: documented as raw SQL (capabilities, pricing, endpoint map)

`scripts/verify-release.py` validates exports against a live PG instance.

### 3. Automation Layer (Hermes Cron)

| Job | Schedule | Type | Dependencies |
|-----|----------|------|-------------|
| scout | weekly Sun 02:00 UTC | script (no_agent) | OpenRouter API |
| gap-monitor | daily 06:00 UTC | script (no_agent) | export/*.json |
| deep-research | weekly Sun 04:00 UTC | agent | scout report |
| synthesis | weekly Sun 06:00 UTC | agent | research reports |
| pr-bot | weekly Sun 07:00 UTC | agent | updated seed.sql |
| issue-triage | daily 08:00 UTC | agent | GitHub issues |

### 4. CI/CD Layer

GitHub Actions validates every push to main and every PR:
1. `validate-sql`: loads schema + seed into PG, checks row counts, runs spot queries
2. `validate-exports`: regenerates exports, verifies file integrity

## Hermes Agent Integration

Skills required (created during setup):
- `modelatlas-scout` — OpenRouter API discovery + diff logic
- `modelatlas-research` — per-provider deep research workflow
- `modelatlas-synthesis` — SQL generation from research artifacts

Jobs created:
- 4 cron jobs (scout, gap-monitor, deep-research/synthesis/pr-bot chain, issue-triage)

## Security

- Scout script uses no API keys — OpenRouter public catalog is unauthenticated
- Deep research uses web_search only (no billing APIs)
- PR bot pushes to non-main branches only
- verify-release.py scans all files for secrets before release

## Freshness Targets

| Category | Update Cadence |
|----------|---------------|
| OpenRouter-managed models | Weekly (scout) |
| Major provider pricing | Weekly |
| Chinese provider models | Bi-weekly |
| Aggregator catalogs | Monthly |
| Long-tail providers | Monthly |
| Issue-driven corrections | Daily (issue triage) |
