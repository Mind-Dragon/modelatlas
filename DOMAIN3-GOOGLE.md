# Domain 3: GOOGLE (Gemini, Vertex AI)

Research hash: 001-deerflow-modeldb  
Last updated: 2026-05-09

---

## 1. Google AI Studio / Gemini API Plans

| Plan | Cost | Key Features | Data Usage |
|------|------|-------------|------------|
| **Free** | $0 | Limited model access; Google AI Studio UI; free tokens on select models | Content used to improve products |
| **Pay-as-you-go (Tier 1)** | Per-usage billing | Higher rate limits; context caching; Batch API (50% discount); advanced models | Content NOT used to improve products |
| **Tier 2** | $250+ cumulative spend | 1,000+ RPM; 2M-4M TPM; 10,000 RPD | Content NOT used to improve products |
| **Tier 3 / Enterprise** | $1,000+ cumulative spend or sales engagement | 2,000-4,000+ RPM; 4M+ TPM; 50,000+ RPD; dedicated support; volume discounts; provisioned throughput | Content NOT used to improve products |

**Tier upgrade rules:**
- Free -> Tier 1: Instant upon linking billing account
- Tier 1 -> Tier 2: $100 paid + 3 days from first payment (or $250 cap)
- Tier 2 -> Tier 3: $1,000 paid + 30 days
- Upgrades apply to total Google Cloud spend on the linked billing account

---

## 2. Gemini Models Reference

| Model | Status | Description |
|-------|--------|-------------|
| **Gemini 2.5 Pro** | Stable (GA) | State-of-the-art multipurpose model; excels at coding, complex reasoning, deep research |
| **Gemini 2.5 Flash** | Stable (GA) | Hybrid reasoning model with thinking budgets; best price-performance for high-volume tasks |
| **Gemini 2.5 Flash-Lite** | Stable (GA) | Fastest, most budget-friendly model in the 2.5 family |
| **Gemini 2.0 Flash** | Stable (GA) | General-purpose multimodal workhorse; fast and efficient |
| **Gemini 2.0 Flash-Lite** | Stable (GA) | Lowest-latency, most cost-effective for simple tasks |
| **Gemini 1.5 Pro** | Stable (GA) | Long-context specialist (2M tokens); strong multimodal understanding |
| **Gemini 1.5 Flash** | Stable (GA) | Balanced speed and quality with 1M context |
| **Gemini 1.5 Flash-8B** | Stable (GA) | Smallest, most efficient 1.5 variant; lowest cost per intelligence |

---

## 3. Context Windows, Max Output Tokens, Training Cutoff

| Model | Context Window | Max Output Tokens | Training Cutoff |
|-------|---------------|-------------------|-----------------|
| Gemini 2.5 Pro | 1,048,576 (1M) | 65,535 | 2025-01 |
| Gemini 2.5 Flash | 1,048,576 (1M) | 8,192 | 2025-01 |
| Gemini 2.5 Flash-Lite | 1,048,576 (1M) | 8,192 | 2025-01 |
| Gemini 2.0 Flash | 1,048,576 (1M) | 8,192 | 2024-08 |
| Gemini 2.0 Flash-Lite | 1,048,576 (1M) | 8,192 | 2024-08 |
| Gemini 1.5 Pro | 2,097,152 (2M) | 8,192 | 2024-05 |
| Gemini 1.5 Flash | 1,048,576 (1M) | 8,192 | 2024-05 |
| Gemini 1.5 Flash-8B | 1,048,576 (1M) | 8,192 | 2024-05 |

**Notes:**
- 2.5 Pro default output is 65,535 tokens; other models default to 8,192.
- Context window counts total input + output tokens.
- Gemini 1.5 Pro is the only model in this list with a 2M token window; 2.5 Pro has been announced for 2M expansion but currently ships at 1M.

---

## 4. Modalities & Capabilities

