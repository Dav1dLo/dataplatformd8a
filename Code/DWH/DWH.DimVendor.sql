-- Work Item: ad-hoc
-- Task: DWH.DimVendor
-- Spec: DWH.DimVendor
-- Version: 1
-- Generated: 2026-09-01T18:02:31.424578+00:00
-- Notes: Initial generation of DWH.DimVendor using Type 1 upsert pattern.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimVendor" (
    "VendorKey"      integer GENERATED ALWAYS AS IDENTITY,
    "VendorBK"       integer NOT NULL,
    "VendorName"     varchar(255),
    "VendorVAT"      varchar(64),
    "VendorCity"     varchar(128),
    "VendorCountryID" integer,
    "IsActive"       boolean,
    "SupplierRank"   integer,
    CONSTRAINT "PK_DimVendor" PRIMARY KEY ("VendorKey")
);

ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "VendorKey" integer;
ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "VendorBK" integer;
ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "VendorName" varchar(255);
ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "VendorVAT" varchar(64);
ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "VendorCity" varchar(128);
ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "VendorCountryID" integer;
ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "IsActive" boolean;
ALTER TABLE "DWH"."DimVendor" ADD COLUMN IF NOT EXISTS "SupplierRank" integer;

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimVendor_VendorBK" ON "DWH"."DimVendor" ("VendorBK");

INSERT INTO "DWH"."DimVendor" ("VendorKey", "VendorBK", "VendorName", "VendorVAT", "VendorCity", "VendorCountryID", "IsActive", "SupplierRank")
OVERRIDING SYSTEM VALUE
VALUES (-1, -1, 'Unknown', 'Unknown', 'Unknown', -1, false, 0)
ON CONFLICT ("VendorKey") DO NOTHING;

INSERT INTO "DWH"."DimVendor" ("VendorBK", "VendorName", "VendorVAT", "VendorCity", "VendorCountryID", "IsActive", "SupplierRank")
SELECT 
    "id"::integer, 
    "name"::varchar(255), 
    "vat"::varchar(64), 
    "city"::varchar(128), 
    "country_id"::integer, 
    "active"::boolean, 
    "supplier_rank"::integer
FROM "public"."res_partner"
WHERE "supplier_rank" > 0
ON CONFLICT ("VendorBK") DO UPDATE SET
    "VendorName" = EXCLUDED."VendorName",
    "VendorVAT" = EXCLUDED."VendorVAT",
    "VendorCity" = EXCLUDED."VendorCity",
    "VendorCountryID" = EXCLUDED."VendorCountryID",
    "IsActive" = EXCLUDED."IsActive",
    "SupplierRank" = EXCLUDED."SupplierRank";