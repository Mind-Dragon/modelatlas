# Domain 6: Mistral + API Aggregators

Last updated: 2026-05-09 | Data sourced from official pricing pages, docs, and public benchmarks.
All prices in USD per million tokens (input / output) unless noted.

---

## 1. Mistral AI

Mistral AI offers two access paths: **Le Chat** (consumer/business assistant, subscription-based) and **La Plateforme** (developer API, pay-as-you-go).

### 1.1 Le Chat Plans

| Plan | Price | Key Features |
|------|-------|-------------|
| Free | $0 | Core chat, limited messages, 500 memories, limited image gen |
| Pro | $14.99/mo | More messages, extended thinking, 15GB storage, Mistral Vibe CLI, deep research |
| Team | $24.99/user/mo | 30GB/user storage, domain verification, data export, admin controls |
| Enterprise | Custom | On-premise deployment, custom models, SAML SSO, white label, audit logs |

### 1.2 La Plateforme API — Active Models

**Frontier / Latest Models**

| Model | Version | Context | Max Output | Input $/1M | Output $/1M | Capabilities |
|-------|---------|---------|-----------|-----------|-------------|-------------|
| Mistral Large 3 | v25.12 | 262K | ~262K | $0.50 | $1.50 | Text, vision, multilingual, 41B active / 675B total MoE, Apache 2.0 |
| Mistral Medium 3.1 | v25.08 | 131K | — | $0.40 | $2.00 | Frontier multimodal, agentic & coding |
| Mistral Small 4 | v26.03 | 262K | — | $0.15 | $0.60 | Hybrid instruct/reasoning/coding, open-weight |
| Mistral Small 3.2 | v25.06 | 128K | — | $0.075 | $0.20 | Deprecating Jul 31, 2026 |
| Ministral 3 14B | v25.12 | 262K | — | $0.20 | $0.20 | Text + vision, strong efficiency |
| Ministral 3 8B | v25.12 | 262K | — | $0.15 | $0.15 | Text + vision |
| Ministral 3 3B | v25.12 | 131K | — | $0.10 | $0.10 | Tiny edge model |

**Specialist Models**

| Model | Version | Context | Input $/1M | Output $/1M | Notes |
|-------|---------|---------|-----------|-------------|-------|
| Codestral | v25.08 | 256K | $0.30 | $0.90 | Code completion, Premier access |
| Devstral 2 | v25.12 | 262K | $0.40 | $0.90 | Code agents, 44.8% LiveCodeBench |
| Devstral Medium | v25.07 | 131K | $0.40 | $2.00 | 61.6% SWE-Bench |
| Mistral Nemo 12B | v24.07 | 131K | $0.02 | $0.03 | Best multilingual open-source, 12B dense |
| Pixtral 12B | v24.09 | 128K | $0.10 | $0.10 | Vision model |
| Mistral Embed | v23.12 | — | $0.10 | — | Embeddings (input only) |
| Mistral Moderation 2 | v26.03 | 128K | $0.10 | — | Safety moderation |

**Legacy models still available but deprecating:**

- Mistral Large 2.1 (2411): $2.00/$6.00, 131K — deprecating May 31, 2026
- Pixtral Large (2411): $2.00/$6.00, 131K — deprecating May 31, 2026
- Magistral Medium: $2.00/$5.00, 40K — highest benchmark scores but Premier-only

### 1.3 API Rate Limits & Tiers

Rate limits at the organization level, enforced on Requests Per Second (RPS) and tokens per minute.

| Tier | Trigger | Limits |
|------|---------|--------|
| Free (Experiment) | Signup | ~1 RPS, 30 RPM, very limited TPM — evaluation only |
| Tier 1 (Scale) | Upgrade to paid | Increased from free baseline |
| Tier 2 | $20 cumulative billed | Higher RPS + TPM |
| Tier 3 | $100 cumulative billed | Higher RPS + TPM |
| Tier 4 | $500 cumulative billed | Higher RPS + TPM |
| Custom | $2,000+ cumulative | Contact support |