| Capability | 2.5 Pro | 2.5 Flash | 2.5 Flash-Lite | 2.0 Flash | 2.0 Flash-Lite | 1.5 Pro | 1.5 Flash | 1.5 Flash-8B |
|-----------|---------|-----------|----------------|-----------|----------------|---------|-----------|--------------|
| **Text input/output** | Yes | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
| **Image input** | Yes | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
| **Video input** | Yes | Yes | Yes | Yes | Limited | Yes | Yes | Yes |
| **Audio input** | Yes | Yes | Yes | Yes | No | Yes | Yes | Yes |
| **Code execution** | Yes | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
| **Tool use / Function calling** | Yes | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
| **Streaming** | Yes | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
| **Structured output (JSON)** | Yes | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
| **Grounding (Google Search)** | Yes | Yes | No | Yes | No | Yes | Yes | Yes |
| **Grounding (Google Maps)** | Yes | Yes | No | No | No | No | No | No |
| **Image generation** | No | No (Nano Banana variant) | No | Shut down | No | No | No | No |
| **Native audio (Live API)** | No | Yes (Flash Live) | No | No | No | No | No | No |

**Thinking / Reasoning control (2.5 Flash):**
- `thinkingBudget` parameter controls how many thinking tokens the model uses.
- Setting budget to 0 disables reasoning; higher budgets increase quality and latency.
- Thinking tokens are billed as output tokens.

---

## 5. Pricing Per Model (USD)

### Gemini 2.5 Pro

| Tier | Input (<=200K) | Input (>200K) | Output (<=200K) | Output (>200K) |
|------|----------------|---------------|-----------------|----------------|
| Free | Free | Free | Free | Free |
| Paid | $1.25 / 1M | $2.50 / 1M | $10.00 / 1M | $15.00 / 1M |

### Gemini 2.5 Flash

| Tier | Input (text/img/vid) | Input (audio) | Output |
|------|----------------------|---------------|--------|
| Free | Free | Free | Free |
| Paid | $0.30 / 1M | $1.00 / 1M | $2.50 / 1M |

### Gemini 2.5 Flash-Lite

| Tier | Input (text/img/vid) | Input (audio) | Output |
|------|----------------------|---------------|--------|
| Free | Free | Free | Free |
| Paid | $0.10 / 1M | $0.30 / 1M | $0.40 / 1M |

### Gemini 2.0 Flash

| Tier | Input (text/img/vid) | Input (audio) | Output |
|------|----------------------|---------------|--------|
| Free | Free | Free | Free |
| Paid | $0.10 / 1M | $0.70 / 1M | $0.40 / 1M |

### Gemini 2.0 Flash-Lite

| Tier | Input | Output |
|------|-------|--------|
| Free | Free | Free |
| Paid | $0.075 / 1M | $0.30 / 1M |

### Gemini 1.5 Pro

| Tier | Input (<=128K) | Input (>128K) | Output (<=128K) | Output (>128K) |
|------|----------------|---------------|-----------------|----------------|
| Free | Free | Free | Free | Free |
| Paid | $1.25 / 1M | $2.50 / 1M | $5.00 / 1M | $10.00 / 1M |

### Gemini 1.5 Flash

| Tier | Input (<=128K) | Input (>128K) | Output (<=128K) | Output (>128K) |
|------|----------------|---------------|-----------------|----------------|
| Free | Free | Free | Free | Free |
| Paid | $0.075 / 1M | $0.15 / 1M | $0.30 / 1M | $0.60 / 1M |

### Gemini 1.5 Flash-8B

| Tier | Input (<=128K) | Output (<=128K) |
|------|----------------|-----------------|
| Free | Free | Free |
| Paid | $0.0375 / 1M | $0.15 / 1M |

### Multimodal Token Conversions

| Modality | Token Equivalent | Notes |
|----------|-----------------|-------|
| **Text** | ~4 characters = 1 token | 100 tokens ~ 60-80 English words |
| **Image (1024x1024)** | 1,290 tokens | Varies by resolution |
| **Video** | 258 tokens / second | Per second of video input |
| **Audio** | 25 tokens / second (Live API) | Varies by model and quality |

---

## 6. Cached Content & Batch Pricing

### Context Caching

| Model | Cache Write (<=200K) | Cache Write (>200K) | Cache Storage / Hour |
|-------|---------------------|---------------------|---------------------|
| Gemini 2.5 Pro | $0.125 / 1M | $0.25 / 1M | $4.50 / 1M tokens |
| Gemini 2.5 Flash | $0.03 / 1M | $0.03 / 1M | Hourly rate applies |
| Gemini 2.5 Flash-Lite | $0.01 / 1M | $0.01 / 1M | Hourly rate applies |
| Gemini 2.0 Flash | $0.025 / 1M | $0.025 / 1M | Hourly rate applies |
| Gemini 1.5 Pro | $0.3125 / 1M | $0.625 / 1M | $4.50 / 1M tokens |
| Gemini 1.5 Flash | $0.01875 / 1M | $0.0375 / 1M | Hourly rate applies |

