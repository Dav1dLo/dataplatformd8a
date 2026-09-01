-- Work Item: ad-hoc
-- Task: DWH.DimProduct
-- Spec: DWH.DimProduct.md
-- Version: 4
-- Generated: 2026-09-01T18:25:58.370500+00:00
-- Notes: Added missing TC columns (EffectiveDate, ExpiryDate, IsCurrent, CreatedDate) to align with dimension pattern.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimProduct" (
    "ProductKey"    integer GENERATED ALWAYS AS IDENTITY,
    "ProductBK"     integer NOT NULL,
    "ProductSKU"    varchar(255),
    "ProductSuperBarCode" varchar(255),
    "ProductVolume" numeric(38,6),
    "ProductWeight" numeric(38,6),
    "IsActive"      boolean,
    "EffectiveDate" timestamptz NOT NULL DEFAULT now(),
    "ExpiryDate"    timestamptz,
    "IsCurrent"     boolean NOT NULL DEFAULT true,
    "CreatedDate"   timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT "PK_DimProduct" PRIMARY KEY ("ProductKey")
);

ALTER TABLE "DWH"."DimProduct" ADD COLUMN IF NOT EXISTS "EffectiveDate" timestamptz NOT NULL DEFAULT now();
ALTER TABLE "DWH"."DimProduct" ADD COLUMN IF NOT EXISTS "ExpiryDate" timestamptz;
ALTER TABLE "DWH"."DimProduct" ADD COLUMN IF NOT EXISTS "IsCurrent" boolean NOT NULL DEFAULT true;
ALTER TABLE "DWH"."DimProduct" ADD COLUMN IF NOT EXISTS "CreatedDate" timestamptz NOT NULL DEFAULT now();

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimProduct_ProductBK" ON "DWH"."DimProduct" ("ProductBK");

INSERT INTO "DWH"."DimProduct" (
    "ProductKey", "ProductBK", "ProductSKU", "ProductSuperBarCode", "ProductVolume", "ProductWeight", "IsActive", "EffectiveDate", "ExpiryDate", "IsCurrent", "CreatedDate"
)
OVERRIDING SYSTEM VALUE
VALUES (
    -1, -1, 'Unknown', 'Unknown', 0, 0, false, '1900-01-01 00:00:00+00', NULL, true, '1900-01-01 00:00:00+00'
)
ON CONFLICT ("ProductKey") DO NOTHING;

INSERT INTO "DWH"."DimProduct" (
    "ProductBK", "ProductSKU", "ProductSuperBarCode", "ProductVolume", "ProductWeight", "IsActive", "EffectiveDate", "ExpiryDate", "IsCurrent", "CreatedDate"
)
SELECT
    s."id"::integer,
    s."default_code"::varchar(255),
    s."barcode"::varchar(255),
    s."volume"::numeric(38,6),
    s."weight"::numeric(38,6),
    s."active"::boolean,
    now(),
    NULL,
    true,
    now()
FROM "public"."product_product" AS s
ON CONFLICT ("ProductBK") DO UPDATE
SET "ProductSKU" = EXCLUDED."ProductSKU",
    "ProductSuperBarCode" = EXCLUDED."ProductSuperBarCode",
    "ProductVolume" = EXCLUDED."ProductVolume",
    "ProductWeight" = EXCLUDED."ProductWeight",
    "IsActive" = EXCLUDED."IsActive";