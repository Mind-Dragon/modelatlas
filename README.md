# DeerFlow ModelDB

**Comprehensive AI Provider / Model / Plan / Pricing Database** for Hermes Modeler.

Catalog of 25 AI providers, 80+ models, 120+ pricing plans, rate limits, endpoints, and capabilities — normalized into a PostgreSQL schema with full seed data and JSON exports.

## Quick Start

```bash
# Create the database
createdb deerflow_modeldb

# Apply schema
psql -d deerflow_modeldb -f schema.sql

# Load seed data
psql -d deerflow_modeldb -f seed.sql
```

## Schema (8 tables)

| Table | Description |
|-------|-------------|
| `providers` | AI labs, aggregators, cloud platforms — 25 entries |
| `provider_plans` | Free/Pro/Enterprise/Token-plan/Tier — 120+ entries |
| `models` | Model specs — context window, max output, training cutoff, status |
| `model_capabilities` | Per-model feature matrix — text, vision, tool use, streaming, reasoning |
| `model_pricing` | Per-model per-region pricing — standard/batch/cached/streaming |
| `endpoints` | API base URLs — 35+ endpoints across all providers |
| `model_endpoint_map` | Model-to-endpoint routing with weights |
| `model_aliases` | Version aliases and timeline tracking |

## Exports

JSON exports per table available in `export/`:

```bash
./generate-exports.py  # regenerates schema.sql, seed.sql, and JSON exports
```

## Providers Covered

### US AI Labs
OpenAI, Anthropic, Google, xAI, Cohere, AI21 Labs, Perplexity, Reka

### Chinese AI Labs  
DeepSeek, Alibaba/Qwen, Zhipu/GLM, MiniMax, Moonshot/Kimi, ByteDance/Doubao, 01.AI/Yi, Baichuan

### European AI Labs
Mistral AI

### API Aggregators
OpenRouter, Together AI, Fireworks AI, Groq, Hugging Face

### Cloud Platforms
Microsoft Azure, Amazon Bedrock

### Open-Source Publishers
Meta (Llama family — no first-party API, available via partners)

## Data Refresh

| Cadence | Providers |
|---------|-----------|
| **Daily** | OpenRouter model catalog |
| **Weekly** | OpenAI, Anthropic, Google, xAI, DeepSeek pricing |
| **Monthly** | Chinese providers, Mistral, aggregators, cloud platforms |
| **Quarterly** | Cohere, AI21, Meta, Hugging Face, Reka, 01.AI, Baichuan |

See `FINAL-SYNTHESIS.md` Part C for detailed freshness assessment per provider.

## Dimensions Tracked

- **Plans**: free, pro, team, enterprise, token_plan, edu, research, pay-as-you-go, subscription, custom, tiered
- **Billing models**: per_token, subscription, token_plan, hybrid
- **Endpoints**: standard, batch, streaming — with regional variants (US, EU, CN, multi)
- **Pricing**: input tokens, output tokens, cached tokens, batch discounts, image/video/audio pricing
- **Rate limits**: RPM, RPD, TPM, concurrent connections, batch sizes
- **Capabilities**: text, vision, image_generation, audio, video, tool_use, function_calling, structured_output, streaming, code_execution, reasoning, extended_thinking, computer_use, grounding, search, file_upload, multilingual, json_mode
- **Model lifecycle**: active, beta, deprecated, sunset — with release/deprecation/sunset dates

## Files

```
.
├── schema.sql                     # PostgreSQL DDL (8 tables + enums + indexes)
├── seed.sql                       # Full seed data INSERTs
├── generate-exports.py            # JSON export generator
├── FINAL-SYNTHESIS.md             # Complete reference (96KB, 1345 lines)
├── DOMAIN1-OPENAI.md              # Domain research files
├── DOMAIN2-ANTHROPIC.md
├── DOMAIN3-GOOGLE.md
├── DOMAIN4-XAI-DEEPSEEK.md
├── DOMAIN5-CHINESE-PROVIDERS.md
├── DOMAIN6-MISTRAL-AGGREGATORS.md
├── DOMAIN7-OTHERS.md
├── RESEARCH-TASK-001.md
└── export/
    ├── manifest.json
    ├── providers.json
    ├── provider_plans.json
    ├── models.json
    ├── model_capabilities.json
    ├── model_pricing.json
    ├── endpoints.json
    ├── model_endpoint_map.json
    └── model_aliases.json
```

## License

MIT — data compiled from public sources. Attribution to original provider documentation pages recommended.
