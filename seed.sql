-- ModelAtlas Seed Data
-- Generated 2026-05-09 from FINAL-SYNTHESIS.md
-- Run AFTER schema.sql

BEGIN;

INSERT INTO providers (id, slug, name, website, description, category, region, auth_type, status) VALUES
('openai',      'openai',       'OpenAI',          'https://openai.com',         'US AI research and deployment company — GPT, o-series, DALL-E, Whisper', 'us_ai_lab', 'us', 'api_key', 'active'),
('anthropic',   'anthropic',    'Anthropic',       'https://anthropic.com',      'AI safety company — Claude model family', 'us_ai_lab', 'us', 'api_key', 'active'),
('google',      'google',       'Google',          'https://ai.google.dev',      'Google Gemini API and Vertex AI platform', 'us_ai_lab', 'us', 'api_key', 'active'),
('xai',         'xai',          'xAI',             'https://x.ai',              'Elon Musks AI company — Grok model family', 'us_ai_lab', 'us', 'api_key', 'active'),
('deepseek',    'deepseek',     'DeepSeek',        'https://deepseek.com',       'Chinese AI lab — V4 Flash/Pro, R1', 'chinese_ai_lab', 'cn', 'api_key', 'active'),
('alibaba',     'alibaba',      'Alibaba Cloud',   'https://www.alibabacloud.com', 'Bailian platform — Qwen model family', 'chinese_ai_lab', 'cn', 'api_key', 'active'),
('zhipu',       'zhipu',        'Zhipu AI',        'https://zhipu.ai',          'Zhipu / BigModel — GLM model family', 'chinese_ai_lab', 'cn', 'api_key', 'active'),
('minimax',     'minimax',      'MiniMax',         'https://minimax.io',        'Chinese AI startup — MiniMax M-series', 'chinese_ai_lab', 'cn', 'api_key', 'active'),
('kimi',        'kimi',         'Moonshot AI',     'https://kimi.ai',           'Moonshot AI — Kimi K-series models', 'chinese_ai_lab', 'cn', 'api_key', 'active'),
('bytedance',   'bytedance',    'ByteDance',       'https://www.volcengine.com', 'ByteDance Volcano Engine — Doubao / Seed models', 'chinese_ai_lab', 'cn', 'api_key', 'active'),
('mistral',     'mistral',      'Mistral AI',      'https://mistral.ai',         'French AI company — Mistral, Codestral, Pixtral', 'eu_ai_lab', 'eu', 'api_key', 'active'),
('openrouter',  'openrouter',   'OpenRouter',      'https://openrouter.ai',     'Unified API gateway routing to 400+ models across 60+ providers', 'api_aggregator', 'multi', 'api_key', 'active'),
('together',    'together',     'Together AI',     'https://together.ai',       'Open-source model inference and fine-tuning platform', 'api_aggregator', 'multi', 'api_key', 'active'),
('fireworks',   'fireworks',    'Fireworks AI',    'https://fireworks.ai',      'Fast inference platform — FlashAttention, quantization', 'api_aggregator', 'multi', 'api_key', 'active'),
('groq',        'groq',         'Groq',            'https://groq.com',          'Ultra-fast LPU inference — open-source models only', 'api_aggregator', 'multi', 'api_key', 'active'),
('cohere',      'cohere',       'Cohere',          'https://cohere.com',         'Enterprise AI — Command models, embeddings', 'us_ai_lab', 'us', 'api_key', 'active'),
('ai21',        'ai21',         'AI21 Labs',       'https://studio.ai21.com',   'AI21 Labs — Jamba, Jurassic models', 'us_ai_lab', 'us', 'api_key', 'active'),
('perplexity',  'perplexity',   'Perplexity AI',   'https://perplexity.ai',     'AI search company — Sonar API', 'us_ai_lab', 'us', 'api_key', 'active'),
('meta',        'meta',         'Meta',            'https://llama.meta.com',     'Meta — Llama open-weight model family (no first-party API)', 'open_source', 'multi', 'none', 'active'),
('azure',       'azure',        'Microsoft Azure', 'https://azure.microsoft.com', 'Azure OpenAI Service — GPT, o-series via Microsoft', 'cloud_platform', 'multi', 'api_key', 'active'),
('aws',         'aws',          'Amazon Web Services', 'https://aws.amazon.com/bedrock/', 'Amazon Bedrock — multi-model managed service', 'cloud_platform', 'multi', 'oauth', 'active'),
('huggingface', 'huggingface',  'Hugging Face',    'https://huggingface.co',    'ML community platform — inference endpoints, model hub', 'api_aggregator', 'multi', 'api_key', 'active'),
('reka',        'reka',         'Reka AI',         'https://reka.ai',           'Multimodal AI — Core, Flash, Spark, Edge models', 'us_ai_lab', 'us', 'api_key', 'active'),
('yi',          'yi',           '01.AI',           'https://01.ai',             'Kai-Fu Lees company — Yi-Lightning, Yi-Large', 'chinese_ai_lab', 'cn', 'api_key', 'active'),
('baichuan',    'baichuan',     'Baichuan',        'https://baichuan-ai.com',   'Baichuan Intelligent Technology — Baichuan model family', 'chinese_ai_lab', 'cn', 'api_key', 'active');

-- OPENAI PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('openai', 'free',          'ChatGPT Free',       'free',          'subscription', 0,    'Free ChatGPT access — GPT-5.5 Instant, 10 msgs/5h', FALSE),
('openai', 'go',            'ChatGPT Go',         'pro',           'subscription', 8,    'Lower-cost consumer tier — 160 msgs/3h, 10 thinking/5h', FALSE),
('openai', 'plus',          'ChatGPT Plus',       'pro',           'subscription', 20,   'Standard consumer subscription — up to 3000 thinking/week', FALSE),
('openai', 'pro-lower',     'ChatGPT Pro (Lower)','pro',           'subscription', 100,  '5x Plus usage, GPT-5.5 Pro access', FALSE),
('openai', 'pro-top',       'ChatGPT Pro (Top)',  'pro',           'subscription', 200,  '20x Plus usage, highest Pro tier', FALSE),
('openai', 'business',      'ChatGPT Business',   'team',          'subscription', 25,   'Team workspace — virtually unlimited base-model, 3000 thinking/week', FALSE),
('openai', 'enterprise',    'ChatGPT Enterprise', 'enterprise',    'subscription', NULL, 'Custom pricing — unlimited, flexible credits, 10-region data residency', FALSE),
('openai', 'api-prepay',    'API Prepaid',        'pay_as_you_go', 'per_token',    NULL, 'Prepaid API credits — min $5, expire 12mo', TRUE),
('openai', 'tier1',         'API Tier 1',         'pay_as_you_go', 'per_token',    NULL, '$5 paid — $100/mo usage cap', TRUE),
('openai', 'tier2',         'API Tier 2',         'pay_as_you_go', 'per_token',    NULL, '$50 paid + 7 days — $500/mo cap', TRUE),
('openai', 'tier3',         'API Tier 3',         'pay_as_you_go', 'per_token',    NULL, '$100 paid + 7 days — $1000/mo cap', TRUE),
('openai', 'tier4',         'API Tier 4',         'pay_as_you_go', 'per_token',    NULL, '$250 paid + 14 days — $5000/mo cap', TRUE),
('openai', 'tier5',         'API Tier 5',         'pay_as_you_go', 'per_token',    NULL, '$1000 paid + 30 days — $200K/mo cap', TRUE);

-- ANTHROPIC PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('anthropic', 'free',         'Claude Free',       'free',          'subscription', 0,    '~15-40 msgs/5h, web search, extended thinking, remote MCP', FALSE),
('anthropic', 'pro',          'Claude Pro',        'pro',           'subscription', 20,   '~45 msgs/5h, Claude Code + Cowork, projects', FALSE),
('anthropic', 'max-5x',       'Claude Max 5x',     'pro',           'subscription', 100,  '~5x Pro usage, early access, priority', FALSE),
('anthropic', 'max-20x',      'Claude Max 20x',    'pro',           'subscription', 200,  '~20x Pro usage, highest consumer tier', FALSE),
('anthropic', 'team-std',     'Team Standard',     'team',          'subscription', 25,   'Min 5 seats, Claude Code+Cowork, SSO, admin', FALSE),
('anthropic', 'team-premium', 'Team Premium',      'team',          'subscription', 125,  '5x Standard seats, same Team features', FALSE),
('anthropic', 'enterprise-ss','Enterprise Self-Serve','enterprise', 'hybrid',       NULL, '$20/seat + API-rate usage, SCIM, audit, HIPAA-ready', TRUE),
('anthropic', 'enterprise-sa','Enterprise Sales-Assisted','enterprise','custom',    NULL, 'Custom MSA, PO, usage commitments, bundling', TRUE),
('anthropic', 'tier1',        'API Tier 1',        'pay_as_you_go', 'per_token',   NULL, '$5 buy-in, $100/mo limit', TRUE),
('anthropic', 'tier2',        'API Tier 2',        'pay_as_you_go', 'per_token',   NULL, '$40 buy-in, $500/mo limit', TRUE),
('anthropic', 'tier3',        'API Tier 3',        'pay_as_you_go', 'per_token',   NULL, '$200 buy-in, $1000/mo limit', TRUE),
('anthropic', 'tier4',        'API Tier 4',        'pay_as_you_go', 'per_token',   NULL, '$400 buy-in, $200K/mo limit', TRUE);

-- GOOGLE PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('google', 'free',           'Gemini API Free',    'free',          'subscription', 0,    'Free tokens on select models, AI Studio UI', FALSE),
('google', 'payg',           'Pay-as-you-go Tier 1','pay_as_you_go','per_token',   NULL, 'Higher limits, context caching, Batch API 50% off', TRUE),
('google', 'tier2',          'Tier 2',             'pay_as_you_go', 'per_token',  NULL, '$250+ cumulative spend, 1000+ RPM, 2M-4M TPM', TRUE),
('google', 'tier3',          'Tier 3 / Enterprise','enterprise',    'per_token',   NULL, '$1000+ spend, 2000-4000 RPM, 4M+ TPM, provisioned throughput', TRUE);

