-- Work Item: WS-97
-- Task: DWH.DimProduct
-- Spec: DWH.DimProduct
-- Version: 1
-- Generated: 2026-08-14T09:04:22.818799+00:00
-- Notes: Initial generation of DWH.DimProduct as a Type 1 dimension.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimProduct" (
    "ProductKey"    integer GENERATED ALWAYS AS IDENTITY,
    "ProductBK"     integer NOT NULL,
    "ProductSKU"    varchar(255),
    "ProductBarcode" varchar(255),
    "ProductVolume" numeric(38,6),
    "ProductWeight" numeric(38,6),
    "IsActive"      boolean,
    CONSTRAINT "PK_DimProduct" PRIMARY KEY ("ProductKey")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimProduct_ProductBK" ON "DWH"."DimProduct" ("ProductBK");

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

INSERT INTO "DWH"."DimProduct" ("ProductKey", "ProductBK", "ProductSKU", "ProductBarcode", "ProductVolume", "ProductWeight", "IsActive")
VALUES (-1, -1, 'Unknown', 'Unknown', 0, 0, false)
ON CONFLICT ("ProductKey") DO NOTHING;

INSERT INTO "DWH"."DimProduct" ("ProductBK", "ProductSKU", "ProductBarcode", "ProductVolume", "ProductWeight", "IsActive")
SELECT 
    s."id", 
    s."default_code", 
    s."barcode", 
    s."volume", 
    s."weight", 
    s."active"
FROM "public"."product_product" AS s
ON CONFLICT ("ProductBK") DO UPDATE 
SET 
    "ProductSKU" = EXCLUDED."ProductSKU",
    "ProductBarcode" = EXCLUDED."ProductBarcode",
    "ProductVolume" = EXCLUDED."ProductVolume",
    "ProductWeight" = EXCLUDED."ProductWeight",
    "IsActive" = EXCLUDED."IsActive";