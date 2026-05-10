# ModelAtlas — Zero Human Company Operations Plan

## Mission

Autonomously discover, research, verify, and publish the world's most comprehensive
AI provider/model/pricing database. Zero human touch after setup.

## Roles

```
┌─────────────────────────────────────────────────────────────┐
│                     Weekly Cycle (Sunday UTC)                │
│                                                             │
│  SCOUT → DEEP RESEARCH → SYNTHESIS → PR BOT                 │
│                                                             │
│  GAP MONITOR (daily)                                        │
│  ISSUE TRIAGE (daily)                                       │
└─────────────────────────────────────────────────────────────┘
```

### Role 1: Scout (script, weekly)
**no_agent** cron job. Zero LLM cost.

Queries live API catalogs:
- OpenRouter /v1/providers (~70 providers, 400+ models)
- Together AI model list
- Fireworks AI model list
- Groq model list
- Hugging Face Inference Providers

Compares against current seed.sql. Writes structured diff:
- new providers not in database
- new models for existing providers
- pricing changes >10% delta
- deprecated/sunset models

### Role 2: Deep Research (subagents, weekly)
**Full agent** cron triggered by scout output.

For each new/changed provider, spawns a `delegate_task` subagent with:
- Structured prompt requiring exact output schema
- web_search + web_extract tools
- Required data: models, context windows, pricing tiers, capabilities,
  rate limits, API endpoints, auth methods, lifecycle dates

Each subagent writes a structured report to `.swarm/reports/<provider>.json`.

### Role 3: Synthesis (full agent, after research)
Reads all subagent reports. Generates:
- INSERT statements for new/updated records
- Updated `seed.sql`
- Runs `generate-exports.py` to regenerate all `export/*.json`
- Runs `scripts/verify-release.py` to validate

### Role 4: PR Bot (full agent, after synthesis)
- Creates branch `auto/update-YYYY-MM-DD`
- Commits changes
- Opens PR with auto-generated summary
- Tags PR with `automated-update`

### Role 5: Gap Monitor (script, daily)
**no_agent** cron. Runs validation queries against export JSONs:
- Providers with no pricing → flag
- Models with no capabilities → flag
- Deprecated models past sunset date → flag
- Orphaned endpoints (endpoint with no model mapping) → flag

### Role 6: Issue Triage (full agent, daily)
- Checks GitHub issues for `pricing-update` / `bug-report` labels
- For simple corrections (wrong price, missing model slug):
  auto-fixes and opens PR
- For complex issues: adds `needs-human-review` label

## Implementation Phases

### Phase 1 (now): Foundation
- [x] schema.sql / seed.sql split clean
- [x] generate-exports.py working
- [x] docker-compose.yml for PG
- [x] CI pipeline
- [ ] Scout script (Python, queries OpenRouter + aggregators)
- [ ] Gap Monitor script (validates export JSONs)

### Phase 2: Automation
- [ ] Weekly scout cron job
- [ ] Deep research skill for per-provider investigation
- [ ] Synthesis pipeline
- [ ] PR creation workflow

### Phase 3: Full Autonomy
- [ ] Issue triage cron
- [ ] Self-healing: detect and fix stale data
- [ ] Dashboard: status page showing data freshness
- [ ] Alert on provider pricing drops

## Key Skills to Create

TBD after Phase 1 script design.

## Repository Structure

```
modelatlas/
├── scripts/
│   ├── scout.py              # Phase 1: provider discovery
│   ├── gap-monitor.py        # Phase 1: data quality checks
│   ├── verify-release.py     # Release verification (PR)
│   └── research.py           # Phase 2: per-provider deep research
├── .swarm/
│   ├── reports/              # Research output artifacts
│   │   └── *.json
│   ├── domain1-openai.txt    # Research prompts
│   ├── ...
│   └── launch-deerflow-modeldb.sh
├── schema.sql
├── seed.sql
├── generate-exports.py
├── docker-compose.yml
├── export/
└── .github/workflows/
```