-- XAI PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('xai', 'free-x',          'Grok Free (X)',       'free',          'subscription', 0,    'Limited daily Grok on X.com/X app. No API access.', FALSE),
('xai', 'premium',         'X Premium',           'pro',           'subscription', 8,    'Grok + X platform features', FALSE),
('xai', 'premium-plus',    'X Premium+',          'pro',           'subscription', 40,   'Higher Grok limits + ad-free X', FALSE),
('xai', 'supergrok',       'SuperGrok',           'pro',           'subscription', 30,   'Grok app/grok.com: Grok 4 + 4.1, DeepSearch, Big Brain, Imagine', FALSE),
('xai', 'supergrok-heavy', 'SuperGrok Heavy',     'pro',           'subscription', 300,  'Grok 4 Heavy intensive reasoning', FALSE),
('xai', 'business',        'Grok Business',       'team',          'subscription', 30,   'SOC 2, team admin, audit logs', FALSE),
('xai', 'api-payg',        'API Pay-as-you-go',   'pay_as_you_go', 'per_token',    NULL, 'Prepaid credits, $25 free on signup, token-based', TRUE),
('xai', 'tier0',           'API Tier 0',          'pay_as_you_go', 'per_token',    NULL, '$0 default, ~60 RPM, 100K TPM', TRUE),
('xai', 'tier1',           'API Tier 1',          'pay_as_you_go', 'per_token',    NULL, '$50 spend, scales up', TRUE),
('xai', 'tier2',           'API Tier 2',          'pay_as_you_go', 'per_token',    NULL, '$250 spend', TRUE),
('xai', 'tier3',           'API Tier 3',          'pay_as_you_go', 'per_token',    NULL, '$1000 spend, ~2000 RPM, ~1M TPM', TRUE),
('xai', 'tier4',           'API Tier 4',          'pay_as_you_go', 'per_token',    NULL, '$5000 spend, higher limits', TRUE);

-- DEEPSEEK PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('deepseek', 'free-tokens', 'API Free Tier',      'free',          'token_plan',   0,    '5M free tokens for new accounts, 30-day expiry, no CC required', FALSE),
('deepseek', 'payg',        'API Pay-as-you-go',  'pay_as_you_go', 'per_token',   NULL, 'Prepaid balance, no monthly fee, no minimum', TRUE),
('deepseek', 'token-plan',  'Token Plan',         'token_plan',    'token_plan',  NULL, 'Bulk token purchase options', TRUE);

-- ALIBABA PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('alibaba', 'lightning',    'Lightning',            'token_plan',   'token_plan',  1.10, '¥7.9/mo coding plan — ~2000 credits/5h', FALSE),
('alibaba', 'standard-seat','Standard Seat',        'token_plan',   'token_plan',  27.50,'¥198/seat/mo — full Bailian catalog', FALSE),
('alibaba', 'team',         'Team Edition',         'enterprise',   'custom',      NULL, 'Multi-seat enterprise features', FALSE),
('alibaba', 'turbo-tier',   'Qwen-Turbo',           'pay_as_you_go','per_token',   NULL, '1000 RPM, 30K TPM, 10 concurrent', TRUE),
('alibaba', 'plus-tier',    'Qwen-Plus',            'pay_as_you_go','per_token',   NULL, '500 RPM, 20K TPM, 5 concurrent', TRUE),
('alibaba', 'max-tier',     'Qwen-Max',             'pay_as_you_go','per_token',   NULL, '100 RPM, 10K TPM, 2 concurrent', TRUE);

-- ZHIPU PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('zhipu', 'coding-lite',   'Coding Lite',          'token_plan',   'token_plan',  6.80, '¥49/mo — ~80 prompts/5h', FALSE),
('zhipu', 'coding-pro',    'Coding Pro',           'token_plan',   'token_plan',  20.70,'¥149/mo — ~400 prompts/5h', FALSE),
('zhipu', 'coding-max',    'Coding Max',           'token_plan',   'token_plan',  65.10,'¥469/mo — ~1600 prompts/5h', FALSE),
('zhipu', 'payg',          'Pay-as-you-go',        'pay_as_you_go','per_token',   NULL, 'Standard API token billing', TRUE);

-- MINIMAX PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('minimax', 'starter',     'Starter',               'token_plan',  'token_plan',  10.00, 'International: $10/mo, 1500 req/5h', FALSE),
('minimax', 'plus',        'Plus',                  'token_plan',  'token_plan',  20.00, 'International: $20/mo, 4500 req/5h', FALSE),
('minimax', 'max-plan',    'Max',                   'token_plan',  'token_plan',  50.00, 'International: $50/mo, 15000 req/5h', FALSE),
('minimax', 'payg',        'Pay-as-you-go',         'pay_as_you_go','per_token',  NULL, 'Standard token billing per model', TRUE);

-- BYTEDANCE PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('bytedance', 'coding-lite','Coding Lite',           'token_plan', 'token_plan',  5.55, '¥40/mo — ~1200 req/5h, Seed-2.0-Code, M2.7, K2.6, GLM-5.1', FALSE),
('bytedance', 'coding-pro', 'Coding Pro',            'token_plan', 'token_plan',  27.78,'¥200/mo — ~6000 req/5h', FALSE),
('bytedance', 'payg',       'Pay-as-you-go',         'pay_as_you_go','per_token', NULL, 'Standard API billing per model', TRUE),
('bytedance', 'standard-std','Standard',              'pay_as_you_go','per_token', NULL, 'Base tier rate limits', TRUE);

-- KIMI PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('kimi', 'andante',       'Andante',                'token_plan',  'token_plan', 6.80, '¥49/mo — 1x quota, 100 tok/s, 1M uncached/5h', FALSE),
('kimi', 'moderato',      'Moderato',               'token_plan',  'token_plan', 13.75,'¥99/mo — 4x quota', FALSE),
('kimi', 'allegretto',    'Allegretto',             'token_plan',  'token_plan', 27.64,'¥199/mo — 20x quota', FALSE),
('kimi', 'allegro',       'Allegro',                'token_plan',  'token_plan', 97.08,'¥699/mo — 60x quota', FALSE),
('kimi', 'payg',          'Pay-as-you-go',          'pay_as_you_go','per_token', NULL, 'Token billing, tiered rate limits by recharge', TRUE),
('kimi', 'tier0',         'API Tier 0',             'pay_as_you_go','per_token', NULL, '$1 recharge — 1 concurrency, 3 RPM, 500K TPM', TRUE),
('kimi', 'tier1',         'API Tier 1',             'pay_as_you_go','per_token', NULL, '$10 recharge — 50 concurrency, 200 RPM, 2M TPM', TRUE),
('kimi', 'tier2',         'API Tier 2',             'pay_as_you_go','per_token', NULL, '$20 recharge — 100 concurrency, 500 RPM, 3M TPM', TRUE),
('kimi', 'tier3',         'API Tier 3',             'pay_as_you_go','per_token', NULL, '$100 recharge — 200 concurrency, 5000 RPM, 3M TPM', TRUE),
('kimi', 'tier4',         'API Tier 4',             'pay_as_you_go','per_token', NULL, '$1000 recharge — 400 concurrency, 5000 RPM, 4M TPM', TRUE),
('kimi', 'tier5',         'API Tier 5',             'pay_as_you_go','per_token', NULL, '$3000 recharge — 1000 concurrency, 10000 RPM, 5M TPM', TRUE);

-- MISTRAL PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('mistral', 'free',        'Le Chat Free',          'free',         'subscription', 0,    'Core chat, limited messages, 500 memories', FALSE),
('mistral', 'pro',         'Le Chat Pro',           'pro',          'subscription', 14.99,'More messages, extended thinking, 15GB, Vibe CLI', FALSE),
('mistral', 'team',        'Le Chat Team',          'team',         'subscription', 24.99,'30GB/user, domain verification, export, admin', FALSE),
('mistral', 'enterprise',  'Le Chat Enterprise',    'enterprise',   'custom',       NULL, 'On-premise, custom models, SAML SSO, white label', FALSE),
('mistral', 'experiment',  'API Free (Experiment)', 'free',         'per_token',    0,    '~1 RPS, 30 RPM, evaluation only', FALSE),
('mistral', 'scale',       'API Tier 1 (Scale)',    'pay_as_you_go','per_token',    NULL, 'Upgrade to paid — increased limits', TRUE),
('mistral', 'tier2',       'API Tier 2',            'pay_as_you_go','per_token',    NULL, '$20 cumulative billed — higher RPS+TPM', TRUE),
('mistral', 'tier3',       'API Tier 3',            'pay_as_you_go','per_token',    NULL, '$100 cumulative billed', TRUE),
('mistral', 'tier4',       'API Tier 4',            'pay_as_you_go','per_token',    NULL, '$500 cumulative billed', TRUE);

-- AGGREGATOR PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('openrouter', 'free',       'Free',                  'free',        'per_token',   0,    '50 req/day, 20 RPM, 25+ free models', FALSE),
('openrouter', 'payg',       'Pay-as-you-go',         'pay_as_you_go','per_token', NULL, '5.5% markup, 400+ models, 60+ providers, $0.80 min credit', FALSE),
('openrouter', 'enterprise', 'Enterprise',            'enterprise',  'custom',      NULL, 'Volume discounts, optional dedicated limits, BYOK 1M free/mo', FALSE),
('together',   'payg',       'Serverless Pay-as-you-go','pay_as_you_go','per_token',NULL, 'Open-source inference, $25 free credits', TRUE),
('together',   'dedicated',  'Dedicated GPU',         'custom',     'custom',      NULL, 'H100 $3.99/hr, H200 $5.49/hr, B200 $9.95/hr', FALSE),
('fireworks',  'payg',       'Serverless Pay-as-you-go','pay_as_you_go','per_token',NULL, 'Fast inference, $1 free credits, 50% batch discount', TRUE),
('fireworks',  'priority',   'Priority Tier',         'pay_as_you_go','per_token', NULL, 'Preview — lower latency, ~50% premium', FALSE),
('groq',       'free',       'Free Tier',             'free',        'per_token',   0,    '30 RPM, 6K TPM, 14.4K RPD per model', FALSE),
('groq',       'developer',  'Developer Tier',        'pay_as_you_go','per_token', NULL, 'Credit card, ~10x free limits, 25% off all tokens', TRUE),
('groq',       'enterprise', 'Enterprise',            'enterprise',  'custom',      NULL, 'Custom limits, volume pricing', TRUE);