**How caching works:**
- Pay once to cache context (e.g., a large document or system prompt).
- Subsequent requests referencing the cached content pay only the cached-input rate (significantly lower than standard input).
- Storage is billed hourly per million cached tokens.

### Batch API

| Feature | Detail |
|---------|--------|
| **Cost reduction** | 50% off standard pricing |
| **Max concurrent batch requests** | 100 |
| **Max input file size** | 2 GB |
| **Max file storage** | 20 GB |
| **Latency** | Async; results returned within 24 hours |
| **Availability** | All Gemini 3.x, 2.5, 2.0, 1.5 models |

---

## 7. Free Tier Rate Limits, Paid Tier Rate Limits, Quota System

### Free Tier Limits

| Model | RPM | TPM | RPD |
|-------|-----|-----|-----|
| Gemini 2.5 Pro | 5 | 250,000 | 100 |
| Gemini 2.5 Flash | 10 | 250,000 | 250 |
| Gemini 2.5 Flash-Lite | 15 | 250,000 | 1,000 |
| Gemini 2.0 Flash | 15 | 250,000 | 1,500 |
| Gemini 2.0 Flash-Lite | 15 | 250,000 | 1,500 |
| Gemini 1.5 Pro | 2 | 32,000 | 50 |
| Gemini 1.5 Flash | 15 | 250,000 | 1,500 |
| Gemini 1.5 Flash-8B | 15 | 250,000 | 1,500 |

### Tier 1 (Pay-as-you-go) Limits

| Model | RPM | TPM | RPD |
|-------|-----|-----|-----|
| Gemini 2.5 Pro | 150 | 1,000,000 | 1,000 |
| Gemini 2.5 Flash | 300 | 2,000,000 | 1,500 |
| Gemini 2.5 Flash-Lite | 300 | 2,000,000 | 1,500 |
| Gemini 2.0 Flash | 1,000 | 4,000,000 | 10,000 |
| Gemini 2.0 Flash-Lite | 1,000 | 4,000,000 | 10,000 |

### Tier 2 Limits

| Model | RPM | TPM | RPD |
|-------|-----|-----|-----|
| Gemini 2.5 Pro | 1,000 | 2,000,000 | 10,000 |
| Gemini 2.5 Flash | 2,000 | 4,000,000 | 10,000 |
| Gemini 2.5 Flash-Lite | 2,000 | 4,000,000 | 10,000 |

### Tier 3 (Enterprise) Limits

| Metric | Typical Range |
|--------|---------------|
| RPM | 2,000 - 4,000+ |
| TPM | 4,000,000+ |
| RPD | 50,000 - Unlimited |

### Quota System Rules

- Limits are **per Google Cloud project**, not per API key.
- Exceeding **any single limit** (RPM, TPM, or RPD) triggers a 429 error.
- RPD quotas reset at **midnight Pacific Time**.
- Rolling 60-second windows are used for RPM/TPM.
- Priority inference runs at **0.3x** standard rate limits.
- Rate limit increase requests: https://forms.gle/ETzX94k8jf7iSotH9

---

## 8. Regional Endpoints

### Global Endpoint

- **Endpoint:** `aiplatform.googleapis.com/v1/.../locations/global/...`
- **Advantage:** Higher availability, reduced 429 errors, automatic load distribution.
- **Limitation:** Cannot enforce data residency; no tuning or Anthropic batch prediction.
- **Models supported:** All Gemini 2.x, 3.x models; Gemini Embeddings; Imagen; Veo; Lyria.

### Regional Endpoints (Americas)

| Region Code | Location |
|-------------|----------|
| us-central1 | Iowa |
| us-east1 | South Carolina |
| us-east4 | N. Virginia |
| us-east5 | Columbus |
| us-west1 | Oregon |
| us-west4 | Las Vegas |
| us-south1 | Dallas |
| northamerica-northeast1 | Montreal |
| southamerica-east1 | Sao Paulo |

