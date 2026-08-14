-- Work Item: WS-97
-- Task: DWH.FactAnalyticEntry
-- Spec: DWH.FactAnalyticEntry.md
-- Version: 1
-- Generated: 2026-08-14T09:04:22.818799+00:00
-- Notes: Initial generation of DWH.FactAnalyticEntry as a transaction fact table.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."FactAnalyticEntry" (
    "AnalyticEntrySK" bigint GENERATED ALWAYS AS IDENTITY,
    "AccountKey"      integer       NOT NULL DEFAULT -1,
    "PartnerKey"      bigint        NOT NULL DEFAULT -1,
    "ProductKey"      integer       NOT NULL DEFAULT -1,
    "Date"            date          NOT NULL,
    "Amount"          numeric(38,6) NOT NULL,
    "UnitAmount"      numeric(38,6) NOT NULL,
    "AnalyticEntryBK" integer       NOT NULL,
    CONSTRAINT "PK_FactAnalyticEntry" PRIMARY KEY ("AnalyticEntrySK")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_FactAnalyticEntry_AnalyticEntryBK" ON "DWH"."FactAnalyticEntry" ("AnalyticEntryBK");

CREATE INDEX IF NOT EXISTS "IX_FactAnalyticEntry_AccountKey" ON "DWH"."FactAnalyticEntry" ("AccountKey");
CREATE INDEX IF NOT EXISTS "IX_FactAnalyticEntry_PartnerKey" ON "DWH"."FactAnalyticEntry" ("PartnerKey");
CREATE INDEX IF NOT EXISTS "IX_FactAnalyticEntry_ProductKey" ON "DWH"."FactAnalyticEntry" ("ProductKey");

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactAnalyticEntry_Account') THEN
        ALTER TABLE "DWH"."FactAnalyticEntry" ADD CONSTRAINT "FK_FactAnalyticEntry_Account" FOREIGN KEY ("AccountKey") REFERENCES "DWH"."DimAccount" ("AccountKey");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactAnalyticEntry_Partner') THEN
        ALTER TABLE "DWH"."FactAnalyticEntry" ADD CONSTRAINT "FK_FactAnalyticEntry_Partner" FOREIGN KEY ("PartnerKey") REFERENCES "DWH"."DimPartner" ("PartnerKey");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactAnalyticEntry_Product') THEN
        ALTER TABLE "DWH"."FactAnalyticEntry" ADD CONSTRAINT "FK_FactAnalyticEntry_Product" FOREIGN KEY ("ProductKey") REFERENCES "DWH"."DimProduct" ("ProductKey");
    END IF;
END $$;

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

INSERT INTO "DWH"."FactAnalyticEntry" (
    "AccountKey", "PartnerKey", "ProductKey", "Date", "Amount", "UnitAmount", "AnalyticEntryBK"
)
SELECT
    coalesce(da."AccountKey", -1),
    coalesce(dp."PartnerKey", -1),
    coalesce(dpr."ProductKey", -1),
    s."date",
    coalesce(s."amount", 0),
    coalesce(s."unit_amount", 0),
    s."id"
FROM "public"."account_analytic_line" AS s
LEFT JOIN "DWH"."DimAccount" AS da ON da."AccountBK" = s."account_id"
LEFT JOIN "DWH"."DimPartner" AS dp ON dp."PartnerBK" = s."partner_id"
LEFT JOIN "DWH"."DimProduct" AS dpr ON dpr."ProductBK" = s."product_id"
ON CONFLICT ("AnalyticEntryBK") DO UPDATE
SET "AccountKey" = EXCLUDED."AccountKey",
    "PartnerKey" = EXCLUDED."PartnerKey",
    "ProductKey" = EXCLUDED."ProductKey",
    "Date"       = EXCLUDED."Date",
    "Amount"     = EXCLUDED."Amount",
    "UnitAmount" = EXCLUDED."UnitAmount";