-- COHERE, AI21, PERPLEXITY PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('cohere',     'trial',      'Trial',                 'free',        'per_token',   0,    'Rate-limited, non-production', FALSE),
('cohere',     'production', 'Production Pay-as-you-go','pay_as_you_go','per_token',NULL, 'Full speed, $250 outstanding balance threshold', TRUE),
('ai21',       'payg',       'Pay-as-you-go',         'pay_as_you_go','per_token', NULL, 'Standard API token billing', TRUE),
('perplexity', 'payg',       'Pay-as-you-go',         'pay_as_you_go','per_token', NULL, 'Pre-paid credits, tiered rate limits', TRUE),
('perplexity', 'tier0',      'API Tier 0',            'pay_as_you_go','per_token', NULL, '$0 spend — 1 QPS Agent, 50 RPM Sonar', FALSE),
('perplexity', 'tier1',      'API Tier 1',            'pay_as_you_go','per_token', NULL, '$50 spend — 3 QPS Agent, 150 RPM Sonar', FALSE),
('perplexity', 'tier2',      'API Tier 2',            'pay_as_you_go','per_token', NULL, '$250 spend — 8 QPS Agent, 500 RPM Sonar', FALSE),
('perplexity', 'tier3',      'API Tier 3',            'pay_as_you_go','per_token', NULL, '$500 spend — 17 QPS Agent, 1000 RPM Sonar', FALSE),
('perplexity', 'tier4',      'API Tier 4',            'pay_as_you_go','per_token', NULL, '$1000 spend — 33 QPS Agent, 4000 RPM Sonar', FALSE),
('perplexity', 'tier5',      'API Tier 5',            'pay_as_you_go','per_token', NULL, '$5000 spend — 33 QPS Agent, 4000 RPM Sonar', FALSE);

-- AWS BEDROCK TIERS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('aws', 'standard',    'Standard',                    'pay_as_you_go','per_token', NULL, 'Default on-demand per-token', TRUE),
('aws', 'priority',   'Priority',                    'pay_as_you_go','per_token', NULL, '+75% low-latency guarantee', FALSE),
('aws', 'flex',       'Flex',                        'pay_as_you_go','per_token', NULL, '-50% deferred/background', TRUE),
('aws', 'batch',      'Batch',                       'pay_as_you_go','per_token', NULL, '-50% returns within 24h', TRUE),
('aws', 'reserved',   'Reserved',                    'enterprise',   'custom',    NULL, '1mo or 3mo commitment', FALSE);

-- AZURE PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('azure', 'global',       'Global SKU',              'pay_as_you_go','per_token', NULL, 'Baseline pricing, standard on-demand', TRUE),
('azure', 'data-zone',    'Data Zone SKU',           'pay_as_you_go','per_token', NULL, '+10-20% over Global, regional data residency', TRUE),
('azure', 'regional',     'Regional SKU',            'pay_as_you_go','per_token', NULL, '+10-20% over Global', TRUE),
('azure', 'ptu',          'Provisioned Throughput',  'enterprise',   'custom',    NULL, 'PTU-based provisioning', FALSE);

-- HUGGING FACE PLANS
INSERT INTO provider_plans (provider_id, slug, name, tier, billing_model, monthly_price_usd, description, supports_batch_api) VALUES
('huggingface', 'free',       'Free Account',          'free',        'subscription', 0,    '$0.10/mo credits, CPU inference only', FALSE),
('huggingface', 'pro',        'PRO Account',           'pro',         'subscription', 9,    '$2.00/mo credits, priority queues', FALSE),
('huggingface', 'team',       'Team Account',          'team',        'subscription', 20,   '$2.00/seat/mo credits, $20/user/mo', FALSE),
('huggingface', 'enterprise', 'Enterprise Account',    'enterprise',  'subscription', 50,   'From $50/user/mo, custom limits', FALSE);

-- ============================================================
-- OPENAI MODELS
-- ============================================================
INSERT INTO models (provider_id, slug, display_name, model_family, version_label, context_window_tokens, max_output_tokens, max_batch_output_tokens, training_cutoff_date, status, released_date, deprecated_date, sunset_date, description) VALUES
('openai', 'gpt-4o',             'GPT-4o',             'GPT-4',   '2024-05-13',  128000,  16384, NULL,  '2023-10-01', 'active',     '2024-05-13', NULL,         '2026-10-23', 'Flagship multimodal GPT — ChatGPT retired but API active'),
('openai', 'gpt-4o-mini',       'GPT-4o mini',        'GPT-4',   'mini',        128000,  16384, NULL,  '2023-10-01', 'active',     '2024-07-18', NULL,         NULL,        'Small, fast, low-cost omni model'),
('openai', 'gpt-4.1',           'GPT-4.1',            'GPT-4',   '2025-04-01', 1047576,  32768, NULL,  '2024-06-01', 'active',     '2025-04-01', NULL,         NULL,        'Smartest non-reasoning model, 1M context'),
('openai', 'gpt-4.1-mini',      'GPT-4.1 mini',       'GPT-4',   'mini',       1047576,  32768, NULL,  '2024-06-01', 'active',     '2025-04-01', NULL,         NULL,        'Smaller 4.1 variant'),
('openai', 'gpt-4.1-nano',      'GPT-4.1 nano',       'GPT-4',   'nano',       1047576,  32768, NULL,  '2024-06-01', 'active',     '2025-04-01', NULL,         NULL,        'Fastest 4.1 variant'),
('openai', 'o1',                'o1',                 'o1',      '2024-12-17',  200000, 100000, NULL,  '2023-10-01', 'active',     '2024-12-17', NULL,         '2026-10-23', 'Previous full o-series reasoning model'),
('openai', 'o1-pro',            'o1-pro',             'o1',      '2025-03-19',  200000, 100000, NULL,  '2023-10-01', 'active',     '2025-03-19', NULL,         '2026-10-23', 'More compute than o1, Responses API only, no streaming'),
('openai', 'o3',                'o3',                 'o3',      '2025-04-01',  200000, 100000, NULL,  '2024-06-01', 'active',     '2025-04-01', NULL,         NULL,        'Reasoning model for math, science, coding, visual reasoning'),
('openai', 'o3-mini',           'o3-mini',            'o3',      '2025-01-31',  200000, 100000, NULL,  '2023-10-01', 'active',     '2025-01-31', NULL,         '2026-10-23', 'Small reasoning model'),
('openai', 'o4-mini',           'o4-mini',            'o4',      '2025-04-16',  200000, 100000, NULL,  '2024-06-01', 'active',     '2025-04-16', NULL,         '2026-10-23', 'Latest small o-series model'),
('openai', 'gpt-4.5-preview',   'GPT-4.5 Preview',    'GPT-4',   'preview-2025-02-27', 128000, 16384, NULL, '2023-10-01', 'deprecated', '2025-02-27', NULL,         '2026-10-23', 'Deprecated large model'),
('openai', 'gpt-4-turbo',       'GPT-4 Turbo',        'GPT-4',   'turbo-2024-04-09', 128000, 4096, NULL,   '2023-12-01', 'deprecated', '2024-04-09', NULL,         '2026-10-23', 'Older high-intelligence GPT model'),
('openai', 'gpt-3.5-turbo',     'GPT-3.5 Turbo',      'GPT-3',   'turbo-0125',    16385,  4096, NULL,  '2021-09-01', 'deprecated', NULL,         NULL,         '2026-10-23', 'Legacy chat model'),
('openai', 'dall-e-3',          'DALL-E 3',           'DALL-E',  '3',                NULL,   NULL, NULL,  NULL,          'deprecated', '2022-11-01', NULL,         '2026-05-12', 'Image generation — scheduled shutdown'),
('openai', 'whisper-1',         'Whisper',            'Whisper', '1',                NULL,   NULL, NULL,  NULL,          'active',     NULL,         NULL,         NULL,        'Speech recognition, translation, language ID'),
('openai', 'tts-1',             'TTS-1',              'TTS',     '1',                NULL,   NULL, NULL,  NULL,          'active',     NULL,         NULL,         NULL,        'Text-to-speech optimized for speed'),
('openai', 'tts-1-hd',          'TTS-1 HD',           'TTS',     'hd',               NULL,   NULL, NULL,  NULL,          'active',     NULL,         NULL,         NULL,        'Text-to-speech optimized for quality'),
('openai', 'text-embedding-3-large', 'text-embedding-3-large', 'Embeddings', '3', NULL, NULL, NULL, NULL, 'active', NULL, NULL, NULL, 'Most capable embedding model'),
('openai', 'text-embedding-3-small', 'text-embedding-3-small', 'Embeddings', '3', NULL, NULL, NULL, NULL, 'active', NULL, NULL, NULL, 'Smaller, cheaper embedding model');

