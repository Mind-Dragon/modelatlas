# ModelAtlas

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Compatible-336791.svg?logo=postgresql)](https://www.postgresql.org/)
[![Providers](https://img.shields.io/badge/Providers-25-green.svg)]()
[![Models](https://img.shields.io/badge/Models-80%2B-orange.svg)]()
[![Plans](https://img.shields.io/badge/Plans-120%2B-yellow.svg)]()
[![Endpoints](https://img.shields.io/badge/Endpoints-35%2B-blue.svg)]()

The most comprehensive open database of AI language models, provider pricing plans, rate limits, API endpoints, and model capabilities — normalized into a PostgreSQL schema with full seed data and JSON exports.

## Overview

ModelAtlas catalogs every major LLM provider across 6 categories:

- **US AI Labs** — OpenAI, Anthropic, Google, xAI, Cohere, AI21 Labs, Perplexity, Reka
- **Chinese AI Labs** — DeepSeek, Alibaba (Qwen), Zhipu (GLM), MiniMax, Moonshot (Kimi), ByteDance, 01.AI, Baichuan
- **European AI Labs** — Mistral AI
- **API Aggregators** — OpenRouter, Together AI, Fireworks AI, Groq, Hugging Face
- **Cloud Platforms** — Microsoft Azure, Amazon Bedrock
- **Open-Source Publishers** — Meta (Llama family)

Each provider is cataloged across **8 normalized dimensions**: plans, models, pricing, rate limits, endpoints, capabilities, aliases, and lifecycle dates.

## Schema

```
┌─────────────┐       ┌──────────────────┐       ┌─────────────────┐
│  providers  │──────▶│ provider_plans   │       │    models       │
│  (25 rows)  │       │  (120+ rows)     │       │   (80+ rows)    │
└─────────────┘       └──────────────────┘       └────────┬────────┘
                                                          │
                                                          ▼
┌──────────────────┐       ┌──────────────────┐       ┌─────────────────┐
│ model_endpoint   │◀──────│  model_pricing   │◀──────│ model_caps      │
│     _map         │       │  (per-region)    │       │  (feature matrix)│
└────────┬─────────┘       └──────────────────┘       └─────────────────┘
         │
         ▼
┌──────────────────┐       ┌──────────────────┐       ┌─────────────────┐
│  endpoints       │       │  model_aliases   │       │  (future)       │
│  (35+ rows)      │       │  (version map)   │       │  rate_limits    │
└──────────────────┘       └──────────────────┘       └─────────────────┘
```

### Tables

| Table | Rows | Description |
|-------|------|-------------|
| [`providers`](export/providers.json) | 25 | AI labs, aggregators, cloud platforms with metadata |
| [`provider_plans`](export/provider_plans.json) | 120+ | Free / Pro / Team / Enterprise / Token-plan / API tiers |
| [`models`](export/models.json) | 80+ | Model specs — context window, max output, training cutoff |
| [`model_capabilities`](export/model_capabilities.json) | — | Per-model feature matrix — text, vision, tool use, reasoning |
| [`model_pricing`](export/model_pricing.json) | — | Per-model per-region pricing — standard / batch / cached |
| [`endpoints`](export/endpoints.json) | 35+ | API base URLs with regional variants (US, EU, CN) |
| [`model_endpoint_map`](export/model_endpoint_map.json) | — | Model-to-endpoint routing with weights |
| [`model_aliases`](export/model_aliases.json) | — | Version aliases and timeline tracking |

## Quick Start

```bash
# Create the database
createdb modelatlas

# Apply schema
psql -d modelatlas -f schema.sql

# Load seed data
psql -d modelatlas -f seed.sql

# Query examples
psql -d modelatlas -c "SELECT id, name, category, region FROM providers ORDER BY name;"
psql -d modelatlas -c "SELECT slug, context_window_tokens, status FROM models WHERE provider_id = 'openai' ORDER BY slug;"
psql -d modelatlas -c "SELECT p.name, pl.slug, pl.tier, pl.monthly_price_usd FROM provider_plans pl JOIN providers p ON p.id = pl.provider_id WHERE pl.tier = 'free' ORDER BY p.name;"
```

## Data Dimensions

### Plan Types
`free` · `pro` · `team` · `enterprise` · `token_plan` · `edu` · `research` · `pay_as_you_go` · `subscription` · `custom`

### Billing Models
`per_token` · `subscription` · `token_plan` · `hybrid`

### Model Capabilities
`text` · `vision` · `image_generation` · `audio` · `video` · `tool_use` · `function_calling` · `structured_output` · `streaming` · `code_execution` · `reasoning` · `extended_thinking` · `computer_use` · `grounding` · `search` · `file_upload` · `multilingual` · `json_mode`

### Endpoint Types
`standard` · `batch` · `streaming` — with regional variants (US, EU, CN, multi)

### Model Lifecycle
`active` · `beta` · `deprecated` · `sunset` — with release, deprecation, and sunset dates tracked

## Pricing Snapshot

| Provider | Flagship Model | Input ($/1M) | Output ($/1M) | Context |
|----------|---------------|-------------:|--------------:|--------:|
| OpenAI | GPT-4.1 | $2.00 | $8.00 | 1M |
| Anthropic | Claude Opus 4.7 | $5.00 | $25.00 | 1M |
| Google | Gemini 2.5 Pro | $1.25 | $10.00 | 1M |
| xAI | Grok 4.3 | $1.25 | $2.50 | 1M |
| DeepSeek | V4 Pro | $0.44 | $0.87 | 1M |
| Alibaba | Qwen3-Max | $0.78 | $3.90 | 262K |
| Zhipu | GLM-5.1 | $1.40 | $4.40 | 200K |
| MiniMax | M2.7 | $0.15 | $0.75 | 200K |
| Mistral | Large 3 | $0.50 | $1.50 | 262K |
| Cohere | Command A | $2.50 | $10.00 | 256K |

*Full pricing data for all 80+ models in the database. Prices as of May 2026.*

## JSON Exports

Per-table JSON exports are available in the `export/` directory:

```bash
# Regenerate exports from FINAL-SYNTHESIS.md
python3 generate-exports.py
```

## Data Freshness

| Cadence | Providers |
|---------|-----------|
| **Daily** | OpenRouter model catalog |
| **Weekly** | OpenAI, Anthropic, Google, xAI, DeepSeek |
| **Monthly** | Chinese providers, Mistral, aggregators, cloud platforms |
| **Quarterly** | Cohere, AI21, Meta, Hugging Face, Reka, 01.AI, Baichuan |

> **Note:** AI pricing changes frequently. Always verify against official provider documentation before making production decisions. See `FINAL-SYNTHESIS.md` Part C for detailed freshness assessment per provider.

## Use Cases

- **Provider comparison** — Compare pricing, rate limits, and capabilities across providers
- **Cost optimization** — Find the cheapest model for your use case across all providers
- **API routing** — Use the endpoint map for intelligent request routing
- **Provider intelligence** — Track model lifecycles, deprecation dates, and version aliases
- **Hermes Modeler** — Powers the provider intelligence layer for Hermes Agent routing

## Repository Structure

```
modelatlas/
├── schema.sql                    # PostgreSQL DDL (8 tables, enums, indexes)
├── seed.sql                      # Full seed data INSERTs
├── generate-exports.py           # JSON export generator
├── FINAL-SYNTHESIS.md            # Complete reference (96KB, 1345 lines)
├── README.md                     # This file
├── LICENSE                       # Apache 2.0
├── .github/
│   └── ISSUE_TEMPLATE/           # GitHub issue templates
│       └── pricing_update.md     # Template for reporting pricing changes
│       └── provider_request.md   # Template for requesting new providers
│       └── bug_report.md         # Template for data errors
│   └── PULL_REQUEST_TEMPLATE.md  # PR template
├── export/
│   ├── manifest.json             # Export metadata
│   ├── providers.json            # 25 providers
│   ├── provider_plans.json       # All plans per provider
│   ├── models.json               # All models with specs
│   ├── model_capabilities.json   # Capability matrix
│   ├── model_pricing.json        # All pricing tiers
│   ├── endpoints.json            # All API endpoints
│   ├── model_endpoint_map.json   # Model-to-endpoint routing
│   └── model_aliases.json        # Version aliases
└── .swarm/                       # Research pipeline (reproducible)
    ├── domain1-openai.txt        # DeerFlow research prompts
    ├── domain2-anthropic.txt
    ├── domain3-google.txt
    ├── domain4-xai-deepseek.txt
    ├── domain5-chinese-providers.txt
    ├── domain6-mistral-aggregators.txt
    ├── domain7-others.txt
    ├── synthesis-modeldb.txt     # Synthesis prompt
    └── launch-deerflow-modeldb.sh # Swarm launcher
```

## Research Methodology

Data was collected via a DeerFlow parallel research swarm — 7 domain agents researching providers in parallel, followed by a synthesis agent that normalized findings into a unified PostgreSQL schema. See `.swarm/` for reproducible research prompts.

## Contributing

Contributions are welcome! If you find pricing errors, missing providers, or outdated model specs:

1. Open an issue with the data source
2. Submit a PR with corrected seed data
3. For new providers, use the `provider_request.md` issue template

## License

Apache License 2.0 — See [LICENSE](LICENSE) for details.

Data compiled from public provider documentation pages. Provider names, logos, and trademarks remain property of their respective owners.

## Acknowledgments

- Generated via DeerFlow research swarm using Hermes Agent (Nous Research)
- Data sourced from official provider pricing pages, documentation, and public APIs
- Schema designed for Hermes Modeler provider intelligence layer
