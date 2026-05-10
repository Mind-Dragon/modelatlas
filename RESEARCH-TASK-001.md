# RESEARCH-TASK-001: Comprehensive AI Provider / Model / Plan / Endpoint Database

## Mission
Build a complete, structured database of every AI LLM provider, their models, plans, pricing, endpoints, rate limits, and capabilities. This database powers Hermes Modeler's provider intelligence layer.

## Outputs Required
1. `FINAL-SYNTHESIS.md` — Complete database schema design + data dump of all providers
2. Each domain produces a `DOMAIN{N}-{PROVIDER}.md` file with structured data

## Deliverable Format
The final database schema must support these dimensions:
- Providers (name, slug, website, category, region)
- Plans (free, pro, enterprise, token-plan, team, edu, etc.)
- Models per provider+plan (id, display name, context window, max output, training cutoff)
- Endpoints per provider (base URL, API version, auth method)
- Pricing per model+plan+endpoint (input token, output token, cached input, batch discount)
- Rate limits per model+plan (RPM, RPD, TPM, concurrent connections)
- Capabilities per model (vision, tools, streaming, function calling, structured output, image gen, audio)

## Schema Design Constraints
- Must normalize across wildly different pricing models (per-token, per-request, subscription-based, token-plan)
- Must handle both per-model and per-plan rate limits
- Must track deprecated/legacy endpoints vs active
- Must support multiple regions per provider (US, EU, Asia)
- Must support model aliases (name changes, version bumps)
- Must export as both SQL DDL + JSON seed data

## Domains
1. OpenAI — GPT-4o, GPT-4.1, o-series, GPT-4.5, DALL-E, Whisper, TTS
2. Anthropic — Claude 4 Opus/Sonnet/Haiku, Claude 3.5
3. Google — Gemini 2.5 Pro/Flash, Gemini 1.5, Vertex AI
4. xAI — Grok-3, Grok-4, Grok-4.1
5. Meta — Llama 4, Llama 3.x (via all inference providers)
6. DeepSeek — DeepSeek-V3, R1, R2
7. Alibaba/Qwen — Qwen3, Qwen2.5, Tongyi Qianwen
8. Zhipu/GLM — GLM-4, GLM-5, CodeGeeX
9. Minimax — MiniMax-M1, M2.5, M2.7
10. Kimi/Moonshot — kimi, koi
11. ByteDance — Doubao, seed models
12. Mistral — Mistral Large/Small, Pixtral, Le Chat
13. API Aggregators — OpenRouter, Together AI, Fireworks, Groq
14. Others — Cohere, AI21, Perplexity, Reka, Yi/01.AI, Baichuan

Task hash 001-deerflow-modeldb must be preserved.