### 1.4 API Endpoint

```
Base URL: https://api.mistral.ai
Primary: /v1/chat/completions, /v1/embeddings, /v1/fim/completions, /v1/ocr
OpenAI-compatible SDK: python-mistralai (pip), @mistralai/mistralai (npm)
```

---

## 2. OpenRouter

Unified API gateway routing to 400+ models across 60+ providers. OpenAI-compatible.

### 2.1 Pricing Model

| Plan | Platform Fee | Models | Providers | Rate Limits |
|------|-------------|--------|-----------|-------------|
| Free | 0% | 25+ free models | 4 | 50 req/day, 20 RPM |
| Pay-as-you-go | 5.5% | 400+ | 60+ | No limits on paid models ($10+ credits) |
| Enterprise | Volume discounts | 400+ | 60+ | Optional dedicated limits |

**Key rules:**
- No markup on provider pricing — prices in catalog match provider websites exactly
- Failed/fallback attempts are not billed
- Credit minimum purchase: $0.80, credits expire in 365 days
- **BYOK**: 1M free requests/month, then 5% fee on additional usage

### 2.2 Mistral Models on OpenRouter (sample pricing)

| Model | Context | Input $/1M | Output $/1M | Notes |
|-------|---------|-----------|-------------|-------|
| Mistral Large 3 2512 | 262K | $0.50 | $1.50 | 41B active, 675B total |
| Mistral Medium 3.1 | 131K | $0.40 | $2.00 | |
| Devstral 2 2512 | 262K | $0.40 | $2.00 | Code agent |
| Devstral Medium | 131K | $0.40 | $2.00 | |
| Devstral Small 1.1 | 131K | $0.10 | $0.30 | |
| Ministral 3 14B | 262K | $0.20 | $0.20 | |
| Mistral Small 3.2 24B | 128K | $0.075 | $0.20 | |
| Mistral Small 4 | 262K | $0.15 | $0.60 | |

### 2.3 Additional Notable Models on OpenRouter

| Provider | Model | Input $/1M | Output $/1M | Context |
|----------|-------|-----------|-------------|---------|
| OpenAI | GPT-5.2 | $1.75 | $14.00 | 400K |
| Anthropic | Claude Opus 4.5 | $5.00 | $25.00 | 200K |
| Google | Gemini 2.5 Pro | $1.25 | $10.00 | 1.05M |
| DeepSeek | V3.2 | $0.252 | $0.378 | 131K |
| Qwen | Qwen3 Max | $0.78 | $3.90 | 262K |
| Meta | Llama 4 Maverick | $0.15 | $0.60 | 1.05M |
| Meta | Llama 4 Scout | $0.08 | $0.30 | 328K |

### 2.4 API Endpoint

```
Base URL: https://openrouter.ai/api/v1
OpenAI SDK compatible — swap base URL and API key
Endpoint: /v1/chat/completions
```

---

## 3. Together AI

Open-source model inference and fine-tuning platform. New users get $25 in free credits.

### 3.1 Serverless Inference Pricing (selected models)

**High-Tier Models**

| Model | Input $/1M | Output $/1M | Notes |
|-------|-----------|-------------|-------|
| DeepSeek-R1-0528 | $3.00 | $7.00 | |
| Kimi K2.6 | $1.20 ($0.20 cached) | $4.50 | |
| DeepSeek V4 Pro | $2.10 ($0.20 cached) | $4.40 | |
| GLM-5.1 | $1.40 | $4.40 | |
| Kimi K2.5 | $0.50 | $2.80 | |
| Qwen3.5-397B-A17B | $0.60 | $3.60 | |

**Mid-Tier Models**

| Model | Input $/1M | Output $/1M | Notes |
|-------|-----------|-------------|-------|
| Qwen3-Coder-480B A35B | $2.00 | $2.00 | |
| Qwen3.6-Plus | $0.50 | $3.00 | |
| GLM-5 | $1.00 | $3.20 | |
| DeepSeek-V3.1 | $0.60 | $1.70 | |
| Llama 3.3 70B | $0.88 | $0.88 | |
| Llama 4 Maverick | $0.30 | $0.60 | |
| Llama 4 Scout | $0.20 | $0.40 | |

