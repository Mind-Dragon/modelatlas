-- ModelAtlas Schema
-- Generated 2026-05-09 from FINAL-SYNTHESIS.md
-- PostgreSQL-compatible DDL only. Load seed.sql after this file.

-- ============================================================
-- ENUM TYPES
-- ============================================================

CREATE TYPE provider_category AS ENUM (
    'us_ai_lab', 'chinese_ai_lab', 'eu_ai_lab', 'open_source',
    'api_aggregator', 'cloud_platform'
);

CREATE TYPE provider_region AS ENUM ('us', 'eu', 'cn', 'multi');

CREATE TYPE auth_type AS ENUM ('api_key', 'oauth', 'token', 'none');

CREATE TYPE provider_status AS ENUM ('active', 'deprecated', 'merged');

CREATE TYPE plan_tier AS ENUM (
    'free', 'pro', 'team', 'enterprise', 'token_plan', 'edu',
    'research', 'pay_as_you_go', 'subscription', 'custom'
);

CREATE TYPE billing_model AS ENUM (
    'per_token', 'subscription', 'token_plan', 'hybrid', 'custom'
);

CREATE TYPE model_status AS ENUM ('active', 'beta', 'deprecated', 'sunset');

CREATE TYPE capability_name AS ENUM (
    'text', 'vision', 'image_generation', 'audio', 'video',
    'tool_use', 'function_calling', 'structured_output',
    'streaming', 'code_execution', 'reasoning',
    'extended_thinking', 'computer_use', 'grounding',
    'search', 'file_upload', 'multilingual', 'json_mode'
);

CREATE TYPE endpoint_type AS ENUM ('standard', 'batch', 'streaming');

CREATE TYPE protocol_type AS ENUM ('https', 'websocket', 'grpc');

CREATE TYPE endpoint_auth_method AS ENUM (
    'bearer_token', 'api_key', 'api_key_header', 'api_key_query', 'oauth', 'custom'
);

CREATE TYPE endpoint_status AS ENUM ('active', 'deprecated', 'sunset');

-- ============================================================
-- TABLES
-- ============================================================

