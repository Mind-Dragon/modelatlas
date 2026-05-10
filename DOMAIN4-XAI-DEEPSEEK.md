# Domain 4: xAI (Grok) + DeepSeek

> Research hash: 001-deerflow-modeldb | Compiled: 2026-05-09
> Sources: xAI official docs, DeepSeek API docs, verified third-party analysis. USD pricing.

---

## Part A: xAI / Grok

### A1 — Plans & Access

| Plan | Price | What You Get |
|------|-------|-------------|
| Free (X) | $0 | Limited daily Grok messages on X.com / X app. No API access. |
| X Premium | $8/mo | Grok access + X platform features (blue check, longer posts). |
| X Premium+ | $40/mo | Higher Grok rate limits + ad-free X. |
| SuperGrok | $30/mo | Full Grok (app/grok.com): Grok 4 + 4.1, DeepSearch, Big Brain Mode, Imagine 1.0. |
| SuperGrok Heavy | $300/mo/seat | Grok 4 Heavy for intensive reasoning workloads. |
| Grok Business | $30/mo/seat | SuperGrok features + SOC 2, team admin, audit logs. |
| **API (pay-as-you-go)** | prepaid credits | Token-based billing, no subscription required. $25 free credits on signup. |

xAI also offers a data-sharing program that unlocks additional monthly credits (up to ~$150/mo).

### A2 — Models (Current)

| Model ID | Context | Input /1M | Output /1M | Notes |
|----------|---------|-----------|------------|-------|
| `grok-4.3` | 1M | $1.25 | $2.50 | New flagship. Lowest hallucination rate. Configurable reasoning effort. |
| `grok-4.20-0309-reasoning` | 2M | $1.25 | $2.50 | Reasoning mode. Multi-agent variant also available. |
| `grok-4.20-0309-non-reasoning` | 2M | $1.25 | $2.50 | Non-reasoning mode, same price. |
| `grok-4.20-multi-agent-0309` | 2M | $1.25 | $2.50 | 4 internal agents collaborating. |

### A2b — Models (Legacy / Retiring May 15, 2026)

| Model ID | Context | Input /1M | Output /1M | Notes |
|----------|---------|-----------|------------|-------|
| `grok-4-1-fast-reasoning` | 2M | $0.20 | $0.50 | Being retired. Best cost/context ratio while available. |
| `grok-4-1-fast-non-reasoning` | 2M | $0.20 | $0.50 | Same, non-reasoning variant. |
| `grok-4-fast-reasoning` | 2M | $0.20 | $0.50 | Retiring. |
| `grok-4-fast-non-reasoning` | 2M | $0.20 | $0.50 | Retiring. |
| `grok-4` | 256K | $3.00 | $15.00 | Retiring. |
| `grok-code-fast-1` | 256K | $0.20 | $1.50 | Retiring. |
| `grok-3` | 131K | $3.00 | $15.00 | Retiring. |
| `grok-3-mini` | 131K | $0.30 | $0.50 | Retiring. |

### A3 — Capabilities

| Capability | Supported | Details |
|------------|-----------|---------|
| Vision (image input) | Yes | 256-1792 tokens per image. All current text models accept images. |
| Tool calling | Yes | Server-side + client-side. Tools billed separately ($5/1K calls for search/code, $10/1K file attachments, $2.50/1K collections search). |
| Reasoning | Yes | Configurable via `reasoning_effort` on Grok 4.3. Reasoning tokens billed at output rate. |
| Streaming | Yes | SSE. Keep-alive comments during processing. |
| Voice API | Separate | Realtime voice agents at $0.05/min ($3/hr). TTS at $4.20/1M chars. STT at $0.10-0.20/hr. |
| Imagine API | Separate | Image gen $0.02-0.07/image. Video gen $0.05/sec. |
| Batch API | Yes | 20-50% off all token types. 24hr turnaround. Doesn't hit per-minute rate limits. |
| Prompt caching | Yes (auto) | Cached tokens billed at lower rate. Use `x-grok-conv-id` header to maximize hits. |
| Knowledge cutoff | November 2024 | No realtime events without web search / X search tools. |

### A4 — API Endpoint

```
Base URL: https://api.x.ai
Format:  OpenAI-compatible (drop-in for OpenAI SDKs) and Anthropic-compatible
Console: https://console.x.ai/
```

Regional endpoints: us-east-1 (US) or eu-west-1 (Europe).

### A5 — Rate Limits (API)

Tiered system based on cumulative spend since Jan 1, 2026:

| Tier | Spend Threshold | Approx. RPM | Approx. TPM |
|------|----------------|-------------|-------------|
| Tier 0 | $0 (default) | 60 | 100,000 |
| Tier 1 | $50 | scales up | scales up |
| Tier 2 | $250 | scales up | scales up |
| Tier 3 | $1,000 | ~2,000 | ~1,000,000 |
| Tier 4 | $5,000 | higher | higher |
| Enterprise | on request | custom | custom |