**Budget Models**

| Model | Input $/1M | Output $/1M | Notes |
|-------|-----------|-------------|-------|
| Gemma 4 31B | $0.20 | $0.50 | |
| Qwen3 235B A22B FP8 | $0.20 | $0.60 | |
| Llama 3.3 70B | $0.88 | $0.88 | |
| Qwen2.5 7B Instruct | $0.30 | $0.30 | |
| Gemma 3n E4B | $0.06 | $0.12 | |
| LFM2 24B A2B | $0.03 | $0.12 | |

### 3.2 Dedicated Inference (GPU per-hour)

| Hardware | Price/Hour |
|----------|-----------|
| 1x H100 80GB | $3.99 |
| 1x H200 141GB | $5.49 |
| 1x B200 180GB | $9.95 |

### 3.3 API & Rate Limits

```
Base URL: https://api.together.ai/v1 (OpenAI-compatible)
Rate limits: Vary by model and tier; serverless generally high concurrency
Fine-tuning available: LoRA SFT/DPO and Full Param SFT/DPO
```

---

## 4. Fireworks AI

Fast inference platform optimized with FlashAttention, quantization, and custom kernels. $1 in free starter credits.

### 4.1 Serverless Pricing — Named Models

Format: input / cached input / output per 1M tokens

| Model | Standard | Priority |
|-------|----------|----------|
| DeepSeek V4 Pro | $1.74 / $0.145 / $3.48 | — |
| DeepSeek V3 family | $0.56 / $0.28 / $1.68 | — |
| Kimi K2.6 | $0.95 / $0.16 / $4.00 | $1.50 / $0.22 / $6.00 |
| Kimi K2.5 | $0.60 / $0.10 / $3.00 | — |
| GLM 5.1 | $1.40 / $0.26 / $4.40 | $2.10 / $0.39 / $6.60 |
| GLM 5 | $1.00 / $0.20 / $3.20 | — |
| GLM 4.7 | $0.60 / $0.30 / $2.20 | — |
| MiniMax 2.7 | $0.30 / $0.06 / $1.20 | $0.45 / $0.09 / $1.80 |
| GPT-OSS 120B | $0.15 / $0.015 / $0.60 | $0.18 / $0.018 / $0.72 |
| GPT-OSS 20B | $0.07 / $0.035 / $0.30 | — |
| Qwen3 VL 30B A3B | $0.15 / $0.075 / $0.60 | — |

### 4.2 Size-Based Tier Pricing (uniform in/out)

| Size | Price per 1M tokens |
|------|---------------------|
| < 4B params | $0.10 |
| 4B - 16B params | $0.20 |
| > 16B params | $0.90 |
| MoE up to 56B (e.g., Mixtral 8x7B) | $0.50 |
| MoE 56B - 176B (e.g., Mixtral 8x22B) | $1.20 |

**Popular models on Fireworks (size-tier mapped):**
- Llama 3.3 70B, Mistral Large, Qwen3-32B, Llama 3.1 405B: $0.90/$0.90
- DeepSeek R1, DeepSeek V3, Qwen3-Coder-480B: listed individually above
- Mistral 7B, Qwen2.5-7B, Llama 3.1 8B: $0.20/$0.20 (4B-16B tier)

### 4.3 Optimizations

- FlashAttention, 4-bit and 8-bit quantization for speed
- Priority tier for lower latency (Preview)
- Prompt caching at 50% of standard input cost
- Batch inference at 50% of standard pricing
- Cached input tokens: 50% default discount on all text/vision models

### 4.4 API

```
Base URL: https://api.fireworks.ai/v1 (OpenAI-compatible)
Rate limits: High per model; see docs.fireworks.ai for per-model quotas
```

---

## 5. Groq

