-- Work Item: WS-97
-- Task: DWH.DimAccount
-- Spec: DWH.DimAccount.md
-- Version: 1
-- Generated: 2026-08-14T09:04:22.818799+00:00
-- Notes: Initial generation of DWH.DimAccount dimension using Type 1 SCD logic.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimAccount" (
    "AccountKey"             integer GENERATED ALWAYS AS IDENTITY,
    "AccountBK"              integer NOT NULL,
    "AccountCode"            varchar(255),
    "AccountName"            varchar(500),
    "AccountType"            varchar(255),
    "IsDeprecated"           boolean,
    "SupportsReconciliation" boolean,
    "IsNonTrade"             boolean,
    "AccountDescription"     text,
    CONSTRAINT "PK_DimAccount" PRIMARY KEY ("AccountKey")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimAccount_AccountBK" ON "DWH"."DimAccount" ("AccountBK");

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

INSERT INTO "DWH"."DimAccount" ("AccountKey", "AccountBK", "AccountCode", "AccountName", "AccountType", "IsDeprecated", "SupportsReconciliation", "IsNonTrade", "AccountDescription")
OVERRIDING SYSTEM VALUE
VALUES (-1, -1, 'Unknown', 'Unknown', 'Unknown', false, false, false, 'Unknown')
ON CONFLICT ("AccountKey") DO NOTHING;

INSERT INTO "DWH"."DimAccount" (
    "AccountBK", "AccountCode", "AccountName", "AccountType", "IsDeprecated", "SupportsReconciliation", "IsNonTrade", "AccountDescription"
)
SELECT 
    s."id", 
    (s."code_store"->>'value')::varchar(255), 
    (s."name"->>'value')::varchar(500), 
    s."account_type"::varchar(255), 
    s."deprecated"::boolean, 
    s."reconcile"::boolean, 
    s."non_trade"::boolean, 
    s."note"::text
FROM "public"."account_account" AS s
ON CONFLICT ("AccountBK") DO UPDATE SET
    "AccountCode" = EXCLUDED."AccountCode",
    "AccountName" = EXCLUDED."AccountName",
    "AccountType" = EXCLUDED."AccountType",
    "IsDeprecated" = EXCLUDED."IsDeprecated",
    "SupportsReconciliation" = EXCLUDED."SupportsReconciliation",
    "IsNonTrade" = EXCLUDED."IsNonTrade",
    "AccountDescription" = EXCLUDED."AccountDescription";