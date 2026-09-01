-- Work Item: ad-hoc
-- Task: DWH.DimProduct
-- Spec: DWH.DimProduct.md
-- Version: 2
-- Generated: 2026-09-01T17:48:51.171091+00:00
-- Notes: Renamed ProductBarcode to ProductSuperBarCode per spec and added missing column handling.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimProduct" (
    "ProductKey"    integer GENERATED ALWAYS AS IDENTITY,
    "ProductBK"     integer NOT NULL,
    "ProductSKU"    varchar(255),
    "ProductSuperBarCode" varchar(255),
    "ProductVolume" numeric(38,6),
    "ProductWeight" numeric(38,6),
    "IsActive"      boolean,
    CONSTRAINT "PK_DimProduct" PRIMARY KEY ("ProductKey")
);

ALTER TABLE "DWH"."DimProduct" ADD COLUMN IF NOT EXISTS "ProductSKU" varchar(255);
ALTER TABLE "DWH"."DimProduct" ADD COLUMN IF NOT EXISTS "ProductSuperBarCode" varchar(255);
ALTER TABLE "DWH"."DimProduct" ADD COLUMN IF NOT EXISTS "ProductVolume" numeric(38,6);
ALTER TABLE "DWH"."DimProduct" ADD COLUMN IF NOT EXISTS "ProductWeight" numeric(38,6);
ALTER TABLE "DWH"."DimProduct" ADD COLUMN IF NOT EXISTS "IsActive" boolean;

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimProduct_ProductBK" ON "DWH"."DimProduct" ("ProductBK");

INSERT INTO "DWH"."DimProduct" (
    "ProductKey", "ProductBK", "ProductSKU", "ProductSuperBarCode", "ProductVolume", "ProductWeight", "IsActive"
)
OVERRIDING SYSTEM VALUE
VALUES (
    -1, -1, 'Unknown', 'Unknown', 0, 0, false
)
ON CONFLICT ("ProductKey") DO NOTHING;

INSERT INTO "DWH"."DimProduct" (
    "ProductBK", "ProductSKU", "ProductSuperBarCode", "ProductVolume", "ProductWeight", "IsActive"
)
SELECT
    s."id"::integer,
    s."default_code"::varchar(255),
    s."barcode"::varchar(255),
    s."volume"::numeric(38,6),
    s."weight"::numeric(38,6),
    s."active"::boolean
FROM "public"."product_product" AS s
ON CONFLICT ("ProductBK") DO UPDATE
SET "ProductSKU" = EXCLUDED."ProductSKU",
    "ProductSuperBarCode" = EXCLUDED."ProductSuperBarCode",
    "ProductVolume" = EXCLUDED."ProductVolume",
    "ProductWeight" = EXCLUDED."ProductWeight",
    "IsActive" = EXCLUDED."IsActive";