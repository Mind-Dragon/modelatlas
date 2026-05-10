# DOMAIN 7 — OTHER PROVIDERS + MODELS DB / HUGGING FACE

Task: 001-deerflow-modeldb | Research domain 7
Compiled: 2026-05-09
Source: Public provider docs, pricing pages, independent aggregators.

---

## 1. COHERE

| Attribute | Value |
|-----------|-------|
| Base endpoint | `https://api.cohere.ai` |
| Auth | Trial key (free, rate-limited, non-production) or Production key (pay-as-you-go) |
| Billing cycle | End of month or $250 outstanding balance |
| Rate limits | Trial: rate limited. Production: full speed (variable by plan). |

### Chat Models

| Model | Context | Max Output | Input $/1M | Output $/1M | Notes |
|-------|---------|------------|------------|-------------|-------|
| Command R+ (04-2024) | 128K | 4K | $3.00 | $15.00 | Legacy; still listed |
| Command R+ (08-2024) | 128K | 4K | $2.50 | $10.00 | ~25% lower latency vs 04-2024 |
| Command R (03-2024) | 128K | 4K | $0.50 | $1.50 | Legacy |
| Command A | 256K | 8K | — | — | Requires 2× GPU (A100/H100); pricing via enterprise / Model Vault |
| Command (legacy) | — | — | $1.00 | $2.00 | Legacy |
| Command-light (legacy) | — | — | $0.30 | $0.60 | Legacy |
| Aya Expanse 8B / 32B | — | — | $0.50 | $1.50 | Research models |

### Embed Models

| Model | Modality | Context | API Price | Model Vault (Small) | Model Vault (Medium) |
|-------|----------|---------|-----------|---------------------|----------------------|
| Embed 4 | Text + Image | — | ~$0.12/1M tokens (reported) | $4.00/hr / $2,500/mo | $5.00/hr / $3,250/mo |
| Embed Multilingual v3 | Text | 512 | ~$0.10/1M tokens | — | — |
| Embed English v3 | Text | 512 | ~$0.10/1M tokens | — | — |

### Rate Limit Notes
- Production key requires organization Owner to complete "Go to Production" workflow.
- Trial keys: not permitted for production/commercial use.

---

## 2. AI21 LABS

| Attribute | Value |
|-----------|-------|
| Website | `https://studio.ai21.com` |
| API style | Standard completions + chat; also available via AWS Bedrock |
| Context window | Up to 256K tokens (Jamba 1.5 family) |

### Models & Pricing

| Model | Input $/1M | Output $/1M | Context | Params | Architecture |
|-------|------------|-------------|---------|--------|--------------|
| Jamba 1.5 Mini | $0.20 | $0.40 | 256K | 52B total | SSM + Transformer hybrid |
| Jamba 1.5 Large | $2.00 | $8.00 | 256K | — | SSM + Transformer hybrid |
| Jurassic-2 Mid | $12.50 | $12.50 | 8K | — | Dense Transformer |
| Jurassic-2 Ultra | $18.80 | $18.80 | 8K | — | Dense Transformer |

### Bedrock Pricing (same models, AWS rates)
- Jamba 1.5 Mini: $0.20 / $0.40 per 1M
- Jamba 1.5 Large: $2.00 / $8.00 per 1M
- Jurassic-2 Mid: $12.50 / $12.50 per 1M
- Jurassic-2 Ultra: $18.80 / $18.80 per 1M

---

## 3. PERPLEXITY

| Attribute | Value |
|-----------|-------|
| API docs | `https://docs.perplexity.ai` |
| Console | `https://console.perplexity.ai` |
| Plans (consumer app) | Free / Pro $20/mo — these are separate from API billing |
| API billing | Pre-paid credits; tiered rate limits by cumulative spend |

### Sonar API — Token Pricing

