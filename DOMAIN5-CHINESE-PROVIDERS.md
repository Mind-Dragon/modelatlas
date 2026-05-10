# DOMAIN 5: CHINESE PROVIDERS

**Research Domain 5** — Chinese LLM providers covering Bailian/Alibaba, Zhipu/GLM, MiniMax, Moonshot/Kimi, and ByteDance/Doubao.

---

## ALIBABA / BAILIAN / QWEN

### Token Plans

| Plan | Price | Credits / 5hrs | Credits / Week | Credits / Month | Models Included |
|------|-------|----------------|----------------|-----------------|-----------------|
| **Lightning** | ¥7.9/mo | ~2,000 | ~15,000 | ~30,000 | Qwen3.5, GLM-5, Kimi K2.5, MiniMax M2.5 |
| **Standard Seat** | ¥198/seat/mo | 25,000 | N/A | N/A | Full Bailian catalog |
| **Team Edition** | Custom | N/A | N/A | Custom | Multi-seat, enterprise features |

> **Note:** ¥7.9 plan is a promotional "coding plan" — first month at ¥7.9, then standard pricing applies.

### Qwen Model Lineup

| Model | Release | Context | Max Output | Input ($/M) | Output ($/M) | Input (CNY/M) | Output (CNY/M) |
|-------|---------|---------|------------|-------------|--------------|---------------|----------------|
| **Qwen3.6-Plus** | 2026-02 | 1M | 32K | — | — | — | — |
| **Qwen3-Max** | 2025-09 | 262K | 8K | $0.780 | $3.90 | ¥5.60 | ¥28.00 |
| **Qwen3-Max Thinking** | 2025-09 | 262K | 8K | $0.780 | $3.90 | ¥5.60 | ¥28.00 |
| **Qwen3.5-Plus** | 2026-02 | 256K | 8K | $0.40 | $1.20 | ¥2.90 | ¥8.60 |
| **Qwen3-Coder-Plus** | 2025-09 | 1M | 8K | $0.650 | $3.25 | ¥4.70 | ¥23.40 |
| **Qwen3-Coder-Flash** | 2025-09 | 256K | 8K | $0.15 | $0.75 | ¥1.10 | ¥5.40 |
| **Qwen3** (32B) | 2025-09 | 131K | 16K | $0.287 | $0.86 | ¥2.00 | ¥6.20 |
| **Qwen2.5-72B-Instruct** | 2024-09 | 131K | 8K | $1.40 | $5.60 | ¥10.00 | ¥40.00 |
| **Qwen2.5-32B-Instruct** | 2024-09 | 131K | 8K | $0.90 | $0.90 | ¥6.50 | ¥6.50 |
| **Qwen2.5-14B-Instruct** | 2024-09 | 32K | 4K | $0.35 | $0.35 | ¥2.50 | ¥2.50 |
| **Qwen2.5-7B-Instruct** | 2024-09 | 32K | 4K | $0.10 | $0.10 | ¥0.70 | ¥0.70 |
| **Qwen2.5-Coder-32B** | 2024-11 | 32K | 8K | $0.20 | $0.20 | ¥1.40 | ¥1.40 |
| **Qwen2.5-Math-72B** | 2024-11 | 32K | 8K | $1.40 | $5.60 | ¥10.00 | ¥40.00 |
| **QwQ-32B-Preview** | 2024-11 | 32K | 8K | $0.20 | $0.20 | ¥1.40 | ¥1.40 |

> **Exchange rate:** ~¥7.2 = $1.00 (May 2026)

### API Endpoints

