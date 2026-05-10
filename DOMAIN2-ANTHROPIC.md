<!-- Task hash: 001-deerflow-modeldb -->
<!-- Domain: 2 — ANTHROPIC -->
<!-- Generated: 2026-05-09 -->

# Anthropic / Claude — Structured Reference

All prices in USD. Data drawn from `claude.com/pricing`, `platform.claude.com/docs`, and Anthropic announcements as of May 2026.

---

## 1. Plans

### Consumer & Team Plans (claude.ai chat interface)

| Plan | Price | Billing | Key Limits | Notes |
|------|-------|---------|------------|-------|
| **Free** | $0 | — | ~15–40 messages per 5-hour rolling window; tighter at peak hours | Web, iOS, Android, desktop. Includes memory, web search, extended thinking, remote MCP connectors, Slack/Google Workspace connectors |
| **Pro** | $20/mo | Monthly; $17/mo annual ($200 upfront) | ~45 messages per 5-hour window (≈5× Free); doubled for Claude Code as of May 2026 | Claude Code + Claude Cowork included. Unlimited projects. Research access. More model access. Claude for Microsoft 365 / Outlook |
| **Max 5×** | $100/mo | Monthly | ~5× Pro usage (~200 messages/5h) | Higher output limits. Early access. Priority at high traffic |
| **Max 20×** | $200/mo | Monthly | ~20× Pro usage (~900 messages/5h) | Same as Max 5×, larger budget |
| **Team Standard** | $25/mo per seat | Monthly; $20/seat/mo annual | More usage than Pro per seat | Min 5 seats. Claude Code + Cowork. SSO. Admin controls. Central billing. No training on content by default. Mix/match seat types |
| **Team Premium** | $125/mo per seat | Monthly; $100/seat/mo annual | 5× Standard seats | Same Team features, larger budget |
| **Enterprise (Self-Serve)** | $20/seat + API-rate usage | Annual only | Scales with usage | All Team features. Enterprise security. SCIM, audit logs, compliance API, HIPAA-ready offering, IP allowlisting |
| **Enterprise (Sales-Assisted)** | Custom | Custom | Custom | MSA, PO, usage commitments, bundling. AWS Marketplace available |

**Note on limits:** Consumer plan limits are token-budget based, not strict message counts. Message counts above are user-reported approximations. Limits reset on a rolling 5-hour window.

**May 2026 changes:** Anthropic doubled Claude Code 5-hour rate limits for Pro, Max, Team, and seat-based Enterprise; removed peak-hour reduction for Pro/Max; raised API rate limits for Claude Opus models.

### API Billing

| Billing Mode | Description |
|--------------|-------------|
| **API Credits** | Prepaid credits. Minimum $5 to start. Spend limits enforced by usage tier. Unused credits roll over month-to-month |
| **Monthly Invoicing** | Net-30 terms. No spend limit. Contact Sales to enable |
| **Usage Tiers** | Tier 1: $5 buy-in, $100/mo limit → Tier 4: $400 buy-in, $200K/mo limit. Limits auto-increase as you purchase more credits |

---

## 2. Models

### Claude 4 Family (Latest)

| Model | API ID (snapshot) | Context Window | Max Output | Reliable Knowledge Cutoff | Training Data Cutoff | Vision | Tool Use | Computer Use | Extended Thinking | Adaptive Thinking | Streaming |
|-------|-------------------|----------------|------------|---------------------------|----------------------|--------|----------|--------------|-------------------|-------------------|-----------|
| **Claude Opus 4.7** | `claude-opus-4-7` | 1M tokens | 128K tokens | Jan 2026 | Jan 2026 | Yes | Yes | Yes | No (manual removed) | Yes | Yes |
| **Claude Sonnet 4.6** | `claude-sonnet-4-6` | 1M tokens | 64K tokens | Aug 2025 | Jan 2026 | Yes | Yes | Yes | Yes | Yes | Yes |
| **Claude Haiku 4.5** | `claude-haiku-4-5-20251001` | 200K tokens | 64K tokens | Feb 2025 | Jul 2025 | Yes | Yes | Yes | No | No | Yes |

**Notes:**
- Opus 4.7 uses a new tokenizer that may produce up to ~35% more tokens for the same text vs earlier models.
- On Message Batches API, Opus 4.7/4.6 and Sonnet 4.6 support up to 300K output tokens with the `output-300k-2026-03-24` beta header.
- All Claude 4 models support parallel tool execution.

### Claude 3.5 Family

| Model | API ID (snapshot) | Context Window | Max Output | Knowledge Cutoff | Vision | Tool Use | Computer Use | Extended Thinking | Streaming |
|-------|-------------------|----------------|------------|------------------|--------|----------|--------------|-------------------|-----------|
| **Claude 3.5 Sonnet** | `claude-3-5-sonnet-20241022` | 200K tokens | 8,192 tokens | Apr 2024 | Yes | Yes | Yes | No | Yes |
| **Claude 3.5 Haiku** | `claude-3-5-haiku-20241022` | 200K tokens | 8,192 tokens | Jul 2024 | Yes | Yes | No | No | Yes |

