# Fully Qualified Name: DWH.DimVendor

## Description
This dimension table represents vendors from whom the organization procures goods or services. It provides descriptive attributes for vendor identification, classification, and contact information, derived from the central partner registry.

## Grain
One row per vendor.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| VendorKey | SK | integer | 4 bytes | System-generated surrogate key. | |
| VendorBK | BK | integer | 4 bytes | Pass-through from public.res_partner.id. | |
| VendorName | SCD1 | varchar(255) | 255 | Pass-through from public.res_partner.name. | |
| VendorExpensiveVAT | SCD1 | varchar(64) | 64 | Pass-through from public.res_partner.vat. | |
| VendorCity | SCD1 | varchar(128) | 128 | Pass-through from public.res_partner.city. | |
| VendorCountryID | SCD1 | integer | 4 bytes | Pass-through from public.res_partner.country_id. | |
| IsActive | SCD1 | boolean | 1 byte | Pass-through from public.res_partner.active. | |
| SupplierRank | SCD1 | integer | 4 bytes | Pass-through from public.res_partner.supplier_rank. | |

## Transformation Logic
The table is populated by selecting records from `public.res_partner` where `supplier_rank > 0`. The data is treated as Type 1, overwriting attributes on change. The `VendorKey` is generated as a surrogate key to uniquely identify each vendor record.

## Lineage
- Reads from: [public.res_partner](../Staging/public.res_partner.md)

## Notes
- Vendors are identified by filtering `public.res_partner` for records where `supplier_rank > 0`.
- The `active` flag should be considered when filtering for current vendors; however, this dimension includes all historical vendors marked as inactive for reporting consistency.
- PII data such as specific street addresses or contact emails are excluded to minimize exposure, focusing on attributes relevant for procurement reporting.