| Region | Public Endpoint | VPC Endpoint |
|--------|-----------------|--------------|
| China (Beijing) | `pailangstudio.cn-beijing.aliyuncs.com` | `pailangstudio-vpc.cn-beijing.aliyuncs.com` |
| China (Ulanqab) | `pailangstudio.cn-wulanchabu.aliyuncs.com` | `pailangstudio-vpc.cn-wulanchabu.aliyuncs.com` |
| China (Hangzhou) | `pailangstudio.cn-hangzhou.aliyuncs.com` | `pailangstudio-vpc.cn-hangzhou.aliyuncs.com` |
| China (Shanghai) | `pailangstudio.cn-shanghai.aliyuncs.com` | `pailangstudio-vpc.cn-shanghai.aliyuncs.com` |
| China (Shenzhen) | `pailangstudio.cn-shenzhen.aliyuncs.com` | `pailangstudio-vpc.cn-shenzhen.aliyuncs.com` |
| China (Hong Kong) | `pailangstudio.cn-hongkong.aliyuncs.com` | `pailangstudio-vpc.cn-hongkong.aliyuncs.com` |
| Singapore | `pailangstudio.ap-southeast-1.aliyuncs.com` | `pailangstudio-vpc.ap-southeast-1.aliyuncs.com` |
| Japan (Tokyo) | `pailangstudio.ap-northeast-1.aliyuncs.com` | `pailangstudio-vpc.ap-northeast-1.aliyuncs.com` |
| US (Virginia) | `pailangstudio.us-east-1.aliyuncs.com` | `pailangstudio-vpc.us-east-1.aliyuncs.com` |
| Germany (Frankfurt) | `pailangstudio.eu-central-1.aliyuncs.com` | `pailangstudio-vpc.eu-central-1.aliyuncs.com` |

> **Note:** The `token-plan.ap-southeast-1.maas.aliyuncs.com` endpoint mentioned in some docs is for specific Token Plan APIs; standard inference uses `pailangstudio.*.aliyuncs.com`.

### Rate Limits (Standard Accounts)

| Model Tier | RPM | TPM | Concurrent |
|------------|-----|-----|------------|
| Qwen-Turbo | 1,000 | 30,000 | 10 |
| Qwen-Plus | 500 | 20,000 | 5 |
| Qwen-Max | 100 | 10,000 | 2 |
| Qwen3.5-Plus | 500 | 20,000 | 5 |
| Qwen3-Max | 100 | 10,000 | 2 |

> **Higher limits** available via enterprise support or AI Savings Plan.

---

## ZHIPU / GLM

### Pricing Overview (USD)

| Model | Input ($/M) | Cached Input ($/M) | Output ($/M) | Context | Max Output |
|-------|-------------|-------------------|--------------|---------|------------|
| **GLM-5.1** | $1.40 | $0.26 | $4.40 | 200K | 128K |
| **GLM-5** | $1.00 | $0.20 | $3.20 | 200K | 128K |
| **GLM-5-Turbo** | $1.20 | $0.24 | $4.00 | 200K | 128K |
| **GLM-4.7** | $0.60 | $0.11 | $2.20 | 200K | 131K |
| **GLM-4.7-FlashX** | $0.07 | $0.01 | $0.40 | 200K | 131K |
| **GLM-4.6** | $0.60 | $0.11 | $2.20 | 200K | 131K |
| **GLM-4.5** | $0.60 | $0.11 | $2.20 | 200K | 131K |
| **GLM-4.5-X** | $2.20 | $0.45 | $8.90 | 200K | 131K |
| **GLM-4.5-Air** | $0.20 | $0.03 | $1.10 | 200K | 131K |
| **GLM-4.5-AirX** | $1.10 | $0.22 | $4.50 | 200K | 131K |
| **GLM-4-32B-0414** | $0.10 | — | $0.10 | 128K | 8K |
| **GLM-4.7-Flash** | Free | Free | Free | 200K | 131K |
| **GLM-4.5-Flash** | Free | Free | Free | 200K | 131K |

### Pricing Overview (CNY — bigmodel.cn)

| Model | Input (CNY/M) | Output (CNY/M) | Notes |
|-------|---------------|----------------|-------|
| **GLM-5-Turbo** | ¥5–7 | ¥22–26 | Peak hours (14:00–18:00 UTC+8): 3× deduction |
| **GLM-5.1** | ¥6–8 | ¥24–28 | Peak hours: 3× deduction |
| **GLM-4-Plus** | ¥5 | ¥15 | Flagship |
| **GLM-4-Air** | ¥1 | ¥4 | High-performance |
| **GLM-4-AirX** | ¥0.2 | ¥0.8 | Cost-optimized |
| **GLM-4-Flash** | Free | Free | Free tier |

### Coding Plan (CN)

| Plan | Price | Per 5hrs | Per Week | Per Month |
|------|-------|----------|----------|-----------|
| **Lite** | ¥49/mo | ~80 prompts | ~400 | N/A |
| **Pro** | ¥149/mo | ~400 prompts | ~2,000 | N/A |
| **Max** | ¥469/mo | ~1,600 prompts | ~8,000 | N/A |