### Claude 3 Family

| Model | API ID (snapshot) | Context Window | Max Output | Knowledge Cutoff | Vision | Tool Use | Computer Use | Extended Thinking | Streaming |
|-------|-------------------|----------------|------------|------------------|--------|----------|--------------|-------------------|-----------|
| **Claude 3 Opus** | `claude-3-opus-20240229` | 200K tokens | 4,096 tokens | Aug 2023 | Yes | Yes | No | No | Yes |
| **Claude 3 Sonnet** | `claude-3-sonnet-20240229` | 200K tokens | 4,096 tokens | Aug 2023 | Yes | Yes | No | No | Yes |
| **Claude 3 Haiku** | `claude-3-haiku-20240307` | 200K tokens | 4,096 tokens | Aug 2023 | Yes | Yes | No | No | Yes |

**Vision support:** All models support images and PDFs as input. Image/PDF tokens are counted toward context window and billed as input tokens.

---

## 3. API Pricing (per 1M tokens)

### Current Models

| Model | Input | Output | Cache Write | Cache Read | Batch Input | Batch Output |
|-------|-------|--------|-------------|------------|-------------|--------------|
| **Opus 4.7** | $5.00 | $25.00 | $6.25 | $0.50 | $2.50 | $12.50 |
| **Opus 4.6** | $5.00 | $25.00 | $6.25 | $0.50 | $2.50 | $12.50 |
| **Opus 4.5** | $5.00 | $25.00 | $6.25 | $0.50 | $2.50 | $12.50 |
| **Opus 4.1** | $15.00 | $75.00 | $18.75 | $1.50 | $7.50 | $37.50 |
| **Opus 4** | $15.00 | $75.00 | $18.75 | $1.50 | $7.50 | $37.50 |
| **Sonnet 4.6** | $3.00 | $15.00 | $3.75 | $0.30 | $1.50 | $7.50 |
| **Sonnet 4.5** | $3.00 | $15.00 | $3.75 | $0.30 | $1.50 | $7.50 |
| **Sonnet 4** | $3.00 | $15.00 | $3.75 | $0.30 | $1.50 | $7.50 |
| **Haiku 4.5** | $1.00 | $5.00 | $1.25 | $0.10 | $0.50 | $2.50 |
| **Haiku 3.5** | $0.80 | $4.00 | $1.00 | $0.08 | $0.40 | $2.00 |
| **Haiku 3** | $0.25 | $1.25 | $0.30 | $0.03 | $0.125 | $0.625 |

### Prompt Caching Details

| Cache Mode | Multiplier | Duration | Break-even |
|------------|------------|----------|------------|
| 5-minute cache write | 1.25× base input | 5 min | 1 cache read |
| 1-hour cache write | 2.0× base input | 1 hour | 2 cache reads |
| Cache read (hit) | 0.1× base input | Matches write duration | — |

**How it works:** Only `input_tokens` (after last cache breakpoint) and `cache_creation_input_tokens` count toward ITPM rate limits. `cache_read_input_tokens` do NOT count toward ITPM.

### Fast Mode Pricing (Beta)

Available on **Claude Opus 4.6** only:
- **$30 / MTok input**
- **$150 / MTok output**
- 6× standard rates across full context window
- Stacks with prompt caching and data residency multipliers
- Not available with Batch API

### Data Residency Pricing

For Opus 4.7/4.6 and newer models:
- **US-only inference** via `inference_geo=us` parameter: **1.1× multiplier** on all token pricing
- Global routing (default): standard pricing

### Additional Tool/Feature Fees

| Feature | Price |
|---------|-------|
| Web Search | $10 per 1,000 searches (plus standard token costs) |
| Code Execution | 50 free hours/day/org; then $0.05/hour/container |
| Managed Agents runtime | $0.08/session-hour active runtime |

---

## 4. Rate Limits

### API Rate Limits by Model (Max Limits)

Limits scale with usage tier. Default Tier 1 starts at lower values and auto-increases as you purchase credits.

| Model Family | Max RPM | Max ITPM | Max OTPM |
|--------------|---------|----------|----------|
| **Claude Opus 4.x** | 50 | 500,000 | 80,000 |
| **Claude Sonnet 4.x** | 50 | 30,000 | 8,000 |
| **Claude Haiku 4.5** | 50 | 50,000 | 10,000 |

**Notes:**
- Opus 4.x limit = combined across Opus 4.7, 4.6, 4.5, 4.1, 4
- Sonnet 4.x limit = combined across Sonnet 4.6, 4.5, 4
- Token bucket algorithm: capacity replenishes continuously, not at fixed intervals
- Rate limits are shared across all `inference_geo` values (`us` and `global` share the same pool)
- Concurrent requests: not published as a separate hard limit; bounded by RPM and token bucket

### API Spend Limits by Tier

| Tier | Credit Purchase Required | Max Single Purchase | Monthly Spend Limit |
|------|--------------------------|---------------------|---------------------|
| Tier 1 | $5 | $100 | $100 |
| Tier 2 | $40 | $500 | $500 |
| Tier 3 | $200 | $1,000 | $1,000 |
| Tier 4 | $400 | $200,000 | $200,000 |
| Monthly Invoicing | N/A | N/A | Unlimited |

