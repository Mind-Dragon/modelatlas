# DOMAIN1-OPENAI
Task hash: 001-deerflow-modeldb
Verified: 2026-05-09

Legend: `Tools` means Responses API tool support. `Img` means image generation support, either native or via tool use. `Audio` means native audio input/output support. `n/a` means not published or not applicable. OpenAI does not publish concurrent-connection ceilings in the public pages I checked.

Caveat: `platform.openai.com/account/limits` currently resolves to a login gate. The rate-limit data below comes from public model pages, pricing pages, and help-center articles.

## ChatGPT plans and billing

### Subscription plans

| Plan | Public price | Billing model | Current access / cap | Notes |
|---|---:|---|---|---|
| Free | $0/mo | Consumer subscription | GPT-5.5 Instant default; 10 messages / 5 hours | Falls back to mini after limit |
| Go | $8/mo | Consumer subscription | GPT-5.5 Instant; 160 messages / 3 hours; Thinking 10 messages / 5 hours | Global rollout started Jan 16, 2026; ads testing may appear |
| Plus | $20/mo | Consumer subscription | GPT-5.5 Instant + Thinking; 160 messages / 3 hours; Thinking up to 3,000 / week | Codex included; no annual billing |
| Pro (lower tier) | $100/mo | Consumer subscription | Higher limits than Plus; GPT-5.5 Pro access | Help docs also document this lower Pro tier |
| Pro (top tier) | $200/mo | Consumer subscription | Highest Pro tier; 20x Plus usage | This is the tier you asked for |
| Business (Team legacy) | $20/user/mo annual, $25/user/mo monthly | Team / business workspace | Virtually unlimited base-model access; GPT-5.5 Thinking 3,000 / week; GPT-5.5 Pro 15 / month | Team was renamed to Business on Aug 29, 2025 |
| Enterprise | Custom | Enterprise contract | Unlimited base-model access; flexible/credit-based advanced features; 10-region data residency | Edu follows a similar flexible-pricing model |

Note: ChatGPT subscriptions do not include API access. API usage is billed separately through API keys and credits.

### API / credit billing modes

| System | What it is | Cost / terms | Validity / cap | Notes |
|---|---|---|---|---|
| Prepaid API billing | Pre-purchase API credits | Minimum purchase $5, default $10 | Credits expire after 12 months; non-refundable | New accounts are enrolled in prepaid billing |
| Monthly API billing | Legacy monthly invoice flow | Credits can be purchased upfront and the invoice is offset | Same trust-tier caps apply | Still supported for existing accounts |
| Business flexible pricing | Credits for advanced ChatGPT features | Purchased by workspace owners or added automatically when limits are exceeded | Business credits valid 12 months | Credits apply to advanced models/features only |
| Enterprise / Edu flexible pricing | Contract-level credits | Purchased through the account team | Contract-defined | Shared pool; admins can set overage caps |
| Codex pay-as-you-go seats | Usage-based Codex-only seats | No fixed seat fee | Token-consumption based | Added Apr 2, 2026 for Business / Enterprise |

### API usage tier reference

| Tier | Qualification | Monthly usage cap |
|---|---|---:|
| Free | Allowed geography required | $100 / month |
| Tier 1 | $5 paid | $100 / month |
| Tier 2 | $50 paid + 7 days since first payment | $500 / month |
| Tier 3 | $100 paid + 7 days since first payment | $1,000 / month |
| Tier 4 | $250 paid + 14 days since first payment | $5,000 / month |
| Tier 5 | $1,000 paid + 30 days since first payment | $200,000 / month |

### Flexible credit rate card

