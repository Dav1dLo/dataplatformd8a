# Fully Qualified Name: DWH.DimVendor

## Description
This dimension table represents vendors from whom the organization procures goods or services. It provides descriptive attributes for vendor analysis, including contact information, location, and procurement-related settings.

## Grain
One row per vendor.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| VendorKey | SK | bigint | 8 bytes | System-generated surrogate key. | |
| VendorBK | BK | integer | 4 bytes | Source `public.res_partner.id`. | |
| VendorName | SCD1 | varchar(255) | 255 | Source `public.res_partner.name`. | |
| VendorVAT | SCD1 | varchar(64) | 64 | Source `public.res_partner.vat`. | |
| VendorCity | SCD1 | varchar(128) | 128 | Source `public.res_partner.city`. | |
| VendorCountryID | SCD1 | integer | 4 bytes | Source `public.res_partner.country_id`. | |
| IsCompany | SCD1 | boolean | 1 | Source `public.res_partner.is_company`. | |
| SupplierRank | SCD1 | integer | 4 bytes | Source `public.res_partner.supplier_rank`. | |
| CreatedDate | TC | timestamp | 8 bytes | Source `public.res_partner.create_date`. | |

## Transformation Logic
The table is populated by selecting records from `public.res_partner` where `supplier_rank > 0` and `active = TRUE`. Attributes are mapped directly from the source.

## Lineage
- Reads from: [public.res_partner](../Staging/public.res_partner.md)

## Notes
- The `supplier_rank` attribute is used to filter for entities that have acted as suppliers.
- The `active` flag from the source is used to filter out logically deleted records.
- Precision for string fields is set to standard lengths based on typical Odoo schema definitions.