-- 1. PROVIDERS
CREATE TABLE providers (
    id          VARCHAR(64) PRIMARY KEY,
    slug        VARCHAR(128) UNIQUE NOT NULL,
    name        VARCHAR(256) NOT NULL,
    website     VARCHAR(512),
    description TEXT,
    category    provider_category NOT NULL,
    region      provider_region NOT NULL,
    auth_type   auth_type NOT NULL DEFAULT 'api_key',
    status      provider_status NOT NULL DEFAULT 'active',
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_providers_category ON providers(category);

CREATE INDEX idx_providers_region ON providers(region);

CREATE INDEX idx_providers_status ON providers(status);

-- 2. PROVIDER PLANS
CREATE TABLE provider_plans (
    id                  SERIAL PRIMARY KEY,
    provider_id         VARCHAR(64) NOT NULL REFERENCES providers(id) ON DELETE CASCADE,
    slug                VARCHAR(128) NOT NULL,
    name                VARCHAR(256) NOT NULL,
    tier                plan_tier NOT NULL,
    billing_model       billing_model NOT NULL,
    monthly_price_usd   NUMERIC(10,2),
    description         TEXT,
    rate_limit_rpm      INTEGER,
    rate_limit_rpd      INTEGER,
    rate_limit_tpm      INTEGER,
    rate_limit_concurrent INTEGER,
    max_batch_size      INTEGER,
    supports_batch_api  BOOLEAN NOT NULL DEFAULT FALSE,
    metadata            JSONB DEFAULT '{}',
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (provider_id, slug)
);

CREATE INDEX idx_provider_plans_tier ON provider_plans(tier);

CREATE INDEX idx_provider_plans_billing ON provider_plans(billing_model);

-- 3. MODELS
CREATE TABLE models (
    id                      SERIAL PRIMARY KEY,
    provider_id             VARCHAR(64) NOT NULL REFERENCES providers(id) ON DELETE CASCADE,
    slug                    VARCHAR(256) NOT NULL,
    display_name            VARCHAR(256) NOT NULL,
    model_family            VARCHAR(128),
    version_label           VARCHAR(64),
    context_window_tokens   INTEGER,
    max_output_tokens       INTEGER,
    max_batch_output_tokens INTEGER,
    training_cutoff_date    DATE,
    status                  model_status NOT NULL DEFAULT 'active',
    released_date           DATE,
    deprecated_date         DATE,
    sunset_date             DATE,
    description             TEXT,
    UNIQUE (provider_id, slug)
);

CREATE INDEX idx_models_provider ON models(provider_id);

CREATE INDEX idx_models_family ON models(model_family);

CREATE INDEX idx_models_status ON models(status);

CREATE INDEX idx_models_context ON models(context_window_tokens);

-- 4. MODEL CAPABILITIES
CREATE TABLE model_capabilities (
    id                  SERIAL PRIMARY KEY,
    model_id            INTEGER NOT NULL REFERENCES models(id) ON DELETE CASCADE,
    capability          capability_name NOT NULL,
    supported           BOOLEAN NOT NULL DEFAULT FALSE,
    max_images_per_request INTEGER,
    max_video_seconds   INTEGER,
    max_audio_seconds   INTEGER,
    notes               TEXT,
    UNIQUE (model_id, capability)
);

CREATE INDEX idx_model_capabilities_cap ON model_capabilities(capability);

-- 5. MODEL PRICING
CREATE TABLE model_pricing (
    id                              SERIAL PRIMARY KEY,
    model_id                        INTEGER NOT NULL REFERENCES models(id) ON DELETE CASCADE,
    plan_id                         INTEGER REFERENCES provider_plans(id) ON DELETE SET NULL,
    endpoint_type                   endpoint_type NOT NULL DEFAULT 'standard',
    region                          VARCHAR(32) NOT NULL DEFAULT 'us',
    price_per_1m_input_tokens       NUMERIC(12,6) NOT NULL,
    price_per_1m_output_tokens      NUMERIC(12,6) NOT NULL,
    price_per_1m_cached_input_tokens NUMERIC(12,6),
    price_per_1m_cached_output_tokens NUMERIC(12,6),
    price_per_1m_input_tokens_batch NUMERIC(12,6),
    price_per_1m_output_tokens_batch NUMERIC(12,6),
    price_per_image                 NUMERIC(12,6),
    price_per_video_second          NUMERIC(12,6),
    price_per_audio_second          NUMERIC(12,6),
    effective_date                  DATE NOT NULL DEFAULT CURRENT_DATE,
    currency                        VARCHAR(8) NOT NULL DEFAULT 'USD',
    metadata                        JSONB DEFAULT '{}'
);

CREATE INDEX idx_model_pricing_model ON model_pricing(model_id);

CREATE INDEX idx_model_pricing_plan ON model_pricing(plan_id);

CREATE INDEX idx_model_pricing_endpoint ON model_pricing(endpoint_type);

CREATE INDEX idx_model_pricing_effective ON model_pricing(effective_date);

-- 6. ENDPOINTS
CREATE TABLE endpoints (
    id              SERIAL PRIMARY KEY,
    provider_id     VARCHAR(64) NOT NULL REFERENCES providers(id) ON DELETE CASCADE,
    slug            VARCHAR(128) NOT NULL,
    name            VARCHAR(256) NOT NULL,
    base_url        VARCHAR(512) NOT NULL,
    version         VARCHAR(32),
    protocol        protocol_type NOT NULL DEFAULT 'https',
    auth_method     endpoint_auth_method NOT NULL DEFAULT 'api_key_header',
    health_endpoint VARCHAR(512),
    docs_url        VARCHAR(512),
    status          endpoint_status NOT NULL DEFAULT 'active',
    region          VARCHAR(32),
    UNIQUE (provider_id, slug)
);

CREATE INDEX idx_endpoints_provider ON endpoints(provider_id);

CREATE INDEX idx_endpoints_status ON endpoints(status);

-- 7. MODEL-ENDPOINT MAP
CREATE TABLE model_endpoint_map (
    id              SERIAL PRIMARY KEY,
    model_id        INTEGER NOT NULL REFERENCES models(id) ON DELETE CASCADE,
    endpoint_id     INTEGER NOT NULL REFERENCES endpoints(id) ON DELETE CASCADE,
    plan_id         INTEGER REFERENCES provider_plans(id) ON DELETE SET NULL,
    is_default      BOOLEAN NOT NULL DEFAULT FALSE,
    routing_weight  INTEGER NOT NULL DEFAULT 100,
    notes           TEXT,
    UNIQUE (model_id, endpoint_id, plan_id)
);

CREATE INDEX idx_model_endpoint_map_model ON model_endpoint_map(model_id);

CREATE INDEX idx_model_endpoint_map_endpoint ON model_endpoint_map(endpoint_id);

-- 8. MODEL ALIASES
CREATE TABLE model_aliases (
    id              SERIAL PRIMARY KEY,
    model_id        INTEGER NOT NULL REFERENCES models(id) ON DELETE CASCADE,
    alias           VARCHAR(256) NOT NULL,
    effective_start DATE,
    effective_end   DATE,
    is_current      BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE (model_id, alias)
);

CREATE INDEX idx_model_aliases_alias ON model_aliases(alias);

CREATE INDEX idx_model_aliases_current ON model_aliases(is_current) WHERE is_current = TRUE;