> **Note:** 1 prompt ≈ 15–20 model invocations. Monthly quota ≈ 15–30× subscription fee.

### API Endpoints

| Platform | Endpoint |
|----------|----------|
| **BigModel (Open Platform)** | `https://open.bigmodel.cn/api/paas/v4/` |
| **Z.ai (International)** | `https://api.z.ai/v1/` |

### Rate Limits

| Model | RPM | TPM | Notes |
|-------|-----|-----|-------|
| GLM-4.7 | 60 | 60,000 | Standard |
| GLM-5 / GLM-5.1 | 30 | 30,000 | Standard |
| GLM-4-Plus | 60 | 60,000 | Higher tier |

> **Coding Plan** users have separate quotas; exceeding plan limits requires additional recharge or plan upgrade.

---

## MINIMAX

### Model Lineup

| Model | Release | Context | Max Output | Input ($/M) | Output ($/M) | Input (CNY/M) | Output (CNY/M) |
|-------|---------|---------|------------|-------------|--------------|---------------|----------------|
| **MiniMax-M2.7** | 2026-04 | 200K | 64K | $0.30 | $1.20 | ¥2.10 | ¥8.40 |
| **MiniMax-M2.5** | 2025-10 | 197K | 64K | $0.30 | $1.20 | ¥2.10 | ¥8.40 |
| **MiniMax-M2.1** | 2025-06 | 200K | 64K | $0.25 | $1.00 | ¥1.80 | ¥7.20 |
| **MiniMax-M2** | 2025-03 | 197K | 64K | $0.25 | $1.00 | ¥1.80 | ¥7.20 |
| **MiniMax-M1** | 2025-05 | 1M | 8K | $0.20 | $0.80 | ¥1.40 | ¥5.70 |

### Token Plans (CN)

| Plan | Price | Requests / 5hrs | Requests / Week |
|------|-------|-----------------|-----------------|
| **Starter** | ¥29/mo | 600 | 2,500 |
| **Plus** | ¥49/mo | 1,500 | 6,000 |
| **Max** | ¥119/mo | 4,500 | 18,000 |
| **Plus-Highspeed** | ¥98/mo | 1,500 | 6,000 |
| **Max-Highspeed** | ¥199/mo | 4,500 | 18,000 |
| **Ultra-Highspeed** | ¥899/mo | 30,000 | 120,000 |

### Token Plans (International)

| Plan | Price | Requests / 5hrs | Requests / Week |
|------|-------|-----------------|-----------------|
| **Starter** | $10/mo | 1,500 | 6,000 |
| **Plus** | $20/mo | 4,500 | 18,000 |
| **Max** | $50/mo | 15,000 | 60,000 |
| **Plus-High-Speed** | $40/mo | 4,500 | 18,000 |
| **Max-High-Speed** | $80/mo | 15,000 | 60,000 |
| **Ultra-High-Speed** | $150/mo | 30,000 | 120,000 |

### API Endpoints

| Region | Endpoint |
|--------|----------|
| **International** | `https://api.minimax.io/v1/text/chat_completion_v2` |
| **China** | `https://api.minimaxi.com/v1/text/chat_completion_v2` |

> **Note:** MiniMax uses Anthropic-compatible API format.

### Rate Limits

| Model | RPM | TPM | Concurrent |
|-------|-----|-----|------------|
| M2.7 / M2.7-highspeed | 500 | 20,000,000 | 100 |
| M2.5 / M2.5-highspeed | 500 | 20,000,000 | 100 |
| M2.1 / M2.1-highspeed | 500 | 20,000,000 | 100 |
| M2 | 500 | 20,000,000 | 100 |

> **Token Plan** users have request quotas (5-hour reset + weekly cap). **Pay-As-You-Go** users have TPM/RPM limits based on account tier.

---

## MOONSHOT / KIMI

### Model Lineup