| Item | Unit | Credits (~) | Notes |
|---|---|---:|---|
| GPT-5.5 Instant | 1 message | Unlimited | Core chat, no credits deducted |
| GPT-5.5 Thinking | 1 message | 10 | Business / Enterprise / Edu rate card |
| GPT-5.5 Pro | 1 message | 50 | Business / Enterprise / Edu rate card |
| GPT-5.2 | 1 message | Unlimited | Included on Business / Enterprise / Edu |
| GPT-5.2 Thinking | 1 message | 10 | Flexible pricing |
| GPT-5.2 Pro | 1 message | 50 | Flexible pricing |
| GPT-5 Thinking mini | 1 message | Unlimited | Auto-router mini model, no credits |
| Agent | 1 message | 30 | ChatGPT Business / Enterprise / Edu |
| Deep research | 1 task | 50 | ChatGPT Business / Enterprise / Edu |
| Image generation | 1 generation | 5 | ChatGPT Business / Enterprise / Edu |
| Voice | 1 minute | 5 | ChatGPT Business / Enterprise / Edu |
| o3 | 1 message | 10 | Legacy model row in the rate card |
| o3-pro | 1 message | 50 | Legacy model row in the rate card |
| ChatGPT for Excel / Sheets (GPT-5.5) | 1M input tokens | 125 | Cached input 12.5, output 750 credits |

### Current ChatGPT model caps

| Plan | GPT-5.5 Instant | GPT-5.5 Thinking | GPT-5.5 Pro | Notes |
|---|---|---|---|---|
| Free | 10 msgs / 5h | n/a | n/a | GPT-5.5 Instant default |
| Go | 160 msgs / 3h | 10 msgs / 5h | n/a | Lower-cost consumer tier |
| Plus | 160 msgs / 3h | up to 3,000 / week | n/a | Thinking only when manually selected |
| Pro (lower tier) | Higher than Plus | Higher than Plus | Yes | 5x Plus usage; 10x Codex promo through May 31, 2026 |
| Pro (top tier) | 20x Plus | Higher than Plus | Yes | 25x Codex 5-hour limit promo through May 31, 2026 |
| Business | Virtually unlimited | 3,000 / week | 15 / month | Business flexible pricing uses credits for advanced features |
| Enterprise / Edu | Unlimited | Flexible / credit-based | Flexible / credit-based | Data residency available on Enterprise |

### ChatGPT model retirements

| Date | Change | Impact |
|---|---|---|
| 2026-02-13 | GPT-4o, GPT-4.1, GPT-4.1 mini, o4-mini, and GPT-5 Instant/Thinking retired from ChatGPT | API access unchanged |
| 2026-04-03 | GPT-4o fully retired across all ChatGPT plans and custom GPTs | API unchanged |

## API endpoints and auth

| Surface | Base URL | Version / paths | Auth | Regional endpoints / notes |
|---|---|---|---|---|
| OpenAI API | `https://api.openai.com/v1` | `v1/responses`, `v1/chat/completions`, `v1/batch`, `v1/images/*`, `v1/audio/*`, `v1/embeddings`, `v1/realtime/*` | Bearer API key | US regional processing: `https://us.api.openai.com/v1`; EU regional processing: `https://eu.api.openai.com/v1` |
| GPT Actions / MCP / Connectors | Host-defined | Third-party tool calls | OAuth access token or API key for the third-party action | OAuth is common here, not for the core API |
| ChatGPT web app | `https://chatgpt.com/backend-api/` | Product backend | ChatGPT session auth | Not the public developer API |

## Model catalog - text and reasoning

