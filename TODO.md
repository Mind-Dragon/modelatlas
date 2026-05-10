# ModelAtlas — Zero Human Company TODO

## Phase 1: Foundation (current)

### P1.1 Scout script
**File:** `scripts/scout.py`
**Type:** Python script, no agent needed
**Depends on:** nothing

- [ ] Query OpenRouter /v1/providers catalog
- [ ] Query Together AI model list via their API
- [ ] Query Fireworks AI model list via their API
- [ ] Query Groq model list via their API
- [ ] Parse current seed.sql to extract known providers + models
- [ ] Diff engine: new providers, new models, pricing deltas >10%, deprecated models
- [ ] Write structured diff report to `.swarm/reports/scout-report.json`
- [ ] CLI: `python3 scripts/scout.py` → writes report, exits 0 if no changes, 1 if changes found

### P1.2 Gap Monitor script
**File:** `scripts/gap-monitor.py`
**Type:** Python script, no agent needed
**Depends on:** P1.1 (for consistent report format)

- [ ] Read export/*.json files
- [ ] Check: providers with zero pricing records → flag
- [ ] Check: models with no capabilities → flag
- [ ] Check: models past sunset_date still marked active → flag
- [ ] Check: endpoints with no model_endpoint_map entries → flag
- [ ] Check: providers with zero models → flag
- [ ] Write gap report to `.swarm/reports/gap-report.json`
- [ ] CLI: `python3 scripts/gap-monitor.py` → writes report, exits 0 if no gaps, 1 if gaps found

### P1.3 `.swarm/reports/` directory
- [ ] Create `.swarm/reports/` directory
- [ ] Add `.gitignore` entry to keep reports local (not committed)

---

## Phase 2: Automation

### P2.1 Weekly scout cron
**Type:** cron job, no_agent=True
**Script:** `scripts/scout.py`
**Depends on:** P1.1

- [ ] Create cron job: weekly Sunday 02:00 UTC
- [ ] Cron runs scout.py, saves report
- [ ] If scout finds changes → trigger P2.2 (deep research)
- [ ] If no changes → silent exit (deliver=local)

### P2.2 Deep research skill
**File:** skill `modelatlas-research`
**Type:** Hermes skill
**Depends on:** P2.1

- [ ] Create skill: structured per-provider research workflow
- [ ] Skill prompt specifies exact output schema per provider:
  - models (slug, display_name, context_window, max_output)
  - pricing per model (input, output, cached, batch)
  - capabilities (vision, tool_use, streaming, reasoning, etc.)
  - API endpoints (base URL, auth method, version)
  - rate limits (RPM, TPM, concurrent)
  - lifecycle dates (released, deprecated, sunset)
- [ ] Each field must cite a source URL
- [ ] Skill runs as delegate_task subagent with web_search + web_extract tools
- [ ] Output: `.swarm/reports/<provider>.json`

### P2.3 Synthesis pipeline
**Type:** Hermes skill + script
**Depends on:** P2.2

- [ ] Create script `scripts/synthesize.py` that reads `.swarm/reports/*.json`
- [ ] Generates INSERT statements for new/updated records
- [ ] Validates against existing seed.sql (no duplicate providers)
- [ ] Produces updated `seed.sql`
- [ ] Runs `python3 generate-exports.py` to regenerate exports
- [ ] Runs `python3 scripts/verify-release.py` to validate
- [ ] Writes status to `.swarm/reports/synthesis-result.json`

### P2.4 PR creation workflow
**Type:** cron job, full agent
**Depends on:** P2.3

- [ ] Create cron job: runs after synthesis (weekly Sunday ~06:00 UTC)
- [ ] Reads synthesis-result.json
- [ ] Creates branch `auto/update-YYYY-MM-DD`
- [ ] Commits updated files
- [ ] Opens PR with auto-generated summary listing:
  - New providers added
  - New models added
  - Pricing changes detected
  - Deprecations/sunsets applied
  - Gap report summary
- [ ] Tags PR with label `automated-update`

### P2.5 Weekly automation chain cron
**Type:** cron job, full agent
**Depends on:** P2.1, P2.2, P2.3, P2.4

- [ ] Create orchestrator cron: weekly Sunday 02:00 UTC
- [ ] Prompt calls scout → research → synthesis → PR in sequence
- [ ] Each step checks previous step's output before proceeding
- [ ] On failure at any step: report with diagnostics, do not cascade

---

## Phase 3: Full Autonomy

### P3.1 Issue triage cron
**Type:** cron job, full agent
**Depends on:** P2.5

- [ ] Create cron: daily 08:00 UTC
- [ ] Checks GitHub issues for labels: `pricing-update`, `bug-report`, `provider-request`
- [ ] For pricing corrections: verify source, update seed.sql, open PR
- [ ] For provider requests: run scout just for that provider, open PR
- [ ] For complex issues: add `needs-human-review` label with summary
- [ ] Report daily: issues processed, fixed, escalated

### P3.2 Self-healing
**Type:** cron job, full agent
**Depends on:** P3.1

- [ ] Run gap-monitor.py daily
- [ ] If gaps found and auto-fixable (missing pricing = copy from aggregator), fix and PR
- [ ] If gaps not auto-fixable (missing capability data), escalate via issue

### P3.3 Dashboard (status page)
**Type:** static HTML/JSON page
**Depends on:** P3.2

- [ ] Generate `STATUS.md` with:
  - Last scout run date
  - Provider count trends (this week vs last)
  - Open gaps count
  - Recent updates (last 7 days)
  - Data freshness per provider
- [ ] Update on every successful PR merge
- [ ] Serve via GitHub Pages or GH raw

### P3.4 Pricing drop alerts
**Type:** cron job
**Depends on:** P2.1

- [ ] Scout report detects pricing drops >25% from what's in seed.sql
- [ ] Flag with priority for immediate PR (don't wait for weekly cycle)
- [ ] Open fast-track PR within 1 hour of detection

---

## Skills to Create

| Skill | Phase | Purpose |
|-------|-------|---------|
| `modelatlas-research` | P2.2 | Per-provider structured deep research |
| `modelatlas-synthesis` | P2.3 | Merge research reports into seed.sql |
| `modelatlas-pr-bot` | P2.4 | Branch + commit + PR automation |
| `modelatlas-issue-triage` | P3.1 | GitHub issue triage and auto-fix |

---

## Key Milestones

| Milestone | What it means |
|-----------|---------------|
| P1 done | Scout + gap monitor scripts work; we can detect what's missing |
| P2 done | Weekly cycle runs autonomously: scout → research → PR |
| P3 done | Full ZHC: discovers, researches, publishes, triages, alerts |

---

## Quick Reference: File Locations

```
scripts/
├── scout.py              # P1.1 Provider discovery
├── gap-monitor.py        # P1.2 Data quality checks
├── verify-release.py     # [done] Release verification
├── synthesize.py         # P2.3 Research → SQL

.swarm/
├── reports/              # All runtime artifacts (gitignored)
│   ├── scout-report.json
│   ├── gap-report.json
│   ├── <provider>.json   # Per-provider research
│   └── synthesis-result.json
├── domain*.txt           # Research prompts
└── launch-deerflow-modeldb.sh
```
