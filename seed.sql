-- DeerFlow ModelDB Seed Data
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