-- ============================================================
-- ANTHROPIC MODELS
-- ============================================================
INSERT INTO models (provider_id, slug, display_name, model_family, version_label, context_window_tokens, max_output_tokens, max_batch_output_tokens, training_cutoff_date, status, released_date, deprecated_date, sunset_date, description) VALUES
('anthropic', 'claude-opus-4-7',        'Claude Opus 4.7',     'Claude Opus',   '4.7',   1000000, 128000, 300000, '2026-01-01', 'active', '2026-04-01', NULL, NULL, 'New tokenizer, adaptive thinking, 1M context'),
('anthropic', 'claude-sonnet-4-6',      'Claude Sonnet 4.6',   'Claude Sonnet', '4.6',   1000000,  64000, 300000, '2026-01-01', 'active', '2026-03-01', NULL, NULL, 'Balanced intelligence/speed'),
('anthropic', 'claude-haiku-4-5',       'Claude Haiku 4.5',    'Claude Haiku',  '4.5',    200000,  64000,   NULL, '2025-07-01', 'active', '2025-10-01', NULL, NULL, 'Fast, cost-effective'),
('anthropic', 'claude-3-5-sonnet-20241022', 'Claude 3.5 Sonnet', 'Claude 3.5',  NULL,    200000,   8192,   NULL, '2024-04-01', 'active', '2024-10-22', NULL, NULL, 'Previous generation high-intelligence'),
('anthropic', 'claude-3-5-haiku-20241022', 'Claude 3.5 Haiku', 'Claude 3.5',   NULL,    200000,   8192,   NULL, '2024-07-01', 'active', '2024-10-22', NULL, NULL, 'Previous generation efficient'),
('anthropic', 'claude-3-opus-20240229', 'Claude 3 Opus',       'Claude 3',      NULL,    200000,   4096,   NULL, '2023-08-01', 'active', '2024-02-29', NULL, NULL, 'Legacy flagship'),
('anthropic', 'claude-3-sonnet-20240229', 'Claude 3 Sonnet',   'Claude 3',      NULL,    200000,   4096,   NULL, '2023-08-01', 'active', '2024-02-29', NULL, NULL, 'Legacy balanced'),
('anthropic', 'claude-3-haiku-20240307', 'Claude 3 Haiku',     'Claude 3',      NULL,    200000,   4096,   NULL, '2023-08-01', 'active', '2024-03-07', NULL, NULL, 'Legacy fast');

-- ============================================================
-- GOOGLE MODELS
-- ============================================================
INSERT INTO models (provider_id, slug, display_name, model_family, version_label, context_window_tokens, max_output_tokens, max_batch_output_tokens, training_cutoff_date, status, released_date, deprecated_date, sunset_date, description) VALUES
('google', 'gemini-2-5-pro',        'Gemini 2.5 Pro',      'Gemini 2.5',  'pro',   1048576, 65535, NULL, '2025-01-01', 'active', '2025-06-01', NULL, NULL, 'State-of-the-art multipurpose — coding, complex reasoning, deep research'),
('google', 'gemini-2-5-flash',      'Gemini 2.5 Flash',    'Gemini 2.5',  'flash', 1048576,  8192, NULL, '2025-01-01', 'active', '2025-06-01', NULL, NULL, 'Hybrid reasoning with thinking budgets'),
('google', 'gemini-2-5-flash-lite', 'Gemini 2.5 Flash-Lite','Gemini 2.5', 'flash-lite', 1048576, 8192, NULL, '2025-01-01', 'active', '2025-06-01', NULL, NULL, 'Fastest, most budget-friendly 2.5'),
('google', 'gemini-2-0-flash',      'Gemini 2.0 Flash',    'Gemini 2.0',  'flash', 1048576,  8192, NULL, '2024-08-01', 'active', '2025-02-01', NULL, NULL, 'General-purpose multimodal workhorse'),
('google', 'gemini-2-0-flash-lite', 'Gemini 2.0 Flash-Lite','Gemini 2.0', 'flash-lite', 1048576, 8192, NULL, '2024-08-01', 'active', '2025-02-01', NULL, NULL, 'Lowest-latency, most cost-effective'),
('google', 'gemini-1-5-pro',        'Gemini 1.5 Pro',      'Gemini 1.5',  'pro',  2097152,  8192, NULL, '2024-05-01', 'active', '2024-02-01', NULL, NULL, 'Long-context specialist (2M), strong multimodal'),
('google', 'gemini-1-5-flash',      'Gemini 1.5 Flash',    'Gemini 1.5',  'flash',1048576,  8192, NULL, '2024-05-01', 'active', '2024-02-01', NULL, NULL, 'Balanced speed and quality'),
('google', 'gemini-1-5-flash-8b',   'Gemini 1.5 Flash-8B', 'Gemini 1.5',  'flash-8b', 1048576, 8192, NULL, '2024-05-01', 'active', '2024-02-01', NULL, NULL, 'Smallest, most efficient 1.5 variant');

-- ============================================================
-- XAI MODELS
-- ============================================================
INSERT INTO models (provider_id, slug, display_name, model_family, version_label, context_window_tokens, max_output_tokens, max_batch_output_tokens, training_cutoff_date, status, released_date, deprecated_date, sunset_date, description) VALUES
('xai', 'grok-4-3',                    'Grok 4.3',              'Grok 4',     '4.3',          1000000, NULL, NULL, '2024-11-01', 'active',  '2026-03-01', NULL, NULL, 'New flagship — lowest hallucination rate, configurable reasoning effort'),
('xai', 'grok-4-20-0309-reasoning',    'Grok 4.20 (Reasoning)', 'Grok 4',     '4.20-reasoning', 2000000, NULL, NULL, '2024-11-01', 'active', '2026-03-09', NULL, '2026-05-15', 'Reasoning mode with multi-agent variant'),
('xai', 'grok-4-20-0309-non-reasoning','Grok 4.20 (Non-Reasoning)', 'Grok 4', '4.20-non-reasoning', 2000000, NULL, NULL, '2024-11-01', 'active', '2026-03-09', NULL, '2026-05-15', 'Non-reasoning mode'),
('xai', 'grok-4-20-multi-agent-0309',  'Grok 4.20 Multi-Agent', 'Grok 4',     '4.20-multi-agent', 2000000, NULL, NULL, '2024-11-01', 'active', '2026-03-09', NULL, '2026-05-15', '4 internal agents collaborating'),
('xai', 'grok-4-1-fast-reasoning',     'Grok 4.1 Fast (Reasoning)', 'Grok 4', '4.1-fast-reasoning', 2000000, NULL, NULL, '2024-11-01', 'deprecated', '2026-01-01', NULL, '2026-05-15', 'Best cost/context ratio'),
('xai', 'grok-4-1-fast-non-reasoning', 'Grok 4.1 Fast (Non-Reasoning)', 'Grok 4', '4.1-fast-non-reasoning', 2000000, NULL, NULL, '2024-11-01', 'deprecated', '2026-01-01', NULL, '2026-05-15', 'Fast non-reasoning'),
('xai', 'grok-4',                      'Grok 4',                 'Grok 4',     '4',             256000, NULL, NULL, '2024-11-01', 'deprecated', '2025-07-01', NULL, '2026-05-15', 'Retiring'),
('xai', 'grok-4-fast-reasoning',       'Grok 4 Fast (Reasoning)','Grok 4',     '4-fast-reasoning', 2000000, NULL, NULL, '2024-11-01', 'deprecated', '2025-05-01', NULL, '2026-05-15', 'Retiring'),
('xai', 'grok-4-fast-non-reasoning',   'Grok 4 Fast (Non-Reasoning)', 'Grok 4', '4-fast-non-reasoning', 2000000, NULL, NULL, '2024-11-01', 'deprecated', '2025-05-01', NULL, '2026-05-15', 'Retiring'),
('xai', 'grok-code-fast-1',           'Grok Code Fast',          'Grok',      'code-fast-1',    256000, NULL, NULL, '2024-11-01', 'deprecated', '2025-08-01', NULL, '2026-05-15', 'Coding-focused, retiring'),
('xai', 'grok-3',                     'Grok 3',                  'Grok 3',     '3',             131000, NULL, NULL, '2024-06-01', 'deprecated', '2025-01-01', NULL, '2026-05-15', 'Retiring'),
('xai', 'grok-3-mini',                'Grok 3 Mini',             'Grok 3',     'mini',           131000, NULL, NULL, '2024-06-01', 'deprecated', '2025-01-01', NULL, '2026-05-15', 'Retiring');

-- ============================================================
-- DEEPSEEK MODELS
-- ============================================================
INSERT INTO models (provider_id, slug, display_name, model_family, version_label, context_window_tokens, max_output_tokens, max_batch_output_tokens, training_cutoff_date, status, released_date, deprecated_date, sunset_date, description) VALUES
('deepseek', 'deepseek-v4-flash',       'DeepSeek V4 Flash',     'DeepSeek V4', 'flash',   1000000, 384000, NULL, '2024-01-01', 'active',  '2026-03-01', NULL,         NULL,        'Fast workhorse. Thinking/non-thinking modes. Currently serving Hermes.'),
('deepseek', 'deepseek-v4-pro',         'DeepSeek V4 Pro',       'DeepSeek V4', 'pro',     1000000, 384000, NULL, '2024-01-01', 'active',  '2026-03-01', NULL,         NULL,        'Premium V4. 75% off promo through 2026-05-31'),
('deepseek', 'deepseek-chat',           'DeepSeek Chat (Legacy)','DeepSeek V3', 'chat',      64000,   8000, NULL, '2023-10-01', 'deprecated', '2024-12-01', NULL, '2026-07-24', 'Legacy — maps to V4 Flash non-thinking'),
('deepseek', 'deepseek-reasoner',       'DeepSeek Reasoner (R1)','DeepSeek R1', 'reasoner',  64000,   8000, NULL, '2023-10-01', 'deprecated', '2025-01-01', NULL, '2026-07-24', 'Legacy — maps to V4 Flash thinking');