### Regional Endpoints (Europe)

| Region Code | Location |
|-------------|----------|
| europe-west1 | Belgium |
| europe-west2 | London |
| europe-west3 | Frankfurt |
| europe-west4 | Netherlands |
| europe-west6 | Zurich |
| europe-west8 | Milan |
| europe-west9 | Paris |
| europe-north1 | Finland |
| europe-central2 | Warsaw |
| europe-southwest1 | Madrid |

### Regional Endpoints (Asia Pacific)

| Region Code | Location |
|-------------|----------|
| asia-east1 | Taiwan |
| asia-east2 | Hong Kong |
| asia-northeast1 | Tokyo |
| asia-northeast2 | Osaka |
| asia-northeast3 | Seoul |
| asia-southeast1 | Singapore |
| asia-south1 | Mumbai |
| australia-southeast1 | Sydney |

### Regional Endpoints (Middle East)

| Region Code | Location |
|-------------|----------|
| me-west1 | Tel Aviv |
| me-central1 | Doha |
| me-central2 | Dammam |

**Multi-region endpoints:** `us` (United States), `eu` (Europe)

---

## 9. Gemini API vs Vertex AI Differences

| Feature | Gemini Developer API | Vertex AI (Gemini API in Vertex) |
|---------|---------------------|----------------------------------|
| **Target audience** | Developers, startups, prototypes, small-to-medium apps | Enterprises, ML teams, production at scale |
| **Authentication** | Simple API key | IAM + Service Accounts + ADC |
| **Endpoint** | `generativelanguage.googleapis.com` | `aiplatform.googleapis.com` |
| **Free tier** | Yes — ongoing free tokens | $300 credit for new users + free previews |
| **SLA guarantee** | No | Yes — Vertex AI Platform SLA |
| **Data residency control** | Not configurable | Regional endpoints (US, EU, Asia, etc.) |
| **VPC / Private networking** | No | VPC Service Controls |
| **Audit logs** | No | Cloud Logging / Monitoring |
| **Encryption** | Google-managed | Customer-managed encryption keys (CMEK) |
| **Model garden** | Gemini + Imagen + Veo only | 200+ models (Gemini, Claude, Llama, Gemma, DeepSeek, etc.) |
| **Cloud integrations** | Limited | BigQuery, Cloud Storage, Agent Builder, Model Garden |
| **Billing** | Prepaid / Postpaid | Google Cloud Billing with volume discounts |
| **Batch API** | Yes (50% discount) | Yes (Cloud-integrated scheduling) |
| **Provisioned throughput** | No | Yes (Tier 3+) |
| **Data used for training** | Yes (free tier only) | No |
| **SDK** | Google Gen AI SDK | Google Gen AI SDK (same library, one flag change) |

### Code Example: Same SDK, Two Routes

```python
# Gemini Developer API
from google import genai
client = genai.Client(api_key="YOUR_API_KEY")

# Vertex AI
client = genai.Client(
    vertexai=True,
    project="YOUR_PROJECT_ID",
    location="us-central1"
)
```

### Decision Guidance

| Situation | Recommended Route |
|-----------|-------------------|
| Prototyping, prompt iteration, internal demos | Gemini Developer API |
| Consumer app without strict compliance needs | Gemini Developer API |
| Requires IAM, audit logs, VPC, CMEK, regional controls | Vertex AI |
| Centralized billing, quota governance, production monitoring | Vertex AI |
| Need 200+ models (Claude, Llama, etc.) in one platform | Vertex AI |
| Need provisioned throughput / guaranteed latency | Vertex AI |

---

## Sources

- https://ai.google.dev/gemini-api/docs/pricing
- https://ai.google.dev/gemini-api/docs/rate-limits
- https://ai.google.dev/gemini-api/docs/models
- https://cloud.google.com/vertex-ai/generative-ai/pricing
- https://docs.cloud.google.com/vertex-ai/generative-ai/docs/learn/locations
- https://github.com/HaoooWang/llm-knowledge-cutoff-dates
- https://blog.laozhang.ai/en/posts/gemini-api-vs-vertex-api
- https://www.aifreeapi.com/en/posts/gemini-api-rate-limits-per-tier