| Model | Release | Context | Max Output | Input ($/M) | Cached Input ($/M) | Output ($/M) | Input (CNY/M) | Output (CNY/M) |
|-------|---------|---------|------------|-------------|-------------------|--------------|---------------|----------------|
| **Kimi K2.6** | 2026-04 | 262K | 32K | $0.95 | $0.16 | $4.00 | ¥6.80 | ¥28.80 |
| **Kimi K2-0905** | 2025-09 | 262K | 16K | $0.60 | $0.15 | $2.50 | ¥4.30 | ¥18.00 |
| **Kimi K2-0711** | 2025-07 | 131K | 16K | $0.60 | $0.15 | $2.50 | ¥4.30 | ¥18.00 |
| **Kimi K2-Turbo** | 2025-09 | 262K | 16K | $1.15 | $0.15 | $8.00 | ¥8.30 | ¥57.60 |
| **Kimi K2-Thinking** | 2026-04 | 262K | 16K | $0.60 | $0.15 | $2.50 | ¥4.30 | ¥18.00 |
| **Kimi K2-Thinking-Turbo** | 2026-04 | 262K | 16K | $1.15 | $0.15 | $8.00 | ¥8.30 | ¥57.60 |
| **Moonshot V1-128K** | 2024-05 | 128K | 8K | $0.60 | — | $2.50 | ¥4.30 | ¥18.00 |
| **Moonshot V1-32K** | 2024-05 | 32K | 4K | $0.20 | — | $2.00 | ¥1.40 | ¥14.40 |
| **Moonshot V1-8K** | 2024-05 | 8K | 4K | $0.20 | — | $2.00 | ¥1.40 | ¥14.40 |

### Kimi Chat Membership (CN)

| Plan | Price | Quota Multiplier | Speed |
|------|-------|------------------|-------|
| **Andante** | ¥49/mo | 1x | 100 tok/s |
| **Moderato** | ¥99/mo | 4x | — |
| **Allegretto** | ¥199/mo | 20x | — |
| **Allegro** | ¥699/mo | 60x | — |

> **Andante limits:** 1M uncached tokens / 5hrs, 4M uncached tokens / week, 30 concurrent.

### API Rate Limits (by Cumulative Recharge)

| Tier | Cumulative Recharge | Concurrency | RPM | TPM | TPD |
|------|---------------------|-------------|-----|-----|-----|
| **Tier0** | $1 | 1 | 3 | 500K | 1.5M |
| **Tier1** | $10 | 50 | 200 | 2M | Unlimited |
| **Tier2** | $20 | 100 | 500 | 3M | Unlimited |
| **Tier3** | $100 | 200 | 5,000 | 3M | Unlimited |
| **Tier4** | $1,000 | 400 | 5,000 | 4M | Unlimited |
| **Tier5** | $3,000 | 1,000 | 10,000 | 5M | Unlimited |

### API Endpoints

| Platform | Endpoint |
|----------|----------|
| **Kimi API Platform** | `https://api.moonshot.cn/v1/chat/completions` |
| **Moonshot International** | `https://api.kimi.ai/v1/chat/completions` |

> **Note:** Kimi ties rate limits to cumulative recharge amount. Vouchers do not count toward recharge total.

---

## BYTEDANCE / DOUBAO

### Model Lineup (Seed 2.0 Series)

| Model | Release | Context | Max Output | Input ($/M) | Output ($/M) | Notes |
|-------|---------|---------|------------|-------------|--------------|-------|
| **Seed 2.0 Pro** | 2026-02 | 256K | 128K | $0.47 | $1.88 | Flagship; Codeforces 3020 |
| **Seed 2.0 Lite** | 2026-02 | 256K | 128K | $0.25 | $1.00 | Production balance |
| **Seed 2.0 Mini** | 2026-02 | 256K | 128K | $0.10 | $0.40 | High concurrency |
| **Seed 2.0 Code** | 2025-10 | 256K | 16K | $0.15 | $0.60 | Coding-focused |
| **Doubao Pro 256K** | 2024-05 | 256K | 8K | $0.35 | $1.40 | Long-context |
| **Doubao Pro 128K** | 2024-05 | 128K | 8K | $0.25 | $1.00 | Standard |
| **Doubao Pro 32K** | 2024-05 | 32K | 4K | $0.15 | $0.60 | Fast |
| **Doubao Lite 128K** | 2024-05 | 128K | 8K | $0.10 | $0.40 | Cost-optimized |
| **Doubao Lite 32K** | 2024-05 | 32K | 4K | $0.05 | $0.20 | Budget |

### Seed 2.0 Mini Reasoning Modes