| Model | Status | Context | Max out | Cutoff | Vision | Tools | Stream | Func | Struct | Img | Audio | Std $/1M | Batch $/1M | Pattern | Notes |
|---|---|---:|---:|---|---|---|---|---|---|---|---|---|---|---|---|
| GPT-4o | API active; ChatGPT retired | 128,000 | 16,384 | 2023-10-01 | Yes | Yes | Yes | Yes | Yes | Yes (tool) | No | 2.50 / 1.25 / 10.00 | 1.25 / 0.625 / 5.00 | A1 | Flagship multimodal GPT |
| GPT-4o mini | API active | 128,000 | 16,384 | 2023-10-01 | Yes | Yes | Yes | Yes | Yes | Yes (tool) | No | 0.15 / 0.075 / 0.60 | 0.075 / 0.0375 / 0.30 | A2 | Small, fast, low-cost omni model |
| GPT-4.1 | API active; ChatGPT retired | 1,047,576 | 32,768 | 2024-06-01 | Yes | Yes | Yes | Yes | Yes | Yes (tool) | No | 2.00 / 0.50 / 8.00 | 1.00 / 0.25 / 4.00 | A1 | Smartest non-reasoning model |
| GPT-4.1 mini | API active; ChatGPT retired | 1,047,576 | 32,768 | 2024-06-01 | Yes | Yes | Yes | Yes | Yes | Yes (tool) | No | 0.40 / 0.10 / 1.60 | 0.20 / 0.05 / 0.80 | A2 | Smaller 4.1 variant |
| GPT-4.1 nano | API active; ChatGPT retired | 1,047,576 | 32,768 | 2024-06-01 | Yes | Yes | Yes | Yes | Yes | Yes (tool) | No | 0.10 / 0.025 / 0.40 | 0.05 / 0.0125 / 0.20 | A2 | Fastest 4.1 variant |
| o1 | API active; sunset 2026-10-23 | 200,000 | 100,000 | 2023-10-01 | Yes | Yes | Yes | Yes | Yes | Yes (tool) | No | 15.00 / 7.50 / 60.00 | 7.50 / 3.75 / 30.00 | C | Previous full o-series reasoning model |
| o1-pro | API active; Responses API only; sunset 2026-10-23 | 200,000 | 100,000 | 2023-10-01 | Yes | Yes | No | Yes | Yes | No | No | 150.00 / n/a / 600.00 | 75.00 / n/a / 300.00 | C | More compute than o1, no streaming |
| o3 | API active | 200,000 | 100,000 | 2024-06-01 | Yes | Yes | Yes | Yes | Yes | Yes (tool) | No | 2.00 / 0.50 / 8.00 | 1.00 / 0.25 / 4.00 | C | Reasoning model for math, science, coding, visual reasoning |
| o3-mini | API active; sunset 2026-10-23 | 200,000 | 100,000 | 2023-10-01 | No | Yes | Yes | Yes | Yes | No | No | 1.10 / 0.55 / 4.40 | 0.55 / 0.275 / 2.20 | D | Small reasoning model |
| o4 | No public standalone model page found | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a | - | Closest public model is o4-mini |
| o4-mini | API active; sunset 2026-10-23 | 200,000 | 100,000 | 2024-06-01 | Yes | Yes | Yes | Yes | Yes | No | No | 1.10 / 0.275 / 4.40 | 0.55 / 0.1375 / 2.20 | E | Latest small o-series model |
| GPT-4.5 Preview | Deprecated; sunset 2026-10-23 | 128,000 | 16,384 | 2023-10-01 | Yes | Yes | Yes | Yes | Yes | Yes (tool) | No | 75.00 / 37.50 / 150.00 | 37.50 / 18.75 / 75.00 | F | Deprecated large model |
| GPT-4 Turbo | Deprecated; sunset 2026-10-23 | 128,000 | 4,096 | 2023-12-01 | Yes | Yes | Yes | Yes | No | Yes (tool) | No | 10.00 / n/a / 30.00 | 5.00 / n/a / 15.00 | G | Older high-intelligence GPT model |
| GPT-3.5 Turbo | Legacy; sunset 2026-10-23 | 16,385 | 4,096 | 2021-09-01 | No | No | No | No | No | No | No | 0.50 / n/a / 1.50 | 0.25 / n/a / 0.75 | H | Legacy chat model |

## Model catalog - image, audio, embeddings

