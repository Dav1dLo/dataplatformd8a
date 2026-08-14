-- Work Item: WS-97
-- Task: DWH.DimPartner
-- Spec: DWH.DimPartner.md
-- Version: 1
-- Generated: 2026-08-14T09:04:22.818799+00:00
-- Notes: Initial generation of DWH.DimPartner as a Type 1 dimension.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimPartner" (
    "PartnerKey" bigint GENERATED ALWAYS AS IDENTITY,
    "PartnerBK"  integer NOT NULL,
    "PartnerName" varchar(255),
    "PartnerType" varchar(50),
    "IsCompany"  boolean,
    "VatNumber"  varchar(64),
    "City"       varchar(128),
    "CountryID"  integer,
    "IsActive"   boolean,
    CONSTRAINT "PK_DimPartner" PRIMARY KEY ("PartnerKey")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimPartner_PartnerBK" ON "DWH"."DimPartner" ("PartnerBK");

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

INSERT INTO "DWH"."DimPartner" ("PartnerKey", "PartnerBK", "PartnerName", "PartnerType", "IsCompany", "VatNumber", "City", "CountryID", "IsActive")
OVERRIDING SYSTEM VALUE
VALUES (-1, -1, 'Unknown', 'Unknown', false, 'Unknown', 'Unknown', -1, false)
ON CONFLICT ("PartnerKey") DO NOTHING;

INSERT INTO "DWH"."DimPartner" (
    "PartnerBK", "PartnerName", "PartnerType", "IsCompany", "VatNumber", "City", "CountryID", "IsActive"
)
SELECT 
    s."id", s."name", s."type", s."is_company", s."vat", s."city", s."country_id", s."active"
FROM "public"."res_partner" AS s
ON CONFLICT ("PartnerBK") DO UPDATE SET
    "PartnerName" = EXCLUDED."PartnerName",
    "PartnerType" = EXCLUDED."PartnerType",
    "IsCompany"   = EXCLUDED."IsCompany",
    "VatNumber"   = EXCLUDED."VatNumber",
    "City"        = EXCLUDED."City",
    "CountryID"   = EXCLUDED."CountryID",
    "IsActive"    = EXCLUDED."IsActive";