Tiers are permanent once unlocked. Counter resets annually. Overrides available via console.

### A6 — Tool Costs (Additive)

| Tool | Per 1K calls |
|------|-------------|
| Web Search | $5.00 |
| X Search | $5.00 |
| Code Execution | $5.00 |
| File Attachments | $10.00 |
| Collections Search (RAG) | $2.50 |
| Image / Video Understanding | token-based only |
| Remote MCP Tools | token-based only |

---

## Part B: DeepSeek

### B1 — Plans & Access

| Plan | Price | What You Get |
|------|-------|-------------|
| Web Chat | $0 | chat.deepseek.com + mobile app. No Plus/Pro tier needed. |
| API Free Tier | $0 (5M tokens) | 5 million free tokens for new accounts. 30-day expiry. No credit card required. |
| API Pay-as-you-go | prepaid balance | Token-based billing. No monthly fee, no minimum spend. |
| Token Plans | varies | Bulk token purchase options available through platform. |

**No subscription tiers required for API access.** All users get the same model access; pricing scales with usage.

### B2 — Models

#### Current (V4 Generation)

| Model ID | Context | Max Output | Cache Hit /1M | Cache Miss /1M | Output /1M | Notes |
|----------|---------|-----------|---------------|----------------|------------|-------|
| `deepseek-v4-flash` | 1M | 384K | $0.0028 | $0.14 | $0.28 | Fast workhorse. Thinking/non-thinking modes. |
| `deepseek-v4-pro` | 1M | 384K | $0.003625 | $0.435 | $0.87 | 75% off promo through 2026-05-31, then $1.74/$3.48 regular. |

Both V4 models support:
- Thinking mode (default, configurable) and non-thinking mode
- JSON output, tool calls, chat prefix completion (beta), FIM completion (beta, non-thinking only)
- Base URL: `https://api.deepseek.com` (OpenAI format) or `https://api.deepseek.com/anthropic` (Anthropic format)

#### Legacy (V3 generation — model IDs deprecated July 24, 2026)

| Model ID | Context | Max Output | Max CoT | Cache Hit /1M | Cache Miss /1M | Output /1M | Notes |
|----------|---------|-----------|---------|---------------|----------------|------------|-------|
| `deepseek-chat` (legacy) | 64K | 8K | N/A | $0.07 | $0.27 | $1.10 | Maps to V4 Flash non-thinking. |
| `deepseek-reasoner` (legacy) | 64K | 8K | 32K | $0.14 | $0.55 | $2.19 | Maps to V4 Flash thinking. Known as R1. |

#### Unreleased / Rumored

| Model | Status | Notes |
|-------|--------|-------|
| DeepSeek R2 | Not released | No official release as of May 2026. Manifold markets suggest possible 2026 window. |
| DeepSeek-Coder | No standalone API | Coder capabilities folded into V4 Flash/Pro. No separate coder-only API endpoint. |

### B3 — Key Model Specifications

| Spec | V4 Flash | V4 Pro | V3.2 Chat (legacy) | R1 Reasoner (legacy) |
|------|----------|--------|--------------------|----------------------|
| Context | 1,000,000 | 1,000,000 | 64,000 | 64,000 |
| Max output | 384,000 | 384,000 | 8,000 | 8,000 |
| Max CoT tokens | unlimited | unlimited | N/A | 32,000 |
| Training cutoff | ~2024 | ~2024 | Oct 2023 | Oct 2023 |
| Thinking mode | yes (default) | yes (default) | no | yes |
| Reasoning quality | good | excellent | moderate | excellent |

DeepSeek V4 Flash is the model currently serving in this session (deepseek-v4-flash provider=custom).

### B4 — Capabilities

| Capability | V4 Flash | V4 Pro | Notes |
|------------|----------|--------|-------|
| Reasoning (thinking) | Yes | Yes | On by default. Switchable per-call. |
| Tool calling | Yes | Yes | Function calling, tool use. |
| JSON output | Yes | Yes | Works in both thinking and non-thinking modes. |
| Streaming | Yes | Yes | SSE with keep-alive. |
| FIM completion | Yes (non-thinking) | Yes (non-thinking) | Fill-in-the-middle for code. |
| Vision | No | No | Text-only models currently. |
| Image generation | No | No | Not offered. |
| Prompt caching | Yes (auto) | Yes (auto) | 98% discount on cache hits. Prefix-based. |

### B5 — Pricing Summary (USD / 1M tokens)