| Model | Status | Native input / output | Native pricing | Batch | Pattern | Notes |
|---|---|---|---|---|---|---|
| DALL-E 3 | Deprecated; shutdown 2026-05-12 | Text -> Image | 1024x1024: $0.04; 1024x1536 or 1536x1024: $0.08; HD 1024x1024: $0.08; HD 1024x1536 or 1536x1024: $0.12 | n/a | J | Previous generation image model |
| DALL-E 2 | Deprecated; shutdown 2026-05-12 | Text -> Image | 1024x1024: $0.016; 1024x1536: $0.018; 1536x1024: $0.020 | n/a | J | First image generation model |
| Whisper | API active | Audio -> Text | $0.006 / minute | n/a | K | General-purpose speech recognition, translation, language ID |
| TTS-1 | API active | Text -> Audio | $15.00 / 1M characters | n/a | K | Optimized for speed |
| TTS-1 HD | API active | Text -> Audio | $30.00 / 1M characters | n/a | K | Optimized for quality |
| text-embedding-3-large | API active | Text -> embedding vector | $0.13 / 1M tokens | $0.065 / 1M tokens | L | Most capable embedding model |
| text-embedding-3-small | API active | Text -> embedding vector | $0.02 / 1M tokens | $0.01 / 1M tokens | L | Smaller, cheaper embedding model |

## Rate limits and batch patterns

Batch API note: the Batch API is a separate pool, costs 50% less than synchronous calls, and completes within 24 hours. Embeddings batches are capped at 1 million enqueued requests. For other APIs, OpenAI does not publish a simple request-count cap in the public model pages, only tiered batch queue limits. Concurrent connection ceilings are not public.

### Pattern A1 - GPT-4o and GPT-4.1 main

| Tier | RPM | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | Not supported | Not supported | Not supported | Not supported |
| Tier 1 | 500 | n/a | 30,000 | 90,000 |
| Tier 2 | 5,000 | n/a | 450,000 | 1,350,000 |
| Tier 3 | 5,000 | n/a | 800,000 | 50,000,000 |
| Tier 4 | 10,000 | n/a | 2,000,000 | 200,000,000 |
| Tier 5 | 10,000 | n/a | 30,000,000 | 5,000,000,000 |

### Pattern A2 - GPT-4.1 mini / nano and GPT-4o mini

| Tier | RPM | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | Not supported | Not supported | Not supported | Not supported |
| Tier 1 | 500 | 10,000 | 200,000 | 2,000,000 |
| Tier 2 | 5,000 | n/a | 2,000,000 | 20,000,000 |
| Tier 3 | 5,000 | n/a | 4,000,000 | 40,000,000 |
| Tier 4 | 10,000 | n/a | 10,000,000 | 1,000,000,000 |
| Tier 5 | 30,000 | n/a | 150,000,000 | 15,000,000,000 |

### Pattern C - o1, o1-pro, and o3

| Tier | RPM | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | Not supported | Not supported | Not supported | Not supported |
| Tier 1 | 500 | n/a | 30,000 | 90,000 |
| Tier 2 | 5,000 | n/a | 450,000 | 1,350,000 |
| Tier 3 | 5,000 | n/a | 800,000 | 50,000,000 |
| Tier 4 | 10,000 | n/a | 2,000,000 | 200,000,000 |
| Tier 5 | 10,000 | n/a | 30,000,000 | 5,000,000,000 |

### Pattern D - o3-mini

| Tier | RPM | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | Not supported | Not supported | Not supported | Not supported |
| Tier 1 | 1,000 | n/a | 100,000 | 1,000,000 |
| Tier 2 | 2,000 | n/a | 200,000 | 2,000,000 |
| Tier 3 | 5,000 | n/a | 4,000,000 | 40,000,000 |
| Tier 4 | 10,000 | n/a | 10,000,000 | 1,000,000,000 |
| Tier 5 | 30,000 | n/a | 150,000,000 | 15,000,000,000 |

### Pattern E - o4-mini

| Tier | RPM | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | Not supported | Not supported | Not supported | Not supported |
| Tier 1 | 1,000 | n/a | 100,000 | 1,000,000 |
| Tier 2 | 2,000 | n/a | 2,000,000 | 2,000,000 |
| Tier 3 | 5,000 | n/a | 4,000,000 | 40,000,000 |
| Tier 4 | 10,000 | n/a | 10,000,000 | 1,000,000,000 |
| Tier 5 | 30,000 | n/a | 150,000,000 | 15,000,000,000 |

### Pattern F - GPT-4.5 Preview