Ultra-fast inference on custom LPU (Language Processing Unit) hardware. Inference-only — no training or fine-tuning. Open-source models only.

### 5.1 Available Models

| Model | Speed (TPS) | Context | Input $/1M | Output $/1M |
|-------|-----------|---------|-----------|-------------|
| Llama 3.1 8B Instant | ~840 | 128K | $0.05 | $0.08 |
| GPT-OSS 20B | ~1,000 | 128K | $0.075 | $0.30 |
| GPT-OSS Safeguard 20B | ~1,000 | — | $0.075 | $0.30 |
| Llama 4 Scout (17Bx16E MoE) | ~594 | 128K | $0.11 | $0.34 |
| GPT-OSS 120B | ~500 | 128K | $0.15 | $0.60 |
| Qwen3 32B | ~662 | 128K | $0.29 | $0.59 |
| Llama 3.3 70B Versatile | ~394 | 128K | $0.59 | $0.79 |

### 5.2 Pricing Tiers & Rate Limits

| Tier | Requirements | Rate Limits | Discount |
|------|-------------|-------------|----------|
| Free | Email signup, no credit card | 30 RPM, 6K TPM, 14.4K RPD per model | None |
| Developer | Credit card (no minimum spend) | ~10x Free tier limits | 25% off all tokens |
| Enterprise | Contact sales | Custom | Volume pricing |

### 5.3 Cost Reduction

| Feature | Discount | Notes |
|---------|----------|-------|
| Batch API | 50% off | Processing window: 24hr - 7 days |
| Prompt caching | 50% off input | Auto-caches repeated system prompts |
| Stacked (cached + batch) | ~25% effective | Both discounts apply |

### 5.4 API

```
Base URL: https://api.groq.com/v1 (OpenAI-compatible)
Endpoint: /v1/chat/completions, /v1/audio/transcriptions
```

---

## 6. Comparison Summary

### Pricing Leaders by Category

| Category | Cheapest Input | Cheapest Output | Best Speed |
|----------|---------------|----------------|------------|
| Budget LLM (<10B) | Fireworks $0.07 (GPT-OSS 20B) | Mistral $0.03 (Nemo) | Groq 840-1000 TPS |
| Mid-range (10B-70B) | Groq $0.05 (Llama 3.1 8B) | OpenRouter $0.075 (Mistral Small 3.2) | Groq 594 TPS |
| Frontier (70B+) | Together $0.15 (Llama 4 Scout) | OpenRouter $0.15 (Llama 4 Scout) | Groq 394-500 TPS |
| Vision | Fireworks $0.15 (Qwen3 VL) | Fireworks $0.15 | — |
| Code | Mistral $0.02 (Nemo) | Mistral $0.03 (Nemo) | — |
| Embeddings | Fireworks $0.008 (<150M) | — | — |

### Key Differentiators

| Provider | Strength | Weakness |
|----------|---------|---------|
| Mistral | Own models, multimodal, strong multilingual | Lower rate limits on free tier, smaller model selection |
| OpenRouter | Largest model selection (400+), BYOK, no lock-in | 5.5% markup, varies by provider availability |
| Together AI | Wide open-source catalog, fine-tuning, GPU clusters | Some models more expensive than direct |
| Fireworks AI | Fastest inference optimizations, competitive pricing | Smaller model catalog, $1 free credits |
| Groq | Best latency (LPU hardware), cheapest small models | Inference-only, open-source models only, limited model selection |

### When to Use Each

- **Mistral direct**: When you need Mistral's own models at lowest cost with full feature support (OCR, agents, moderation)
- **OpenRouter**: For multi-provider fallback, model comparison, or accessing exclusive models from many providers through one API key
- **Together AI**: For open-source serving, fine-tuning, or GPU cluster access
- **Fireworks**: For lowest-latency inference on open models, batch processing, or when prompt caching matters
- **Groq**: When speed is the priority and you only need open models — Llama 3.1 8B at $0.05/$0.08 is the cheapest production-grade inference available
