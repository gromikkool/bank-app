CREATE SCHEMA IF NOT EXISTS transaction_service;
CREATE
EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE transaction_service.wallet_types
(
    uuid          UUID PRIMARY KEY     DEFAULT uuid_generate_v4(),
    created_at    TIMESTAMP   NOT NULL DEFAULT now(),
    modified_at   TIMESTAMP,
    name          VARCHAR(32) NOT NULL,
    currency_code VARCHAR(3)  NOT NULL,
    status        VARCHAR(18) NOT NULL,
    archived_at   TIMESTAMP,
    user_type     VARCHAR(15),
    creator       VARCHAR(255),
    modifier      VARCHAR(255)
);

CREATE TABLE transaction_service.wallets
(
    uuid             UUID PRIMARY KEY        DEFAULT uuid_generate_v4(),
    created_at       TIMESTAMP      NOT NULL DEFAULT now(),
    modified_at      TIMESTAMP,
    name             VARCHAR(32)    NOT NULL,
    wallet_type_uuid UUID           NOT NULL REFERENCES transaction_service.wallet_types (uuid),
    user_uuid        UUID           NOT NULL,
    status           VARCHAR(30)    NOT NULL,
    balance          DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    archived_at      TIMESTAMP
);

CREATE TYPE transaction_service.payment_type AS ENUM ('DEPOSIT', 'WITHDRAWAL', 'TRANSFER');

CREATE TABLE transaction_service.transactions
(
    uuid               UUID PRIMARY KEY                          DEFAULT uuid_generate_v4(),
    created_at         TIMESTAMP                        NOT NULL DEFAULT now(),
    modified_at        TIMESTAMP,
    user_uuid          UUID                             NOT NULL,
    wallet_uuid        UUID                             NOT NULL REFERENCES transaction_service.wallets (uuid),
    amount             DECIMAL(10, 2)                   NOT NULL DEFAULT 0.00,
    type               transaction_service.payment_type NOT NULL,
    status             VARCHAR(32)                      NOT NULL,
    comment            VARCHAR(256),
    fee                DECIMAL(10, 2),
    target_wallet_uuid UUID,
    payment_method_id  BIGINT,
    failure_reason     VARCHAR(256)
);