-- ============================================================
-- CHINESE PROVIDER MODELS
-- ============================================================
INSERT INTO models (provider_id, slug, display_name, model_family, version_label, context_window_tokens, max_output_tokens, max_batch_output_tokens, training_cutoff_date, status, released_date, deprecated_date, sunset_date, description) VALUES
-- Alibaba / Qwen
('alibaba', 'qwen3-6-plus',       'Qwen3.6-Plus',     'Qwen 3.6',  'plus',  1000000,  32000, NULL, NULL, 'active', '2026-02-01', NULL, NULL, 'Latest Qwen flagship'),
('alibaba', 'qwen3-max',          'Qwen3-Max',         'Qwen 3',    'max',    262000,   8000, NULL, NULL, 'active', '2025-09-01', NULL, NULL, 'High-intelligence Qwen'),
('alibaba', 'qwen3-5-plus',       'Qwen3.5-Plus',      'Qwen 3.5',  'plus',   256000,   8000, NULL, NULL, 'active', '2026-02-01', NULL, NULL, 'Cost-effective Qwen'),
('alibaba', 'qwen3-coder-plus',   'Qwen3-Coder-Plus',  'Qwen 3',    'coder-plus', 1000000, 8000, NULL, NULL, 'active', '2025-09-01', NULL, NULL, 'Coding specialist'),
('alibaba', 'qwen3-coder-flash',  'Qwen3-Coder-Flash', 'Qwen 3',    'coder-flash', 256000, 8000, NULL, NULL, 'active', '2025-09-01', NULL, NULL, 'Fast coding model'),
('alibaba', 'qwen3-32b',          'Qwen3 (32B)',       'Qwen 3',    '32b',    131000,  16000, NULL, NULL, 'active', '2025-09-01', NULL, NULL, 'Smaller open-weight variant'),
('alibaba', 'qwen2-5-72b',        'Qwen2.5-72B-Instruct','Qwen 2.5','72b',    131000,   8000, NULL, NULL, 'active', '2024-09-01', NULL, NULL, 'Previous generation flagship'),
('alibaba', 'qwen2-5-32b',        'Qwen2.5-32B-Instruct','Qwen 2.5','32b',    131000,   8000, NULL, NULL, 'active', '2024-09-01', NULL, NULL, 'Mid-size Qwen 2.5'),
('alibaba', 'qwen2-5-coder-32b',  'Qwen2.5-Coder-32B', 'Qwen 2.5',  'coder-32b', 32000, 8000, NULL, NULL, 'active', '2024-11-01', NULL, NULL, 'Previous coding model'),
('alibaba', 'qwen2-5-math-72b',   'Qwen2.5-Math-72B',  'Qwen 2.5',  'math-72b', 32000,  8000, NULL, NULL, 'active', '2024-11-01', NULL, NULL, 'Math specialist'),
('alibaba', 'qwq-32b',            'QwQ-32B-Preview',   'QwQ',       '32b-preview', 32000, 8000, NULL, NULL, 'active', '2024-11-01', NULL, NULL, 'Reasoning preview'),

-- Zhipu / GLM
('zhipu', 'glm-5-1',              'GLM-5.1',           'GLM 5',     '5.1',    200000, 128000, NULL, NULL, 'active', '2026-04-01', NULL, NULL, 'Latest GLM flagship'),
('zhipu', 'glm-5',                'GLM-5',             'GLM 5',     '5',      200000, 128000, NULL, NULL, 'active', '2026-02-01', NULL, NULL, 'Strong benchmark performer'),
('zhipu', 'glm-5-turbo',          'GLM-5-Turbo',       'GLM 5',     'turbo',  200000, 128000, NULL, NULL, 'active', '2026-03-01', NULL, NULL, 'Turbo variant of GLM-5'),
('zhipu', 'glm-4-7',              'GLM-4.7',           'GLM 4',     '4.7',    200000, 131000, NULL, NULL, 'active', '2026-01-01', NULL, NULL, 'Strong value model'),
('zhipu', 'glm-4-7-flashx',      'GLM-4.7-FlashX',    'GLM 4',     '4.7-flashx', 200000, 131000, NULL, NULL, 'active', '2026-01-01', NULL, NULL, 'Fast low-cost'),
('zhipu', 'glm-4-7-flash',       'GLM-4.7-Flash',      'GLM 4',     '4.7-flash',  200000, 131000, NULL, NULL, 'active', '2026-01-01', NULL, NULL, 'Free inference'),
('zhipu', 'glm-4-5',              'GLM-4.5',           'GLM 4',     '4.5',    200000, 131000, NULL, NULL, 'active', '2025-07-01', NULL, NULL, 'Previous generation'),
('zhipu', 'glm-4-5-flash',       'GLM-4.5-Flash',      'GLM 4',     '4.5-flash',  200000, 131000, NULL, NULL, 'active', '2025-07-01', NULL, NULL, 'Free inference flash'),

-- MiniMax
('minimax', 'minimax-m2-7',       'MiniMax-M2.7',      'MiniMax M', '2.7',    200000,  64000, NULL, NULL, 'active', '2026-04-01', NULL, NULL, 'Latest MiniMax, strongest'),
('minimax', 'minimax-m2-5',       'MiniMax-M2.5',      'MiniMax M', '2.5',    197000,  64000, NULL, NULL, 'active', '2025-10-01', NULL, NULL, 'Strong value'),
('minimax', 'minimax-m2-1',       'MiniMax-M2.1',      'MiniMax M', '2.1',    200000,  64000, NULL, NULL, 'active', '2025-06-01', NULL, NULL, 'Budget-friendly'),
('minimax', 'minimax-m2',         'MiniMax-M2',        'MiniMax M', '2',      197000,  64000, NULL, NULL, 'active', '2025-03-01', NULL, NULL, 'First M2 generation'),
('minimax', 'minimax-m1',         'MiniMax-M1',        'MiniMax M', '1',     1000000,   8000, NULL, NULL, 'active', '2025-05-01', NULL, NULL, 'Long-context M1'),

-- Kimi / Moonshot
('kimi', 'kimi-k2-6',             'Kimi K2.6',         'Kimi K2',  '2.6',    262000,  32000, NULL, NULL, 'active', '2026-04-01', NULL, NULL, 'Latest Kimi flagship'),
('kimi', 'kimi-k2-0905',          'Kimi K2 (0905)',    'Kimi K2',  '2-0905', 262000,  16000, NULL, NULL, 'active', '2025-09-01', NULL, NULL, 'Main K2 model'),
('kimi', 'kimi-k2-turbo',         'Kimi K2-Turbo',     'Kimi K2',  '2-turbo', 262000, 16000, NULL, NULL, 'active', '2025-09-01', NULL, NULL, 'Higher quality, higher cost'),
('kimi', 'kimi-k2-thinking',      'Kimi K2-Thinking',   'Kimi K2',  '2-thinking', 262000, 16000, NULL, NULL, 'active', '2026-04-01', NULL, NULL, 'Reasoning variant'),
('kimi', 'moonshot-v1-128k',      'Moonshot V1 128K',  'Moonshot V1', '128k', 128000, 8000, NULL, NULL, 'active', '2024-05-01', NULL, NULL, 'Legacy long-context'),
('kimi', 'moonshot-v1-32k',       'Moonshot V1 32K',   'Moonshot V1', '32k',   32000, 4000, NULL, NULL, 'active', '2024-05-01', NULL, NULL, 'Legacy medium'),
('kimi', 'moonshot-v1-8k',        'Moonshot V1 8K',    'Moonshot V1', '8k',     8000, 4000, NULL, NULL, 'active', '2024-05-01', NULL, NULL, 'Legacy short-context'),

-- ByteDance / Seed
('bytedance', 'seed-2-0-pro',     'Seed 2.0 Pro',      'Seed 2.0', 'pro',    256000, 128000, NULL, NULL, 'active', '2026-02-01', NULL, NULL, 'Flagship — Codeforces 3020'),
('bytedance', 'seed-2-0-lite',    'Seed 2.0 Lite',     'Seed 2.0', 'lite',   256000, 128000, NULL, NULL, 'active', '2026-02-01', NULL, NULL, 'Production balance'),
('bytedance', 'seed-2-0-mini',    'Seed 2.0 Mini',     'Seed 2.0', 'mini',   256000, 128000, NULL, NULL, 'active', '2026-02-01', NULL, NULL, 'High concurrency, low cost'),
('bytedance', 'seed-2-0-code',    'Seed 2.0 Code',     'Seed 2.0', 'code',   256000,  16000, NULL, NULL, 'active', '2025-10-01', NULL, NULL, 'Coding-focused'),
('bytedance', 'doubao-pro-256k',  'Doubao Pro 256K',   'Doubao',   'pro-256k', 256000, 8000, NULL, NULL, 'active', '2024-05-01', NULL, NULL, 'Long-context Doubao'),
('bytedance', 'doubao-pro-128k',  'Doubao Pro 128K',   'Doubao',   'pro-128k', 128000, 8000, NULL, NULL, 'active', '2024-05-01', NULL, NULL, 'Standard Doubao'),
('bytedance', 'doubao-lite-128k', 'Doubao Lite 128K',  'Doubao',   'lite-128k',128000, 8000, NULL, NULL, 'active', '2024-05-01', NULL, NULL, 'Cost-optimized Doubao');