| Model | Input $/1M | Output $/1M | Citations $/1M | Search Queries $/1K | Reasoning $/1M |
|-------|------------|-------------|----------------|---------------------|----------------|
| Sonar | $1.00 | $1.00 | — | — | — |
| Sonar Pro | $3.00 | $15.00 | — | — | — |
| Sonar Reasoning Pro | $2.00 | $8.00 | — | — | — |
| Sonar Deep Research | $2.00 | $8.00 | $2.00 | $5.00 | $3.00 |

### Sonar API — Request Fees ($ per 1,000 requests)

| Model | Low Context | Medium Context | High Context |
|-------|-------------|----------------|--------------|
| Sonar | $5 | $8 | $12 |
| Sonar Pro | $6 | $10 | $14 |
| Sonar Reasoning Pro | $6 | $10 | $14 |
| Sonar Pro + Multi-step (`pro` search_type) | $14 | $18 | $22 |

### Other APIs

| API | Price |
|-----|-------|
| Search API | $5.00 per 1K requests (raw web search, no token costs) |
| Embeddings (pplx-embed-v1-0.6b) | $0.004 / 1M tokens (1024-dim) |
| Embeddings (pplx-embed-v1-4b) | $0.03 / 1M tokens (2560-dim) |
| Contextualized Embeddings (0.6b) | $0.008 / 1M tokens |
| Contextualized Embeddings (4b) | $0.05 / 1M tokens |
| Agent API web_search tool | $0.005 per invocation |
| Agent API fetch_url tool | $0.0005 per invocation |

### Rate Limits (Usage Tiers)

| Tier | Min Cumulative Spend | Agent API QPS | Agent API RPM | Sonar models RPM |
|------|----------------------|---------------|---------------|------------------|
| Tier 0 | $0 | 1 | 50 | 50 |
| Tier 1 | $50 | 3 | 150 | 150 |
| Tier 2 | $250 | 8 | 500 | 500 |
| Tier 3 | $500 | 17 | 1,000 | 1,000 |
| Tier 4 | $1,000 | 33 | 2,000 | 4,000 |
| Tier 5 | $5,000 | 33 | 2,000 | 4,000 |

- Search API rate limit: 50 requests/second (burst 50), independent of tier.
- `sonar-deep-research` RPM caps: T0=5, T1=10, T2=20, T3=40, T4=60, T5=100.

---

## 4. REKA

| Attribute | Value |
|-----------|-------|
| Platform | `https://platform.reka.ai` |
| Multimodal | Image, Video, Audio + Text on all chat models |

### Reka Chat Models

| Model | Input $/1M | Output $/1M | Image | Video $/min | Audio $/min | Role |
|-------|------------|-------------|-------|-------------|-------------|------|
| Reka Core | $2.00 | $6.00 | $0.02 | $0.08 | $0.02 | Complex tasks |
| Reka Flash | $0.80 | $2.00 | $0.01 | $0.06 | $0.015 | Fast, efficient |
| Reka Spark | $0.05 | $0.05 | $0.005 | $0.01 | $0.005 | Compact / on-device |
| Reka Edge | — | — | — | — | — | 7B multimodal (available on OpenRouter) |

### Reka Research

| Model | Standard $/1K req | Parallel Thinking (low) $/1K req | Parallel Thinking (high) $/1K req |
|-------|-------------------|----------------------------------|-----------------------------------|
| reka-flash-research | $25.00 | $35.00 | $60.00 |

- Reka Vision (image/video search, Q&A, generation) has separate tiered pricing.
- Context window varies by model; Core is reported up to 256K–1M tokens on some platforms.

---

## 5. YI / 01.AI

| Attribute | Value |
|-----------|-------|
| Developer | 01.AI (Kai-Fu Lee) |
| Models | Yi-Lightning, Yi-Large, Yi-Spark, Yi-34B, etc. |
| Orientation | Bilingual (Chinese + English) |

### Known Pricing

| Model | Input $/1M | Output $/1M | Context | Availability |
|-------|------------|-------------|---------|--------------|
| Yi-Lightning | ~$0.14 | ~$0.14 | ~256K | 01.AI platform, third-party routers |
| Yi-Large | ~$2.00 | ~$2.00 | 32K | Fireworks AI, NVIDIA NIM, OpenRouter |
| Yi-Spark | — | — | — | Reported as lower-tier / fast model |