| Model | Cache Hit Input | Cache Miss Input | Output | Context Cost Multiplier vs V4 Flash |
|-------|----------------|-----------------|--------|-------------------------------------|
| V4 Flash | $0.0028 | $0.14 | $0.28 | 1x (baseline) |
| V4 Pro (promo) | $0.0036 | $0.435 | $0.87 | ~3x |
| V4 Pro (regular) | $0.0145 | $1.74 | $3.48 | ~12x |
| deepseek-chat (legacy) | $0.07 | $0.27 | $1.10 | ~2x input, 4x output |
| deepseek-reasoner (legacy) | $0.14 | $0.55 | $2.19 | ~4x input, 8x output |

**Off-peak discount:** Additional 50-75% savings during 16:30-00:30 UTC (applies to V3 legacy models; may extend to V4).

**Comparative savings vs competitors:**
- V4 Flash: 35-100x cheaper than GPT-5.5, Claude Opus 4.7
- V4 Pro (promo): ~10x cheaper than GPT-5.5
- Record-low pricing in the industry

### B6 — Rate Limits

| Model | Limit Type | Detail |
|-------|-----------|--------|
| V4 Flash | Dynamic concurrency | No fixed RPM/TPM. Concurrency limited by server load. |
| V4 Pro | Dynamic concurrency | No fixed RPM/TPM. Concurrency limited by server load. |
| Legacy models | Dynamic concurrency | Same policy. |

DeepSeek does NOT publish hard rate limits. The API dynamically limits concurrency based on server load. On reaching the limit, you get HTTP 429. If inference hasn't started within 10 minutes, the server closes the connection.

No per-model rate limit tiers exist — spending more doesn't unlock higher caps in the documented sense, though in practice active accounts with sustained spend get better queue priority.

### B7 — API Endpoint

```
Base URL (OpenAI format):  https://api.deepseek.com
Base URL (Anthropic format): https://api.deepseek.com/anthropic
Format:                    OpenAI-compatible, Anthropic-compatible
Console:                   https://platform.deepseek.com
```

### B8 — Regional Differences (China vs International)

| Dimension | International API (api.deepseek.com) | China API |
|-----------|--------------------------------------|-----------|
| Endpoint | api.deepseek.com | Separate China endpoint |
| Pricing | USD, as listed above | CNY pricing, may differ |
| Censorship | Light content filtering on politically sensitive topics | Heavier alignment with China regulations |
| Model access | Same models, same capabilities | Same models |
| Data residency | Data processed per request region | China data residency |
| Registration | Open globally, no VPN needed | Chinese phone number or WeChat |

**Key concerns for enterprise use:**
- DeepSeek API does apply some content filtering aligned with Chinese regulations, though notably less than the open-source model weights
- US export controls on GPUs have influenced DeepSeek's training efficiency (more efficient architectures, not less capable models)
- No SOC 2 or equivalent compliance certifications available
- For sensitive workloads, consider self-hosting the open-weight models or routing through a third-party provider (OpenRouter, AWS Bedrock, Azure AI Foundry)

---

## Part C: Quick Comparison

| Dimension | xAI / Grok | DeepSeek |
|-----------|------------|----------|
| Cheapest input | $1.25/1M (Grok 4.3) | $0.14/1M (V4 Flash) |
| Cheapest output | $2.50/1M (Grok 4.3) | $0.28/1M (V4 Flash) |
| Cache hit input | varies (lower rate) | $0.0028/1M (98% off) |
| Largest context | 2M (Grok 4.20) | 1M (V4 Flash/Pro) |
| Max output | standard | 384K (both V4 models) |
| Vision | Yes (all current models) | No |
| Image gen | Yes (Imagine API) | No |
| Voice | Yes (Voice API) | No |
| Free tier | $25 API credits | 5M tokens free |
| Ratelimit model | Tiered by spend | Dynamic concurrency |
| API compatibility | OpenAI + Anthropic | OpenAI + Anthropic |
| Open weights | No | Yes (V3, R1, V4 planned?) |
| Enterprise compliance | SOC 2, GDPR, SSO | None published |
| US/Friendly data residency | Yes (us-east-1, eu-west-1) | China-based |

---

## Part D: Recommendations for Deerflow ModelDB

**For high-throughput agentic workloads (cost-sensitive):**
- DeepSeek V4 Flash at $0.14/$0.28 is 9x cheaper than Grok 4.3 on input
- Cache hits at $0.0028/1M are effectively free
- V4 Flash's 1M context and 384K output handle long agent chains

**For reasoning-heavy or vision-capable tasks:**
- Grok 4.3 at $1.25/$2.50 with 1M context + vision input
- DeepSeek V4 Pro (promo $0.435/$0.87) for deep reasoning without vision

**For the Hermes agent stack specifically:**
- Current provider (`custom` deepseek-v4-flash) is already optimal for cost
- xAI Grok 4.3 as fallback for vision tasks, tool-heavy agentic workflows
- Vault confirms Kimi for `/coding` routing; Grok 4.3 could supplement
