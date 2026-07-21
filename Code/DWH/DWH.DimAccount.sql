-- Work Item: ad-hoc
-- Task: DWH.DimAccount
-- Spec: DWH.DimAccount.md
-- Version: 1
-- Generated: 2026-07-21T13:48:09.766523+00:00
-- Notes: Initial generation of Type 1 dimension table.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimAccount" (
    "AccountKey"    integer GENERATED ALWAYS AS IDENTITY,
    "AccountBK"     integer NOT NULL,
    "AccountCode"   varchar(255),
    "AccountName"   varchar(255),
    "AccountType"   varchar(255),
    "IsDeprecated"  boolean,
    "IsReconcilable" boolean,
    "IsNonTrade"    boolean,
    "AccountTags"   text,
    CONSTRAINT "PK_DimAccount" PRIMARY KEY ("AccountKey")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimAccount_AccountBK" ON "DWH"."DimAccount" ("AccountBK");

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

INSERT INTO "DWH"."DimAccount" (
    "AccountKey", "AccountBK", "AccountCode", "AccountName", "AccountType", 
    "IsDeprecated", "IsReconcilable", "IsNonTrade", "AccountTags"
)
OVERRIDING SYSTEM VALUE
VALUES (
    -1, -1, 'Unknown', 'Unknown', 'Unknown', false, false, false, 'Unknown'
)
ON CONFLICT ("AccountKey") DO NOTHING;

INSERT INTO "DWH"."DimAccount" (
    "AccountBK", "AccountCode", "AccountName", "AccountType", 
    "IsDeprecated", "IsReconcilable", "IsNonTrade", "AccountTags"
)
SELECT 
    s."id"::integer,
    s."code_store"::text,
    s."name"::text,
    s."account_type"::text,
    s."deprecated"::boolean,
    s."reconcile"::boolean,
    s."non_trade"::boolean,
    t."tags"
FROM "public"."account_account" s
LEFT JOIN (
    SELECT 
        aaat."account_account_id", 
        string_agg(at."name", ', ') as "tags"
    FROM "public"."account_account_account_tag" aaat
    JOIN "public"."account_account_tag" at ON aaat."account_account_tag_id" = at."id"
    GROUP BY aaat."account_account_id"
) t ON s."id" = t."account_account_id"
ON CONFLICT ("AccountBK") DO UPDATE SET
    "AccountCode" = EXCLUDED."AccountCode",
    "AccountName" = EXCLUDED."AccountName",
    "AccountType" = EXCLUDED."AccountType",
    "IsDeprecated" = EXCLUDED."IsDeprecated",
    "IsReconcilable" = EXCLUDED."IsReconcilable",
    "IsNonTrade" = EXCLUDED."IsNonTrade",
    "AccountTags" = EXCLUDED."AccountTags";