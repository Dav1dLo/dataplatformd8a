-- Work Item: ad-hoc
-- Task: DWH.DimVendor
-- Spec: DWH.DimVendor
-- Version: 3
-- Generated: 2026-09-01T18:40:47.395742+00:00
-- Notes: Added missing technical columns and ensured idempotent schema evolution.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimVendor" (
    "VendorKey"       integer GENERATED ALWAYS AS IDENTITY,
    "VendorBK"        integer NOT NULL,
    "VendorName"      varchar(255),
    "VendorVAT"       varchar(64),
    "VendorCity"      varchar(128),
    "VendorCountryID" integer,
    "IsActive"        boolean,
    "SupplierRank"    integer,
    "EffectiveDate"   timestamptz NOT NULL DEFAULT now(),
    "ExpiryDate"      timestamptz,
    "IsCurrent"       boolean NOT NULL DEFAULT true,
    "CreatedDate"     timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT "PK_DimVendor" PRIMARY KEY ("VendorKey")
);

ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "EffectiveDate" timestamptz NOT NULL DEFAULT now();
ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "ExpiryDate" timestamptz;
ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "IsCurrent" boolean NOT NULL DEFAULT true;
ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "CreatedDate" timestamptz NOT NULL DEFAULT now();

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimVendor_VendorBK" ON "DWH"."DimVendor" ("VendorBK");

INSERT INTO "DWH"."DimVendor" ("VendorKey", "VendorBK", "VendorName", "VendorVAT", "VendorCity", "VendorCountryID", "IsActive", "SupplierRank", "EffectiveDate", "IsCurrent", "CreatedDate")
OVERRIDING SYSTEM VALUE
VALUES (-1, -1, 'Unknown', 'Unknown', 'Unknown', -1, false, 0, '1900-01-01 00:00:00+00', true, now())
ON CONFLICT ("VendorKey") DO NOTHING;

INSERT INTO "DWH"."DimVendor" ("VendorBK", "VendorName", "VendorVAT", "VendorCity", "VendorCountryID", "IsActive", "SupplierRank", "EffectiveDate", "IsCurrent", "CreatedDate")
SELECT 
    s."id"::integer,
    s."name"::varchar(255),
    s."vat"::varchar(64),
    s."city"::varchar(128),
    s."country_id"::integer,
    s."active"::boolean,
    s."supplier_rank"::integer,
    now(),
    true,
    now()
FROM "public"."res_partner" AS s
WHERE s."supplier_rank" > 0
ON CONFLICT ("VendorBK") DO UPDATE SET
    "VendorName" = EXCLUDED."VendorName",
    "VendorVAT" = EXCLUDED."VendorVAT",
    "VendorCity" = EXCLUDED."VendorCity",
    "VendorCountryID" = EXCLUDED."VendorCountryID",
    "IsActive" = EXCLUDED."IsActive",
    "SupplierRank" = EXCLUDED."SupplierRank";