### Notes
- 01.AI does not operate a first-party global consumer API with the same visibility as OpenAI. Pricing is often surfaced through partner platforms (Fireworks AI, etc.) or direct enterprise quotes.
- Yi-Lightning was positioned as a price-disruptor at launch (~$0.14/M tokens).

---

## 6. BAICHUAN

| Attribute | Value |
|-----------|-------|
| Developer | Baichuan Intelligent Technology (China) |
| Platform | `https://platform.baichuan-ai.com` |
| Billing | CNY per 1K tokens. Approximate USD shown below at ~1 CNY ≈ $0.14 USD. |

### General LLM Pricing

| Model | Input + Output (combined) | Context | Notes |
|-------|---------------------------|---------|-------|
| Baichuan4 | ~$14.00 / 1M tokens | 32K | Flagship |
| Baichuan4-Turbo | ~$2.10 / 1M tokens | 32K | — |
| Baichuan4-Air | ~$0.14 / 1M tokens | 32K | Lowest-cost flagship-line |
| Baichuan3-Turbo | ~$1.68 / 1M tokens | 32K | — |
| Baichuan3-Turbo-128k | ~$3.36 / 1M tokens | 128K | Extended context |
| Baichuan2-Turbo | ~$1.12 / 1M tokens | 32K | — |
| Baichuan2-53B | ~$1.40 / 1M tokens (off-peak) / ~$2.80 (peak) | 32K | Time-of-day pricing |
| Baichuan-M3-Plus | ~$0.70 input, ~$1.26 output / 1M | 32K | Search + medical search auto-triggers |
| Baichuan-M3 | ~$1.40 input, ~$4.20 output / 1M | 32K | — |
| Baichuan-M2-Plus | ~$1.40 input, ~$4.20 output / 1M | 32K | Auto-triggers medical search |
| Baichuan-M2 | ~$0.28 input, ~$2.80 output / 1M | 32K | — |

### Add-ons

| Service | Price |
|---------|-------|
| Search enhance (web_search) | ~$0.0042 / invocation |
| Medical search | ~$0.0042 / invocation |
| Embeddings (Baichuan-Text-Embedding) | ~$0.07 / 1M tokens |
| Knowledge base file storage | ~$0.21 / GB / day |

### Notes
- New users receive ~80 CNY (~$11) free credits, valid 3 months.
- Baichuan2-Turbo-192k was retired; calls route to Baichuan3-Turbo-128k.

---

## 7. META LLAMA — FIRST PARTY

| Statement | Detail |
|-----------|--------|
| First-party API | **Meta does NOT offer a first-party, direct-to-developer API comparable to OpenAI's.** |
| Llama access | Available through partner inference providers and cloud marketplaces. |
| Official Llama API | Groq partners with Meta to host what is marketed as the "official Llama API" (`https://console.groq.com/landing/llama-api`), but this is still Groq infrastructure. |

### Where to get Llama API access

| Provider | Models Offered | Pricing Model |
|----------|---------------|---------------|
| AWS Bedrock | Llama 4, 3.3, 3.2, 3.1 | Per-token |
| Azure AI | Llama variants | Per-token + Azure markup |
| Google Cloud Vertex | Llama variants | Per-token |
| Groq | Llama 3.x, 4 (fast inference) | Per-token |
| Together AI | Wide Llama catalog | Per-token |
| Fireworks AI | Llama 3.x, 4 | Per-token |
| Cerebras | Llama 3.x (fast inference) | Per-token |
| Replicate | Llama variants | Per-token |

---

## 8. AMAZON BEDROCK

| Attribute | Value |
|-----------|-------|
| Endpoint | AWS SDK / `bedrock-runtime` |
| Pricing model | On-demand per-token (Standard), Batch (-50%), Provisioned Throughput (per-hour), Flex (-50%), Priority (+75%), Reserved (1-3 month commit) |

### Model Catalog — Selected Pricing (Standard Tier, US East Ohio)