-- ============================================================
-- MISTRAL MODELS
-- ============================================================
INSERT INTO models (provider_id, slug, display_name, model_family, version_label, context_window_tokens, max_output_tokens, max_batch_output_tokens, training_cutoff_date, status, released_date, deprecated_date, sunset_date, description) VALUES
('mistral', 'mistral-large-3',       'Mistral Large 3',     'Mistral Large', 'v25.12',  262000, 262000, NULL, NULL, 'active',  '2025-12-01', NULL, NULL, '41B active / 675B total MoE, Apache 2.0'),
('mistral', 'mistral-medium-3-1',    'Mistral Medium 3.1',  'Mistral Medium','v25.08',  131000,   NULL, NULL, NULL, 'active',  '2025-08-01', NULL, NULL, 'Frontier multimodal, agentic & coding'),
('mistral', 'mistral-small-4',       'Mistral Small 4',     'Mistral Small', 'v26.03',  262000,   NULL, NULL, NULL, 'active',  '2026-03-01', NULL, NULL, 'Hybrid instruct/reasoning/coding, open-weight'),
('mistral', 'mistral-small-3-2',     'Mistral Small 3.2',   'Mistral Small', 'v25.06',  128000,   NULL, NULL, NULL, 'active',  '2025-06-01', NULL, '2026-07-31', 'Deprecating Jul 31, 2026'),
('mistral', 'ministral-3-14b',       'Ministral 3 14B',     'Ministral 3',   'v25.12',  262000,   NULL, NULL, NULL, 'active',  '2025-12-01', NULL, NULL, 'Text + vision, strong efficiency'),
('mistral', 'ministral-3-8b',        'Ministral 3 8B',      'Ministral 3',   'v25.12',  262000,   NULL, NULL, NULL, 'active',  '2025-12-01', NULL, NULL, 'Text + vision'),
('mistral', 'ministral-3-3b',        'Ministral 3 3B',      'Ministral 3',   'v25.12',  131000,   NULL, NULL, NULL, 'active',  '2025-12-01', NULL, NULL, 'Tiny edge model'),
('mistral', 'codestral',             'Codestral',           'Codestral',     'v25.08',  256000,   NULL, NULL, NULL, 'active',  '2025-08-01', NULL, NULL, 'Code completion, Premier access'),
('mistral', 'devstral-2',            'Devstral 2',          'Devstral',      'v25.12',  262000,   NULL, NULL, NULL, 'active',  '2025-12-01', NULL, NULL, 'Code agents, 44.8% LiveCodeBench'),
('mistral', 'mistral-nemo-12b',      'Mistral Nemo 12B',    'Mistral Nemo',  'v24.07',  131000,   NULL, NULL, NULL, 'active',  '2024-07-01', NULL, NULL, 'Best multilingual open-source, 12B dense'),
('mistral', 'pixtral-12b',           'Pixtral 12B',         'Pixtral',       'v24.09',  128000,   NULL, NULL, NULL, 'active',  '2024-09-01', NULL, NULL, 'Vision model'),
('mistral', 'mistral-embed',         'Mistral Embed',       'Mistral Embed', 'v23.12',   NULL,    NULL, NULL, NULL, 'active',  '2023-12-01', NULL, NULL, 'Embeddings (input only)'),
('mistral', 'mistral-moderation-2',  'Mistral Moderation 2','Mistral Moderation','v26.03', 128000, NULL, NULL, NULL, 'active', '2026-03-01', NULL, NULL, 'Safety moderation');

-- ============================================================
-- OTHER PROVIDER MODELS (Cohere, AI21, Perplexity, Reka, Yi, Baichuan)
-- ============================================================
INSERT INTO models (provider_id, slug, display_name, model_family, version_label, context_window_tokens, max_output_tokens, max_batch_output_tokens, training_cutoff_date, status, released_date, deprecated_date, sunset_date, description) VALUES
-- Cohere
('cohere', 'command-r-plus-04',      'Command R+ (04-2024)', 'Command R+',  '04-2024', 128000, 4000, NULL, NULL, 'active',  '2024-04-01', NULL, NULL, 'Legacy; still listed'),
('cohere', 'command-r-plus-08',      'Command R+ (08-2024)', 'Command R+',  '08-2024', 128000, 4000, NULL, NULL, 'active',  '2024-08-01', NULL, NULL, 'Updated, ~25% lower latency'),
('cohere', 'command-r',              'Command R',            'Command R',   '03-2024', 128000, 4000, NULL, NULL, 'active',  '2024-03-01', NULL, NULL, 'Legacy'),
('cohere', 'command-a',              'Command A',            'Command A',   NULL,      256000, 8000, NULL, NULL, 'active',  '2025-01-01', NULL, NULL, 'Requires 2x GPU; enterprise pricing'),
('cohere', 'embed-4',                'Embed 4',              'Embed',       '4',        NULL,  NULL, NULL, NULL, 'active',  '2025-01-01', NULL, NULL, 'Text + Image embeddings'),
('cohere', 'embed-multilingual-v3',  'Embed Multilingual v3','Embed',       'multilingual-v3', 512, NULL, NULL, NULL, 'active', '2024-01-01', NULL, NULL, 'Multilingual text embedding'),

-- AI21
('ai21', 'jamba-1-5-mini',          'Jamba 1.5 Mini',       'Jamba 1.5',   'mini',    256000, NULL, NULL, NULL, 'active', '2025-03-01', NULL, NULL, 'SSM + Transformer hybrid, 52B total'),
('ai21', 'jamba-1-5-large',         'Jamba 1.5 Large',      'Jamba 1.5',   'large',   256000, NULL, NULL, NULL, 'active', '2025-03-01', NULL, NULL, 'SSM + Transformer hybrid'),
('ai21', 'j2-mid',                  'Jurassic-2 Mid',       'Jurassic 2',  'mid',       8000, NULL, NULL, NULL, 'active', '2023-01-01', NULL, NULL, 'Dense Transformer'),
('ai21', 'j2-ultra',                'Jurassic-2 Ultra',     'Jurassic 2',  'ultra',     8000, NULL, NULL, NULL, 'active', '2023-01-01', NULL, NULL, 'Dense Transformer'),

-- Perplexity
('perplexity', 'sonar',               'Sonar',               'Sonar',       NULL,       NULL, NULL, NULL, NULL, 'active', '2025-06-01', NULL, NULL, 'Standard Sonar API'),
('perplexity', 'sonar-pro',           'Sonar Pro',           'Sonar',       'pro',      NULL, NULL, NULL, NULL, 'active', '2025-06-01', NULL, NULL, 'Higher quality Sonar'),
('perplexity', 'sonar-reasoning-pro', 'Sonar Reasoning Pro', 'Sonar',       'reasoning-pro', NULL, NULL, NULL, NULL, 'active', '2025-12-01', NULL, NULL, 'With reasoning'),
('perplexity', 'sonar-deep-research', 'Sonar Deep Research', 'Sonar',       'deep-research', NULL, NULL, NULL, NULL, 'active', '2026-01-01', NULL, NULL, 'Deep research with search'),

-- Reka
('reka', 'reka-core',                'Reka Core',           'Reka',        'core',    256000, NULL, NULL, NULL, 'active', '2025-06-01', NULL, NULL, 'Complex multimodal tasks'),
('reka', 'reka-flash',               'Reka Flash',          'Reka',        'flash',   128000, NULL, NULL, NULL, 'active', '2025-06-01', NULL, NULL, 'Fast, efficient'),
('reka', 'reka-spark',               'Reka Spark',          'Reka',        'spark',    64000, NULL, NULL, NULL, 'active', '2025-06-01', NULL, NULL, 'Compact / on-device'),

-- Yi
('yi', 'yi-lightning',               'Yi-Lightning',        'Yi',          'lightning', 256000, NULL, NULL, NULL, 'active', '2025-06-01', NULL, NULL, 'Price-disruptor ~$0.14/M'),
('yi', 'yi-large',                   'Yi-Large',            'Yi',          'large',     32000, NULL, NULL, NULL, 'active', '2024-06-01', NULL, NULL, 'Available via partners'),

-- Baichuan
('baichuan', 'baichuan4',            'Baichuan4',           'Baichuan 4',  NULL,       32000, NULL, NULL, NULL, 'active', '2025-01-01', NULL, NULL, 'Flagship'),
('baichuan', 'baichuan4-turbo',      'Baichuan4-Turbo',     'Baichuan 4',  'turbo',    32000, NULL, NULL, NULL, 'active', '2025-01-01', NULL, NULL, 'Turbo variant'),
('baichuan', 'baichuan4-air',        'Baichuan4-Air',       'Baichuan 4',  'air',      32000, NULL, NULL, NULL, 'active', '2025-01-01', NULL, NULL, 'Lowest-cost flagship-line');

-- OPENAI capabilities
INSERT INTO model_capabilities (model_id, capability, supported, max_images_per_request, notes)
SELECT m.id, 'text', TRUE, NULL, 'Text input/output'
FROM models m WHERE m.provider_id = 'openai' AND m.slug IN ('gpt-4o', 'gpt-4o-mini', 'gpt-4.1', 'o3');

INSERT INTO model_capabilities (model_id, capability, supported, max_images_per_request, notes)
SELECT m.id, 'vision', TRUE, NULL, 'Vision/image input'
FROM models m WHERE m.provider_id = 'openai' AND m.slug IN ('gpt-4o', 'gpt-4o-mini', 'gpt-4.1', 'gpt-4.1-mini', 'gpt-4.1-nano', 'o1', 'o3', 'o4-mini');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'tool_use', TRUE, 'Function calling, tool use'
FROM models m WHERE m.provider_id = 'openai' AND m.slug IN ('gpt-4o', 'gpt-4o-mini', 'gpt-4.1', 'gpt-4.1-mini', 'gpt-4.1-nano', 'o1', 'o3', 'o3-mini', 'o4-mini');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'streaming', TRUE, 'SSE streaming'
FROM models m WHERE m.provider_id = 'openai' AND m.slug IN ('gpt-4o', 'gpt-4o-mini', 'gpt-4.1', 'o3', 'o3-mini', 'o4-mini');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'structured_output', TRUE, 'JSON mode, structured outputs'
FROM models m WHERE m.provider_id = 'openai' AND m.slug IN ('gpt-4o', 'gpt-4o-mini', 'gpt-4.1', 'gpt-4.1-mini', 'gpt-4.1-nano', 'o1', 'o3', 'o3-mini', 'o4-mini');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'reasoning', TRUE, 'o-series reasoning models'
FROM models m WHERE m.provider_id = 'openai' AND m.slug IN ('o1', 'o3', 'o3-mini', 'o4-mini');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'image_generation', TRUE, 'Native DALL-E generation'
FROM models m WHERE m.provider_id = 'openai' AND m.slug = 'dall-e-3';

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'audio', TRUE, 'Speech-to-text'
FROM models m WHERE m.provider_id = 'openai' AND m.slug = 'whisper-1';

