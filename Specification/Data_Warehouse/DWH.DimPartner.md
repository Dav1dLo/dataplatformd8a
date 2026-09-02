# Fully Qualified Name: DWH.DimPartner

## Description
Represents business partners (customers, suppliers, and internal contacts) involved in financial transactions. This dimension provides descriptive attributes for filtering and grouping analytic accounting entries.

## Grain
One row per partner.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| PartnerKey | SK | bigint | 8 | System-generated surrogate key. | |
| PartnerBK | BK | integer | 4 | Pass-through from public.res_partner.id. | |
| PartnerName | SCD1 | varchar(255) | 255 | Pass-through from public.res_partner.name. | |
| PartnerType | SCD1 | varchar(50) | 50 | Pass-through from public.res_partner.type. | |
| IsCompany | SCD1 | boolean | 1 | Pass-through from public.res_partner.is_company. | |
| VatNumber | SCD1 | varchar(64) | 64 | Pass-through from public.res_partner.vat. | |
| City | SCD1 | varchar(128) | 128 | Pass-through from public.res_partner.city. | |
| CountryID | SCD1 | integer | 4 | Pass-through from public.res_partner.country_id. | |
| IsActive | SCD1 | boolean | 1 | Pass-through from public.res_partner.active. | |

## Transformation Logic
The dimension is loaded from `public.res_partner`. Records are selected to include all partners, with the `active` status preserved as an attribute for filtering in downstream reports. No history is tracked (Type 1).

## Lineage
- Reads from: [public.res_partner](../Staging/public.res_partner.md)

## Notes
- The `PartnerBK` corresponds to the Odoo internal `id`.
- `IsActive` should be used to filter out inactive partners in standard P&L or balance sheet reports unless specifically requested.
- PII data such as `email` and `phone` are excluded from this dimension to minimize exposure; they can be added if required for specific operational reporting.