| Provider | Model | Input $/1M | Output $/1M |
|----------|-------|------------|-------------|
| **Amazon Nova** | Nova Micro | $0.035 | $0.14 |
| | Nova Lite | $0.06 | $0.24 |
| | Nova Pro | $0.80 | $3.20 |
| | Nova Premier | $2.50 | $12.50 |
| **Anthropic Claude** | Claude Opus 4.7 | $5.00 | $25.00 |
| | Claude Sonnet 4.6 | $3.00 | $15.00 |
| | Claude Haiku 4.5 | $1.00 | $5.00 |
| | Claude 3.5 Sonnet | $3.00 | $15.00 |
| | Claude 3.5 Haiku | $0.80 | $4.00 |
| | Claude 3 Haiku | $0.25 | $1.25 |
| **Meta Llama** | Llama 4 Maverick 17B | $0.24 | $0.97 |
| | Llama 4 Scout 17B | $0.17 | $0.66 |
| | Llama 3.3 Instruct (70B) | $0.72 | $0.72 |
| | Llama 3.1 Instruct (8B) | $0.22 | $0.22 |
| | Llama 3.1 Instruct (70B) | $0.72 | $0.72 |
| | Llama 3.1 Instruct (405B) | $2.40 | $2.40 |
| **DeepSeek** | DeepSeek-R1 | $1.35 | $5.40 |
| | DeepSeek-V3.1 | $0.58 | $1.68 |
| **Mistral AI** | Mistral Large 3 | $0.50 | $1.50 |
| | Pixtral Large (25.02) | $2.00 | $6.00 |
| | Ministral 3B 3.0 | $0.10 | $0.10 |
| | Ministral 8B 3.0 | $0.15 | $0.15 |
| **AI21 Labs** | Jamba 1.5 Mini | $0.20 | $0.40 |
| | Jamba 1.5 Large | $2.00 | $8.00 |
| | Jurassic-2 Mid | $12.50 | $12.50 |
| | Jurassic-2 Ultra | $18.80 | $18.80 |
| **Google** | Gemma 3 4B | $0.04 | $0.08 |
| | Gemma 3 12B | $0.09 | $0.29 |
| | Gemma 3 27B | $0.23 | $0.38 |
| **NVIDIA** | Nemotron Nano 2 | $0.06 | $0.23 |
| | Nemotron 3 Super 120B | $0.15 | $0.65 |
| **Stability AI** | Stable Diffusion 3.5 Large | $0.08 / image | — |
| | Stable Image Core | $0.04 / image | — |

### Service Tier Pricing Modifiers

| Tier | Modifier | Use Case |
|------|----------|----------|
| Standard | Baseline | Default on-demand |
| Priority | +75% | Low-latency guarantee |
| Flex | -50% | Deferred / background |
| Batch | -50% | Returns within 24h |
| Reserved | Commitment-based (1mo or 3mo) | Predictable throughput |

---

## 9. MICROSOFT AZURE OPENAI

| Attribute | Value |
|-----------|-------|
| Service | Azure OpenAI Service (part of Microsoft Azure AI) |
| Deployment types | Global, Data Zone, Regional (up to 27 regions) |
| Pricing model | Standard (on-demand per token), Provisioned Throughput Units (PTU), Batch API (-50%) |
| Reservations | Monthly and annual PTU reservations available |

### Regional Pricing Note
- Global SKU = baseline.
- Data Zone / Regional SKU typically **+10–20%** over Global.
- Model availability varies by region.

### Model Pricing — Global SKU (selected)

