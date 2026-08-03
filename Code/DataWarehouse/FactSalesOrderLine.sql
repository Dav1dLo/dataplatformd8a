-- Work Item: ad-hoc
-- Task: FactSalesOrderLine
-- Spec: DataWarehouse.FactSalesOrderLine
-- Version: 1
-- Generated: 2026-08-03T13:30:37.303455+00:00
-- Notes: Initial generation of FactSalesOrderLine with idempotent DDL and grain-based upsert logic.

CREATE SCHEMA IF NOT EXISTS "DataWarehouse";

CREATE TABLE IF NOT EXISTS "DataWarehouse"."FactSalesOrderLine" (
    "SalesOrderLineSK"   bigint GENERATED ALWAYS AS IDENTITY,
    "OrderDateSK"        integer        NOT NULL DEFAULT -1,
    "ProductSK"          integer        NOT NULL DEFAULT -1,
    "SalesOrderLineID"   integer        NOT NULL,
    "SalesOrderNumber"   varchar(255)   NOT NULL,
    "QuantityOrdered"    numeric(38, 6) NOT NULL,
    "QuantityDelivered"  numeric(38, 6) NOT NULL,
    "UnitPrice"          numeric(38, 6),
    "DiscountPercentage" numeric(38, 6),
    "LineSubtotal"       numeric(38, 6) NOT NULL,
    "FulfillmentStatus"  varchar(50),
    CONSTRAINT "PK_FactSalesOrderLine" PRIMARY KEY ("SalesOrderLineSK")
);

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

CREATE UNIQUE INDEX IF NOT EXISTS "UK_FactSalesOrderLine_Grain"
    ON "DataWarehouse"."FactSalesOrderLine" ("SalesOrderLineID");

CREATE INDEX IF NOT EXISTS "IX_FactSalesOrderLine_ProductSK" ON "DataWarehouse"."FactSalesOrderLine" ("ProductSK");

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactSalesOrderLine_Product') THEN
        ALTER TABLE "DataWarehouse"."FactSalesOrderLine" ADD CONSTRAINT "FK_FactSalesOrderLine_Product"
            FOREIGN KEY ("ProductSK") REFERENCES "DataWarehouse"."DimProduct" ("ProductSK");
    END IF;
END $$;

INSERT INTO "DataWarehouse"."FactSalesOrderLine" (
    "OrderDateSK", "ProductSK", "SalesOrderLineID", "SalesOrderNumber", 
    "QuantityOrdered", "QuantityDelivered", "UnitPrice", "DiscountPercentage", 
    "LineSubtotal", "FulfillmentStatus"
)
SELECT
    coalesce(to_char(so."date_order", 'YYYYMMDD')::int, -1),
    coalesce(dp."ProductSK", -1),
    sol."id",
    so."name",
    coalesce(sol."product_uom_qty", 0),
    coalesce(sol."qty_delivered", 0),
    sol."price_unit",
    sol."discount",
    coalesce(sol."price_subtotal", 0),
    CASE 
        WHEN sol."qty_delivered" >= sol."product_uom_qty" THEN 'Fulfilled'
        WHEN sol."qty_delivered" > 0 THEN 'Partial'
        ELSE 'Pending'
    END
FROM "public"."sale_order_line" AS sol
JOIN "public"."sale_order" AS so ON sol."order_id" = so."id"
LEFT JOIN "DataWarehouse"."DimProduct" AS dp ON sol."product_id" = dp."ProductID"
ON CONFLICT ("SalesOrderLineID") DO UPDATE
SET "OrderDateSK" = EXCLUDED."OrderDateSK",
    "ProductSK" = EXCLUDED."ProductSK",
    "SalesOrderNumber" = EXCLUDED."SalesOrderNumber",
    "QuantityOrdered" = EXCLUDED."QuantityOrdered",
    "QuantityDelivered" = EXCLUDED."QuantityDelivered",
    "UnitPrice" = EXCLUDED."UnitPrice",
    "DiscountPercentage" = EXCLUDED."DiscountPercentage",
    "LineSubtotal" = EXCLUDED."LineSubtotal",
    "FulfillmentStatus" = EXCLUDED."FulfillmentStatus";