| Mode | Performance | Token Usage | Use Case |
|------|-------------|-------------|----------|
| **minimal** | ~85% of hi | ~1/10 | Classification, formatting |
| **low** | Higher | More | Simple reasoning |
| **medium** | Balanced | Moderate | Standard tasks |
| **hi** | Maximum | Full | Complex reasoning |

### Coding Plan (Volcano Engine)

| Plan | Price | Per 5hrs | Per Week | Per Month | Models |
|------|-------|----------|----------|-----------|--------|
| **Lite** | ¥40/mo | ~1,200 | ~9,000 | ~18,000 | Seed-2.0-Code, M2.7, K2.6, GLM-5.1 |
| **Pro** | ¥200/mo | ~6,000 | ~45,000 | ~90,000 | Same as Lite |

### Doubao App Subscription (CN — Chatbot, not API)

| Plan | Price / Mo | Price / Year |
|------|------------|--------------|
| **Standard** | ¥68 | ¥688 |
| **Enhanced** | ¥200 | ¥2,048 |
| **Professional** | ¥500 | ¥5,088 |

> **Note:** These are for the Doubao chatbot app, not API access.

### API Endpoints

| Region | Endpoint |
|--------|----------|
| **Beijing (Primary)** | `https://ark.cn-beijing.volces.com/api/v3/` |
| **Shanghai** | `https://ark.cn-shanghai.volces.com/api/v3/` |
| **Shenzhen** | `https://ark.cn-shenzhen.volces.com/api/v3/` |

> **Note:** Volcano Engine uses OpenAI-compatible API format. Model IDs must be explicitly specified (e.g., `doubao-seed-2-0-pro`).

### Rate Limits (Standard)

| Model | RPM | TPM | Concurrent |
|-------|-----|-----|------------|
| Seed 2.0 Pro | 100 | 1,500K | 50 |
| Seed 2.0 Lite | 200 | 2,000K | 100 |
| Seed 2.0 Mini | 30K | 1,500K | 200 |

> **Higher limits** available via enterprise agreement.

---

## SUMMARY COMPARISON

### Best Use Cases by Provider

| Use Case | Recommended Provider | Model | Why |
|----------|---------------------|--------|-----|
| **Longest context** | Moonshot / Alibaba | Kimi K2.6 / Qwen3.6-Plus | 256K–1M context |
| **Cheapest input** | MiniMax / ByteDance | M2.7 / Seed 2.0 Mini | ¥1.4–2.1 / M |
| **Best coding** | Alibaba / Zhipu | Qwen3-Coder-Plus / GLM-5 | Strong benchmarks |
| **Best reasoning** | ByteDance / Alibaba | Seed 2.0 Pro / Qwen3-Max | AIME 98.3 / MMLU 83.8 |
| **Fastest response** | MiniMax | M2.7-highspeed | 128 tok/s |
| **Best value** | MiniMax | M2.7 | $0.30/$1.20, 200K context |
| **Enterprise China** | Alibaba Bailian | Team Edition | Full catalog, compliance |

### API Format Summary

| Provider | Format | Endpoint Pattern |
|----------|--------|------------------|
| Alibaba Bailian | OpenAI-compatible | `pailangstudio.*.aliyuncs.com` |
| Zhipu / GLM | OpenAI-compatible | `open.bigmodel.cn/api/paas/v4/` |
| MiniMax | Anthropic-compatible | `api.minimax.io/v1/text/chat_completion_v2` |
| Moonshot / Kimi | OpenAI-compatible | `api.moonshot.cn/v1/chat/completions` |
| ByteDance / Doubao | OpenAI-compatible | `ark.*.volces.com/api/v3/` |

---

## NOTES

1. **Exchange rates:** All CNY prices converted at ~¥7.2 = $1.00 (May 2026). Actual rates vary.
2. **Cache pricing:** Most providers offer 10–20% of base price for cached input tokens.
3. **Rate limit scaling:** All providers scale limits with usage/recharge. Contact sales for enterprise tiers.
4. **Token counting:** 1M tokens ≈ 750,000 English words ≈ 375,000 Chinese characters.
5. **Free tiers:** GLM-4.7-Flash, GLM-4.5-Flash, and GLM-4.6V-Flash offer free inference.

---

*Document generated: May 2026*  
*Data sources: Official provider docs, pricing pages, community benchmarks*