| Model | Input $/1M | Cached Input $/1M | Output $/1M | Batch Input/Output $/1M |
|-------|------------|-------------------|-------------|--------------------------|
| GPT-5.4 (<272k) | $2.50 | $0.25 | $15.00 | $1.25 / $7.50 |
| GPT-5.4 (>272k) | $5.00 | $0.50 | $22.50 | $2.50 / $11.25 |
| GPT-5.4 Pro (<272k) | $30.00 | — | $180.00 | — |
| GPT-5.4 Pro (>272k) | $60.00 | — | $270.00 | — |
| GPT-5.4 mini | $0.75 | $0.08 | $4.50 | — |
| GPT-5.4 nano | $0.20 | $0.02 | $1.25 | — |
| GPT-5.3 Codex | $1.75 | $0.18 | $14.00 | — |
| GPT-5 Global | $1.25 | $0.13 | $10.00 | $0.63 / $5.00 |
| GPT-5 Data Zone | $1.38 | $0.14 | $11.00 | $0.69 / $5.50 |
| GPT-5 Pro Global | $15.00 | — | $120.00 | — |
| GPT-5-mini Global | $0.25 | $0.03 | $2.00 | — |
| GPT-5-nano Global | $0.05 | $0.01 | $0.40 | — |
| o3 Global | $2.00 | $0.50 | $8.00 | $1.00 / $4.00 |
| o3 Data Zone | $2.20 | $0.55 | $8.80 | $1.10 / $4.40 |
| o3-deep research Global | $10.00 | $2.50 | $40.00 | — |
| o4-mini Global | $1.10 | $0.28 | $4.40 | $0.55 / $2.20 |
| o3-mini Global | $1.10 | $0.55 | $4.40 | $0.55 / $2.20 |
| o1 Global | $15.00 | $7.50 | $60.00 | — |
| GPT-4.1 Global | $2.00 | $0.50 | $8.00 | $1.00 / $4.00 |
| GPT-4.1 mini Global | $0.40 | $0.10 | $1.60 | $0.20 / $0.80 |
| GPT-4.1 nano Global | $0.10 | $0.025 | $0.40 | $0.05 / $0.20 |

### Quotas
- Seven tiers: Free + Tiers 1–6. Tier 6 = highest quotas.
- Initial assignment is conservative and scales with usage history + quota requests.

---

## 10. HUGGING FACE INFERENCE

| Attribute | Value |
|-----------|-------|
| Hub | `https://huggingface.co` |
| Inference Providers | 200+ models routed through HF with no markup |
| Inference Endpoints | Dedicated autoscaling deployments |
| HF-Inference (serverless) | CPU-focused inference (embeddings, classifiers, small LLMs) |

### Account Tiers & Free Credits

| Account | Monthly Credits | Extra Usage | Price |
|---------|-----------------|-------------|-------|
| Free | $0.10 | Purchase required | Free |
| PRO | $2.00 | Purchase required | $9 / month |
| Team | $2.00 / seat | Purchase required | $20 / user / month |
| Enterprise | $2.00 / seat | Purchase required | From $50 / user / month |

### Billing Modes

| Mode | Billed By | Free Credits? | Best For |
|------|-----------|---------------|----------|
| Routed by Hugging Face | Hugging Face | Yes | Simplicity, experimentation |
| Custom Provider Key | Provider (Together, Fireworks, etc.) | No | Billing control, same-provider heavy use |

### Inference Endpoints — Selected Hardware Pricing

| Hardware | vCPU | RAM | GPU | VRAM | $/hour |
|----------|------|-----|-----|------|--------|
| CPU Basic | 2 | 16 GB | — | — | FREE |
| CPU Upgrade | 8 | 32 GB | — | — | $0.03 |
| Nvidia T4 – small | 4 | 15 GB | T4 | 16 GB | $0.40 |
| 1× Nvidia L4 | 8 | 30 GB | L4 | 24 GB | $0.80 |
| 1× Nvidia L40S | 8 | 62 GB | L40S | 48 GB | $1.80 |
| Nvidia A10G – small | 4 | 15 GB | A10G | 24 GB | $1.00 |
| Nvidia A100 – large | 12 | 142 GB | A100 | 80 GB | $2.50 |
| 4× Nvidia A100 | 48 | 568 GB | A100 | 320 GB | $10.00 |
| 8× Nvidia A100 | 96 | 1136 GB | A100 | 640 GB | $20.00 |
| ZeroGPU (H200) | dynamic | dynamic | H200 | 70 GB | FREE (quota-limited) |