-- ANTHROPIC capabilities
INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'text', TRUE, 'Text input/output'
FROM models m WHERE m.provider_id = 'anthropic';

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'vision', TRUE, 'Images and PDFs as input, counted as input tokens'
FROM models m WHERE m.provider_id = 'anthropic';

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'tool_use', TRUE, 'Parallel tool execution, function calling'
FROM models m WHERE m.provider_id = 'anthropic';

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'streaming', TRUE, 'SSE streaming'
FROM models m WHERE m.provider_id = 'anthropic';

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'extended_thinking', TRUE, 'Extended thinking (Sonnet 4.6, Haiku 4.5)'
FROM models m WHERE m.provider_id = 'anthropic' AND m.slug IN ('claude-sonnet-4-6', 'claude-haiku-4-5');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'extended_thinking', FALSE, 'Adaptive thinking replaces manual extended thinking on Opus 4.7'
FROM models m WHERE m.provider_id = 'anthropic' AND m.slug = 'claude-opus-4-7';

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'computer_use', TRUE, 'Computer use (agentic UI interaction)'
FROM models m WHERE m.provider_id = 'anthropic' AND m.slug IN ('claude-opus-4-7', 'claude-sonnet-4-6', 'claude-haiku-4-5', 'claude-3-5-sonnet-20241022');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'code_execution', TRUE, '50 free hours/day/org, then $0.05/hr/container'
FROM models m WHERE m.provider_id = 'anthropic' AND m.model_family LIKE 'Claude %';

-- GOOGLE capabilities
INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'text', TRUE, 'Text input/output'
FROM models m WHERE m.provider_id = 'google';

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'vision', TRUE, 'Image input'
FROM models m WHERE m.provider_id = 'google';

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'video', TRUE, 'Video input (258 tokens/second)'
FROM models m WHERE m.provider_id = 'google' AND m.slug NOT IN ('gemini-2-0-flash-lite');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'audio', TRUE, 'Audio input'
FROM models m WHERE m.provider_id = 'google' AND m.slug NOT IN ('gemini-2-0-flash-lite');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'code_execution', TRUE, 'Code execution supported'
FROM models m WHERE m.provider_id = 'google';

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'grounding', TRUE, 'Google Search grounding'
FROM models m WHERE m.provider_id = 'google' AND m.slug IN ('gemini-2-5-pro', 'gemini-2-5-flash', 'gemini-2-0-flash', 'gemini-1-5-pro', 'gemini-1-5-flash', 'gemini-1-5-flash-8b');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'streaming', TRUE, 'Streaming supported'
FROM models m WHERE m.provider_id = 'google';

-- DEEPSEEK capabilities
INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'text', TRUE, 'Text input/output'
FROM models m WHERE m.provider_id = 'deepseek';

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'reasoning', TRUE, 'Thinking mode (default for V4 Flash/Pro)'
FROM models m WHERE m.provider_id = 'deepseek' AND m.slug IN ('deepseek-v4-flash', 'deepseek-v4-pro', 'deepseek-reasoner');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'streaming', TRUE, 'SSE with keep-alive'
FROM models m WHERE m.provider_id = 'deepseek' AND m.slug IN ('deepseek-v4-flash', 'deepseek-v4-pro');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'tool_use', TRUE, 'Function calling, tool use'
FROM models m WHERE m.provider_id = 'deepseek' AND m.slug IN ('deepseek-v4-flash', 'deepseek-v4-pro');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'json_mode', TRUE, 'JSON output in both thinking and non-thinking modes'
FROM models m WHERE m.provider_id = 'deepseek' AND m.slug IN ('deepseek-v4-flash', 'deepseek-v4-pro');

INSERT INTO model_capabilities (model_id, capability, supported, notes)
SELECT m.id, 'vision', FALSE, 'Text-only models currently'
FROM models m WHERE m.provider_id = 'deepseek';

-- OPENAI pricing (standard endpoint, us region)
INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 2.50, 10.00, 1.25, 1.25, 5.00, '2026-05-01'
FROM models m WHERE m.provider_id = 'openai' AND m.slug = 'gpt-4o';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 0.15, 0.60, 0.075, 0.075, 0.30, '2026-05-01'
FROM models m WHERE m.provider_id = 'openai' AND m.slug = 'gpt-4o-mini';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 2.00, 8.00, 0.50, 1.00, 4.00, '2026-05-01'
FROM models m WHERE m.provider_id = 'openai' AND m.slug = 'gpt-4.1';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 0.40, 1.60, 0.10, 0.20, 0.80, '2026-05-01'
FROM models m WHERE m.provider_id = 'openai' AND m.slug = 'gpt-4.1-mini';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 0.10, 0.40, 0.025, 0.05, 0.20, '2026-05-01'
FROM models m WHERE m.provider_id = 'openai' AND m.slug = 'gpt-4.1-nano';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 2.00, 8.00, 0.50, 1.00, 4.00, '2026-05-01'
FROM models m WHERE m.provider_id = 'openai' AND m.slug = 'o3';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 1.10, 4.40, 0.55, 0.55, 2.20, '2026-05-01'
FROM models m WHERE m.provider_id = 'openai' AND m.slug = 'o3-mini';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 1.10, 4.40, 0.275, 0.55, 2.20, '2026-05-01'
FROM models m WHERE m.provider_id = 'openai' AND m.slug = 'o4-mini';

-- ANTHROPIC pricing
INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 5.00, 25.00, 0.50, 2.50, 12.50, '2026-05-01'
FROM models m WHERE m.provider_id = 'anthropic' AND m.slug = 'claude-opus-4-7';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 3.00, 15.00, 0.30, 1.50, 7.50, '2026-05-01'
FROM models m WHERE m.provider_id = 'anthropic' AND m.slug = 'claude-sonnet-4-6';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 1.00, 5.00, 0.10, 0.50, 2.50, '2026-05-01'
FROM models m WHERE m.provider_id = 'anthropic' AND m.slug = 'claude-haiku-4-5';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, price_per_1m_input_tokens_batch, price_per_1m_output_tokens_batch, effective_date)
SELECT m.id, 'standard', 'us', 5.00, 25.00, 0.50, 2.50, 12.50, '2026-05-01'
FROM models m WHERE m.provider_id = 'anthropic' AND m.slug IN ('claude-opus-4-7', 'claude-opus-4-7');

-- Opus 4.6 same pricing

-- GOOGLE pricing (standard, us)
INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 1.25, 10.00, '2026-05-01'
FROM models m WHERE m.provider_id = 'google' AND m.slug = 'gemini-2-5-pro';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 0.30, 2.50, '2026-05-01'
FROM models m WHERE m.provider_id = 'google' AND m.slug = 'gemini-2-5-flash';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 0.10, 0.40, '2026-05-01'
FROM models m WHERE m.provider_id = 'google' AND m.slug = 'gemini-2-5-flash-lite';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 0.10, 0.40, '2026-05-01'
FROM models m WHERE m.provider_id = 'google' AND m.slug = 'gemini-2-0-flash';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 0.075, 0.30, '2026-05-01'
FROM models m WHERE m.provider_id = 'google' AND m.slug = 'gemini-2-0-flash-lite';

-- xAI pricing
INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 1.25, 2.50, '2026-05-01'
FROM models m WHERE m.provider_id = 'xai' AND m.slug = 'grok-4-3';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 1.25, 2.50, '2026-05-01'
FROM models m WHERE m.provider_id = 'xai' AND m.slug LIKE 'grok-4-20%';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 0.20, 0.50, '2026-05-01'
FROM models m WHERE m.provider_id = 'xai' AND m.slug IN ('grok-4-1-fast-reasoning', 'grok-4-1-fast-non-reasoning', 'grok-4-fast-reasoning', 'grok-4-fast-non-reasoning');

-- DeepSeek pricing
INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, effective_date)
SELECT m.id, 'standard', 'us', 0.14, 0.28, 0.0028, '2026-05-01'
FROM models m WHERE m.provider_id = 'deepseek' AND m.slug = 'deepseek-v4-flash';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, effective_date, metadata)
SELECT m.id, 'standard', 'us', 0.435, 0.87, 0.003625, '2026-05-01', '{"promo": true, "promo_until": "2026-05-31", "regular_input": 1.74, "regular_output": 3.48}'
FROM models m WHERE m.provider_id = 'deepseek' AND m.slug = 'deepseek-v4-pro';

-- Alibaba / Qwen pricing
INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'cn', 0.78, 3.90, '2026-05-01'
FROM models m WHERE m.provider_id = 'alibaba' AND m.slug = 'qwen3-max';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'cn', 0.40, 1.20, '2026-05-01'
FROM models m WHERE m.provider_id = 'alibaba' AND m.slug = 'qwen3-5-plus';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'cn', 0.65, 3.25, '2026-05-01'
FROM models m WHERE m.provider_id = 'alibaba' AND m.slug = 'qwen3-coder-plus';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'cn', 0.15, 0.75, '2026-05-01'
FROM models m WHERE m.provider_id = 'alibaba' AND m.slug = 'qwen3-coder-flash';

-- Zhipu pricing
INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, effective_date)
SELECT m.id, 'standard', 'cn', 1.40, 4.40, 0.26, '2026-05-01'
FROM models m WHERE m.provider_id = 'zhipu' AND m.slug = 'glm-5-1';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, effective_date)
SELECT m.id, 'standard', 'cn', 1.00, 3.20, 0.20, '2026-05-01'
FROM models m WHERE m.provider_id = 'zhipu' AND m.slug = 'glm-5';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, price_per_1m_cached_input_tokens, effective_date)
SELECT m.id, 'standard', 'cn', 0.07, 0.40, 0.01, '2026-05-01'
FROM models m WHERE m.provider_id = 'zhipu' AND m.slug = 'glm-4-7-flashx';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'cn', 0.00, 0.00, '2026-05-01'
FROM models m WHERE m.provider_id = 'zhipu' AND m.slug IN ('glm-4-7-flash', 'glm-4-5-flash');

