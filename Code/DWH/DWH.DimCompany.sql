-- Work Item: ad-hoc
-- Task: DWH.DimCompany
-- Spec: DWH.DimCompany
-- Version: 1
-- Generated: 2026-09-01T17:59:43.303857+00:00
-- Notes: Initial generation of DWH.DimCompany with SCD Type 1 upsert logic.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimCompany" (
    "CompanyKey"  integer GENERATED ALWAYS AS IDENTITY,
    "CompanyBK"   integer NOT NULL,
    "CompanyName" varchar(255),
    "CompanyEmail" varchar(255),
    "CompanyPhone" varchar(64),
    "IsActive"    boolean,
    CONSTRAINT "PK_DimCompany" PRIMARY KEY ("CompanyKey")
);

ALTER TABLE "DWH"."DimCompany" ADD COLUMN IF NOT EXISTS "CompanyKey" integer;
ALTER TABLE "DWH"."DimCompany" ADD COLUMN IF NOT EXISTS "CompanyBK" integer;
ALTER TABLE "DWH"."DimCompany" ADD COLUMN IF NOT EXISTS "CompanyName" varchar(255);
ALTER TABLE "DWH"."DimCompany" ADD COLUMN IF NOT EXISTS "CompanyEmail" varchar(255);
ALTER TABLE "DWH"."DimCompany" ADD COLUMN IF NOT EXISTS "CompanyPhone" varchar(64);
ALTER TABLE "DWH"."DimCompany" ADD COLUMN IF NOT EXISTS "IsActive" boolean;

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimCompany_CompanyBK" ON "DWH"."DimCompany" ("CompanyBK");

INSERT INTO "DWH"."DimCompany" ("CompanyKey", "CompanyBK", "CompanyName", "CompanyEmail", "CompanyPhone", "IsActive")
OVERRIDING SYSTEM VALUE
VALUES (-1, -1, 'Unknown', 'Unknown', 'Unknown', false)
ON CONFLICT ("CompanyKey") DO NOTHING;

INSERT INTO "DWH"."DimCompany" ("CompanyBK", "CompanyName", "CompanyEmail", "CompanyPhone", "IsActive")
SELECT 
    s."id"::integer, 
    s."name"::varchar(255), 
    s."email"::varchar(255), 
    s."phone"::varchar(64), 
    s."active"::boolean
FROM "public"."res_company" AS s
ON CONFLICT ("CompanyBK") DO UPDATE 
SET "CompanyName" = EXCLUDED."CompanyName",
    "CompanyEmail" = EXCLUDED."CompanyEmail",
    "CompanyPhone" = EXCLUDED."CompanyPhone",
    "IsActive" = EXCLUDED."IsActive";