### HF-Inference (Serverless / Legacy Free API)
- Now limited to CPU inference: embeddings, text-classification, text-ranking, small LLMs (BERT, GPT-2 class).
- Billed by `compute_time × hardware_rate` (e.g. ~$0.00012/sec).
- Free tier = $0.10/mo credit (enough for light testing only).

### Rate Limits
- Free tier: heavily rate-limited by monthly credit cap.
- PRO / Team / Enterprise: higher quotas + priority queues.
- Spaces ZeroGPU: quota-based (PRO gets 8× free tier).

---

## 11. MODELS DATABASES / AGGREGATORS

No active standalone site named `modelsdb.app` or `models.ai` was found. The following independent aggregators provide structured model/provider/pricing data:

| Site | URL | What It Catalogs |
|------|-----|------------------|
| **Artificial Analysis** | `https://artificialanalysis.ai` | 500+ endpoints tracked live (72h window): intelligence index, price ($/M), output speed (tok/s), latency (TTFT), context window, license type. |
| **Price Per Token** | `https://pricepertoken.com` | 538+ models tracked; price ranges from free to $150/M input. Free models listed separately. |
| **OpenRouter** | `https://openrouter.ai` | Aggregation router with per-model pricing across dozens of providers; serves as a de facto price-discovery layer. |
| **LLMReference** | `https://www.llmreference.com` | Provider-agnostic model pages with pricing, context, benchmarks. |
| **CloudPrice** | `https://cloudprice.net` | Per-model pricing pages for major providers. |
| **Compute Prices** | `https://computeprices.com` | API pricing for models across providers. |
| **agentjido/llm_db (GitHub)** | `https://github.com/agentjido/llm_db` | Open-source LLM model metadata catalog with typed Provider/Model structs for programmatic lookup. |

### Useful Structured Data Patterns (from aggregators)

| Field | Typical Values |
|-------|----------------|
| `provider` | OpenAI, Anthropic, Google, Cohere, AI21, Mistral, Meta, DeepSeek, etc. |
| `model_id` | Provider-specific identifier (e.g. `claude-sonnet-4-6`, `gpt-5-4`) |
| `input_price_usd_per_1m` | Float |
| `output_price_usd_per_1m` | Float |
| `context_window` | Integer (tokens) |
| `max_output_tokens` | Integer (tokens) |
| `modality` | `text`, `text+image`, `text+image+audio`, `text+image+video+audio` |
| `architecture` | `dense`, `moe`, `ssm_hybrid`, etc. |
| `license` | `proprietary`, `open_weight`, `apache-2.0`, etc. |
| `intelligence_score` | Aggregator-specific benchmark composite (e.g. Artificial Analysis index 0–60) |
| `speed_tok_per_sec` | Live measured output speed |
| `latency_ttfs_sec` | Time to first token |

---

## CROSS-REFERENCE SUMMARY — CHEAPEST / MOST EXPENSIVE

### Lowest-cost chat input (per 1M tokens)

| Rank | Provider | Model | Input $/1M |
|------|----------|-------|------------|
| 1 | Amazon Bedrock | Nova Micro | $0.035 |
| 2 | Amazon Bedrock | Gemma 3 4B | $0.04 |
| 3 | Azure OpenAI | GPT-5-nano | $0.05 |
| 4 | Baichuan | Baichuan4-Air | ~$0.14 |
| 5 | Yi / 01.AI | Yi-Lightning | ~$0.14 |

### Highest-cost chat output (per 1M tokens)

| Rank | Provider | Model | Output $/1M |
|------|----------|-------|-------------|
| 1 | Azure OpenAI | GPT-5.4 Pro (>272k) | $270.00 |
| 2 | Azure OpenAI | o3-deep research | $40.00 |
| 3 | Azure OpenAI | o1 | $60.00 |
| 4 | Cohere | Command R+ (legacy) | $15.00 |
| 5 | AI21 Labs | Jurassic-2 Ultra | $18.80 |

---
*End of DOMAIN 7 research.*