-- Mistral pricing
INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'eu', 0.50, 1.50, '2026-05-01'
FROM models m WHERE m.provider_id = 'mistral' AND m.slug = 'mistral-large-3';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'eu', 0.15, 0.60, '2026-05-01'
FROM models m WHERE m.provider_id = 'mistral' AND m.slug = 'mistral-small-4';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'eu', 0.02, 0.03, '2026-05-01'
FROM models m WHERE m.provider_id = 'mistral' AND m.slug = 'mistral-nemo-12b';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'eu', 0.30, 0.90, '2026-05-01'
FROM models m WHERE m.provider_id = 'mistral' AND m.slug = 'codestral';

-- Cohere pricing
INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 2.50, 10.00, '2026-05-01'
FROM models m WHERE m.provider_id = 'cohere' AND m.slug = 'command-r-plus-08';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 0.50, 1.50, '2026-05-01'
FROM models m WHERE m.provider_id = 'cohere' AND m.slug = 'command-r';

-- AI21 pricing
INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 0.20, 0.40, '2026-05-01'
FROM models m WHERE m.provider_id = 'ai21' AND m.slug = 'jamba-1-5-mini';

INSERT INTO model_pricing (model_id, endpoint_type, region, price_per_1m_input_tokens, price_per_1m_output_tokens, effective_date)
SELECT m.id, 'standard', 'us', 2.00, 8.00, '2026-05-01'
FROM models m WHERE m.provider_id = 'ai21' AND m.slug = 'jamba-1-5-large';

INSERT INTO endpoints (provider_id, slug, name, base_url, version, protocol, auth_method, health_endpoint, docs_url, status, region) VALUES
('openai',     'api',            'OpenAI API',                'https://api.openai.com',              'v1',  'https', 'bearer_token', 'https://api.openai.com/v1/models', 'https://platform.openai.com/docs', 'active', 'us'),
('openai',     'api-us',         'OpenAI US Regional',        'https://us.api.openai.com',           'v1',  'https', 'bearer_token', NULL, NULL, 'active', 'us'),
('openai',     'api-eu',         'OpenAI EU Regional',        'https://eu.api.openai.com',           'v1',  'https', 'bearer_token', NULL, NULL, 'active', 'eu'),
('anthropic',  'api',            'Anthropic Messages API',    'https://api.anthropic.com',           'v1',  'https', 'api_key_header', NULL, 'https://docs.anthropic.com', 'active', 'us'),
('google',     'gemini-api',     'Gemini Developer API',      'https://generativelanguage.googleapis.com', 'v1', 'https', 'api_key', NULL, 'https://ai.google.dev', 'active', 'us'),
('google',     'vertex-ai',      'Vertex AI',                 'https://aiplatform.googleapis.com',   'v1',  'https', 'oauth', NULL, 'https://cloud.google.com/vertex-ai', 'active', 'multi'),
('xai',        'api',            'xAI API',                   'https://api.x.ai',                    'v1',  'https', 'bearer_token', NULL, 'https://console.x.ai', 'active', 'us'),
('deepseek',   'api',            'DeepSeek API (OpenAI)',     'https://api.deepseek.com',            'v1',  'https', 'api_key_header', NULL, 'https://platform.deepseek.com', 'active', 'cn'),
('deepseek',   'api-anthropic',  'DeepSeek API (Anthropic)',  'https://api.deepseek.com/anthropic',  'v1',  'https', 'api_key_header', NULL, NULL, 'active', 'cn'),
('alibaba',    'bailian-beijing', 'Bailian Beijing',          'https://pailangstudio.cn-beijing.aliyuncs.com', 'v1', 'https', 'api_key', NULL, NULL, 'active', 'cn'),
('alibaba',    'bailian-singapore', 'Bailian Singapore',      'https://pailangstudio.ap-southeast-1.aliyuncs.com', 'v1', 'https', 'api_key', NULL, NULL, 'active', 'multi'),
('alibaba',    'bailian-us',     'Bailian US (Virginia)',     'https://pailangstudio.us-east-1.aliyuncs.com', 'v1', 'https', 'api_key', NULL, NULL, 'active', 'us'),
('zhipu',      'bigmodel',       'BigModel Open Platform',    'https://open.bigmodel.cn',            'v4',  'https', 'api_key', NULL, 'https://bigmodel.cn', 'active', 'cn'),
('zhipu',      'z-ai',           'Z.ai International',        'https://api.z.ai',                    'v1',  'https', 'api_key', NULL, NULL, 'active', 'multi'),
('minimax',    'api-intl',       'MiniMax International',     'https://api.minimax.io',              'v1',  'https', 'api_key', NULL, NULL, 'active', 'multi'),
('minimax',    'api-cn',         'MiniMax China',             'https://api.minimaxi.com',            'v1',  'https', 'api_key', NULL, NULL, 'active', 'cn'),
('kimi',       'api-cn',         'Kimi API (CN)',             'https://api.moonshot.cn',             'v1',  'https', 'api_key', NULL, NULL, 'active', 'cn'),
('kimi',       'api-intl',       'Kimi API (International)',  'https://api.kimi.ai',                 'v1',  'https', 'api_key', NULL, NULL, 'active', 'multi'),
('bytedance',  'volc-beijing',   'Volcano Engine Beijing',    'https://ark.cn-beijing.volces.com',   'v3',  'https', 'api_key', NULL, NULL, 'active', 'cn'),
('bytedance',  'volc-shanghai',  'Volcano Engine Shanghai',   'https://ark.cn-shanghai.volces.com',  'v3',  'https', 'api_key', NULL, NULL, 'active', 'cn'),
('mistral',    'api',            'Mistral La Plateforme',     'https://api.mistral.ai',              'v1',  'https', 'api_key_header', NULL, 'https://docs.mistral.ai', 'active', 'eu'),
('openrouter', 'api',            'OpenRouter API',            'https://openrouter.ai',              'v1',  'https', 'bearer_token', NULL, 'https://openrouter.ai/docs', 'active', 'multi'),
('together',   'api',            'Together AI API',           'https://api.together.ai',            'v1',  'https', 'bearer_token', NULL, NULL, 'active', 'multi'),
('fireworks',  'api',            'Fireworks AI API',          'https://api.fireworks.ai',           'v1',  'https', 'bearer_token', NULL, NULL, 'active', 'multi'),
('groq',       'api',            'Groq API',                  'https://api.groq.com',               'v1',  'https', 'api_key_header', NULL, NULL, 'active', 'multi'),
('cohere',     'api',            'Cohere API',                'https://api.cohere.ai',               'v1',  'https', 'bearer_token', NULL, 'https://docs.cohere.ai', 'active', 'us'),
('ai21',       'studio',         'AI21 Studio',               'https://api.ai21.com',                'v1',  'https', 'api_key_header', NULL, 'https://studio.ai21.com', 'active', 'us'),
('perplexity', 'api',            'Perplexity API',            'https://api.perplexity.ai',           'v1',  'https', 'bearer_token', NULL, 'https://docs.perplexity.ai', 'active', 'us'),
('huggingface','api',            'Hugging Face Inference',    'https://api-inference.huggingface.co','v1',  'https', 'bearer_token', NULL, NULL, 'active', 'multi');

-- Default mappings: each active model maps to its provider's primary endpoint
INSERT INTO model_endpoint_map (model_id, endpoint_id, is_default, routing_weight)
SELECT m.id, e.id, TRUE, 100
FROM models m
JOIN endpoints e ON e.provider_id = m.provider_id AND e.status = 'active'
WHERE NOT EXISTS (
    SELECT 1 FROM model_endpoint_map mem WHERE mem.model_id = m.id AND mem.is_default = TRUE
);

INSERT INTO model_aliases (model_id, alias, effective_start, is_current) VALUES
-- OpenAI
((SELECT id FROM models WHERE provider_id='openai' AND slug='gpt-4o'),                'gpt-4o-2024-05-13',          '2024-05-13', TRUE),
((SELECT id FROM models WHERE provider_id='openai' AND slug='gpt-4o-mini'),           'gpt-4o-mini-2024-07-18',     '2024-07-18', TRUE),
((SELECT id FROM models WHERE provider_id='openai' AND slug='o1'),                   'o1-2024-12-17',              '2024-12-17', TRUE),
((SELECT id FROM models WHERE provider_id='openai' AND slug='o3'),                   'o3-2025-04-01',              '2025-04-01', TRUE),
((SELECT id FROM models WHERE provider_id='openai' AND slug='o3-mini'),              'o3-mini-2025-01-31',         '2025-01-31', TRUE),
((SELECT id FROM models WHERE provider_id='openai' AND slug='o4-mini'),              'o4-mini-2025-04-16',         '2025-04-16', TRUE),
-- Anthropic
((SELECT id FROM models WHERE provider_id='anthropic' AND slug='claude-haiku-4-5'),  'claude-haiku-4-5-20251001',  '2025-10-01', TRUE),
((SELECT id FROM models WHERE provider_id='anthropic' AND slug='claude-3-5-sonnet-20241022'), 'claude-3-5-sonnet-20241022', '2024-10-22', TRUE),
((SELECT id FROM models WHERE provider_id='anthropic' AND slug='claude-3-5-haiku-20241022'),  'claude-3-5-haiku-20241022',  '2024-10-22', TRUE),
-- DeepSeek legacy aliases
((SELECT id FROM models WHERE provider_id='deepseek' AND slug='deepseek-chat'),      'deepseek-chat',               '2024-12-01', FALSE),
((SELECT id FROM models WHERE provider_id='deepseek' AND slug='deepseek-reasoner'),  'deepseek-reasoner',           '2025-01-01', FALSE);

COMMIT;