| Tier | RPM | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | Not supported | Not supported | Not supported | Not supported |
| Tier 1 | 1,000 | n/a | 125,000 | 50,000 |
| Tier 2 | 5,000 | n/a | 250,000 | 500,000 |
| Tier 3 | 5,000 | n/a | 500,000 | 50,000,000 |
| Tier 4 | 10,000 | n/a | 1,000,000 | 100,000,000 |
| Tier 5 | 10,000 | n/a | 2,000,000 | 5,000,000,000 |

### Pattern G - GPT-4 Turbo and GPT-4 Turbo Preview

| Tier | RPM | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | Not supported | Not supported | Not supported | Not supported |
| Tier 1 | 500 | n/a | 30,000 | 90,000 |
| Tier 2 | 5,000 | n/a | 450,000 | 1,350,000 |
| Tier 3 | 5,000 | n/a | 600,000 | 40,000,000 |
| Tier 4 | 10,000 | n/a | 800,000 | 80,000,000 |
| Tier 5 | 10,000 | n/a | 2,000,000 | 300,000,000 |

### Pattern H - GPT-3.5 Turbo

| Tier | RPM | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | Not supported | Not supported | Not supported | Not supported |
| Tier 1 | 500 | 10,000 | 200,000 | 2,000,000 |
| Tier 2 | 5,000 | n/a | 2,000,000 | 5,000,000 |
| Tier 3 | 5,000 | n/a | 4,000,000 | 50,000,000 |
| Tier 4 | 10,000 | n/a | 10,000,000 | 1,000,000,000 |
| Tier 5 | 10,000 | n/a | 50,000,000 | 10,000,000,000 |

### Pattern I - GPT-3.5 Turbo Instruct

| Tier | RPM | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | Not supported | Not supported | Not supported | Not supported |
| Tier 1 | 3,500 | 10,000 | 200,000 | 2,000,000 |
| Tier 2 | 3,500 | n/a | 2,000,000 | 5,000,000 |
| Tier 3 | 3,500 | n/a | 800,000 | 50,000,000 |
| Tier 4 | 10,000 | n/a | 10,000,000 | 1,000,000,000 |
| Tier 5 | 10,000 | n/a | 50,000,000 | 10,000,000,000 |

### Pattern J - DALL-E 3 / DALL-E 2

| Tier | Images / minute | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | Not supported | Not supported | Not supported | Not supported |
| Tier 1 | 500 | n/a | n/a | n/a |
| Tier 2 | 2,500 | n/a | n/a | n/a |
| Tier 3 | 5,000 | n/a | n/a | n/a |
| Tier 4 | 7,500 | n/a | n/a | n/a |
| Tier 5 | 10,000 | n/a | n/a | n/a |

### Pattern K - Whisper / TTS-1 / TTS-1 HD

| Tier | RPM | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | 3 | 200 | n/a | n/a |
| Tier 1 | 500 | n/a | n/a | n/a |
| Tier 2 | 2,500 | n/a | n/a | n/a |
| Tier 3 | 5,000 | n/a | n/a | n/a |
| Tier 4 | 7,500 | n/a | n/a | n/a |
| Tier 5 | 10,000 | n/a | n/a | n/a |

### Pattern L - Embeddings

| Tier | RPM | RPD | TPM | Batch queue |
|---|---:|---:|---:|---:|
| Free | 100 | 2,000 | 40,000 | n/a |
| Tier 1 | 3,000 | n/a | 1,000,000 | 3,000,000 |
| Tier 2 | 5,000 | n/a | 1,000,000 | 20,000,000 |
| Tier 3 | 5,000 | n/a | 5,000,000 | 100,000,000 |
| Tier 4 | 10,000 | n/a | 5,000,000 | 500,000,000 |
| Tier 5 | 10,000 | n/a | 10,000,000 | 4,000,000,000 |

## Legacy and deprecated models