### Consumer Plan Limits (claude.ai / Claude Code)

| Plan | Approx. Budget per 5h Window | Approx. Claude Code Budget per 5h (post-May 2026) |
|------|------------------------------|---------------------------------------------------|
| **Free** | ~15–40 messages | Limited |
| **Pro** | ~45 messages (~5× Free) | ~Doubled from prior baseline |
| **Max 5×** | ~200 messages (~5× Pro) | ~Doubled |
| **Max 20×** | ~900 messages (~20× Pro) | ~Doubled |
| **Team Standard** | More than Pro per seat | ~Doubled |
| **Team Premium** | 5× Standard seat | ~Doubled |

**Important:** Consumer limits are token-budget based, not fixed message counts. Complex prompts with long outputs consume the budget faster. Figures above are community-reported approximations.

---

## 5. API Endpoints

### Primary Anthropic API

| Endpoint | URL | Version Header |
|----------|-----|----------------|
| Messages | `https://api.anthropic.com/v1/messages` | `anthropic-version: 2023-06-01` |
| Message Batches | `https://api.anthropic.com/v1/messages/batches` | `anthropic-version: 2023-06-01` |
| Models List | `https://api.anthropic.com/v1/models` | `anthropic-version: 2023-06-01` |
| Token Counting | `https://api.anthropic.com/v1/messages/count_tokens` | `anthropic-version: 2023-06-01` |

**Auth:** `x-api-key: <API_KEY>` header required on all requests.

### Cloud Platform Endpoints

| Platform | Endpoint Style | Notes |
|----------|----------------|-------|
| **AWS Bedrock** | Regional (`us-east-1`, `us-west-2`, `eu-west-3`, etc.) | Uses Bedrock InvokeModel API. Model IDs: `anthropic.claude-opus-4-7`, `anthropic.claude-sonnet-4-6`, etc. |
| **Google Vertex AI** | Global, multi-region, and regional endpoints | Model IDs: `claude-opus-4-7`, `claude-sonnet-4-6`, `claude-haiku-4-5@20251001` |
| **Microsoft Azure AI Foundry** | Regional endpoints | Entra ID or API key auth |

### Data Residency Parameter

For US-only inference on Anthropic's direct API:
- Parameter: `inference_geo: "us"`
- Cost: 1.1× standard pricing
- Not available on Message Batches API

---

## 6. Message Batches API

| Attribute | Detail |
|-----------|--------|
| **Purpose** | Asynchronous processing of large volumes of Messages requests |
| **Discount** | **50% off** both input and output tokens vs standard rates |
| **Max requests per batch** | 100,000 |
| **Max requests in processing queue** | 100,000 |
| **Max RPM** | 50 (shared across all models) |
| **Turnaround** | 24 hours (target) |
| **Endpoint** | `POST /v1/messages/batches` |
| **Status checks** | `GET /v1/messages/batches/{batch_id}` |
| **Results** | Fetched via `GET /v1/messages/batches/{batch_id}/results` |

**Not supported with:**
- Fast mode
- Streaming responses
- Real-time / interactive workloads

**Best for:** Content generation pipelines, data labeling, bulk classification, audience research, backfill jobs.

---

## 7. 2026 Changes Summary

| Date | Change |
|------|--------|
| **Apr 2026** | Claude Opus 4.7 released. New tokenizer, 1M context, 128K output, adaptive thinking replaces manual extended thinking |
| **May 6, 2026** | Doubled Claude Code 5-hour rate limits for Pro, Max, Team, seat-based Enterprise |
| **May 6, 2026** | Removed peak-hour limit reduction on Claude Code for Pro/Max |
| **May 6, 2026** | Raised API rate limits considerably for Claude Opus models |
| **May 6, 2026** | SpaceX compute partnership announced: 300+ MW, 220K+ NVIDIA GPUs |
| **Ongoing 2026** | International expansion via Amazon (Asia, Europe); Google/Broadcom 5 GW for 2027; Microsoft/NVIDIA Azure partnership |
| **Mar–Apr 2026** | Earlier in the year, consumer limits were tightened significantly before the May capacity expansion |

---

## 8. Quick Reference: Model IDs

| Model | Claude API ID | Alias |
|-------|---------------|-------|
| Opus 4.7 | `claude-opus-4-7` | — |
| Sonnet 4.6 | `claude-sonnet-4-6` | — |
| Haiku 4.5 | `claude-haiku-4-5-20251001` | `claude-haiku-4-5` |
| 3.5 Sonnet | `claude-3-5-sonnet-20241022` | — |
| 3.5 Haiku | `claude-3-5-haiku-20241022` | — |
| 3 Opus | `claude-3-opus-20240229` | — |
| 3 Sonnet | `claude-3-sonnet-20240229` | — |
| 3 Haiku | `claude-3-haiku-20240307` | — |

All IDs are pinned snapshots. Dated IDs resolve to fixed releases.

---

*Source of truth: platform.claude.com/docs and claude.com/pricing. Verify current rates before committing to cost estimates.*