| Model or snapshot | Sunset | Replacement / note |
|---|---|---|
| gpt-4.5-preview | 2026-10-23 | Use GPT-4.1 or o3 |
| gpt-4-turbo, gpt-4-turbo-preview | 2026-10-23 | Use GPT-4.1 |
| gpt-3.5-turbo, gpt-3.5-turbo-0125, gpt-3.5-turbo-completions | 2026-10-23 | Use GPT-4.1 mini |
| gpt-3.5-turbo-instruct | 2026-09-28 | Legacy completions only; use newer GPT-5.x / 4.1 family |
| o1, o1-2024-12-17 | 2026-10-23 | Use o3 |
| o1-pro, o1-pro-2025-03-19 | 2026-10-23 | Use o3 / o3-pro |
| o3-mini, o3-mini-2025-01-31 | 2026-10-23 | Use o3 |
| o4-mini, o4-mini-2025-04-16 | 2026-10-23 | Use GPT-5 mini |
| gpt-4o-2024-05-13 | 2026-10-23 | GPT-4o remains active; this snapshot is the deprecated dated build |
| dall-e-3, dall-e-2 | 2026-05-12 | Use GPT-Image-1 / GPT-Image-1-mini |
| text-embedding-ada-002 | n/a | Older embedding model, still legacy |

Note: I could not find a public standalone API page for `o4`. The closest public o-series model is `o4-mini`.

## May 2026 pricing changes

| Date | Change | Price impact |
|---|---|---|
| 2026-01-16 | ChatGPT Go launched globally | $8/mo consumer tier |
| 2026-03-31 | Container pricing changed | 1 GB $0.03; 64 GB $1.92 per 20-minute session |
| 2026-04-02 | Codex moved to token-based pricing for Business / Enterprise | Codex-only seats added; no fixed seat fee |
| 2026-04-02 | ChatGPT Business annual seat price lowered | $25 -> $20 per seat |
| 2026-05-05 | GPT-5.5 Instant became the default in ChatGPT | Free 10 msgs / 5h; Plus / Go 160 msgs / 3h |
| 2026-05-07 | GPT-Realtime-2, GPT-Realtime-Translate, GPT-Realtime-Whisper launched | $32 / $64 audio, $0.034/min translation, $0.017/min Whisper |
| 2026-05-12 | DALL-E 2 and DALL-E 3 scheduled for shutdown | Migration to newer image models |

### Current API price anchors

| Model | Price | Notes |
|---|---|---|
| GPT-5.5 | $5.00 / 1M input; $0.50 cached; $30.00 output | 1M context, 128K max output |
| GPT-5.4 | $2.50 / 1M input; $0.25 cached; $15.00 output | More affordable coding model |
| GPT-5.4 mini | $0.75 / 1M input; $0.075 cached; $4.50 output | Strongest mini model |
| GPT-Realtime-2 (audio) | $32.00 / 1M audio input; $0.40 cached; $64.00 audio output | Text: $4.00 / $0.40 / $24.00; Image input: $5.00 / $0.50 |
| GPT-Realtime-Translate | $0.034 / minute | Live translation |
| GPT-Realtime-Whisper | $0.017 / minute | Streaming speech-to-text |
| GPT-Image-2 | Image: $8.00 / 1M; cached $2.00; output $30.00 | Text: $5.00 / 1M; cached $1.25 |

## Source set checked

| Source | Used for |
|---|---|
| `openai.com/pricing` | ChatGPT plan pricing, current consumer tiers, Business / Enterprise summary |
| `openai.com/api/pricing` | Current API pricing, batch discount, container pricing, tool pricing |
| `developers.openai.com/api/docs/models/*` | Model specs, cutoffs, pricing, features, snapshots, rate limits |
| `developers.openai.com/api/docs/pricing` | Token pricing details and batch pricing examples |
| `developers.openai.com/api/docs/guides/rate-limits` | Usage tiers and RPM / TPM definitions |
| `developers.openai.com/api/docs/guides/batch` | Batch API separate pool and 24-hour behavior |
| `developers.openai.com/api/docs/guides/your-data` | Regional processing and data residency prefixes |
| OpenAI Help Center plan / billing articles | ChatGPT caps, credits, retirements, prepaid billing, flexible pricing |
