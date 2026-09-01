# Fully Qualified Name: DWH.DimCompany

## Description
This dimension table represents the legal entities or companies configured within the Odoo platform. It provides descriptive attributes for each company, enabling the segmentation and filtering of procurement and financial data by legal entity.

## Grain
One row per company.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| CompanyKey | SK | integer | integer | System-generated surrogate key. | |
| CompanyBK | BK | integer | integer | Pass-through from public.res_company.id. | |
| CompanyName | SCD1 | varchar(255) | varchar(255) | Pass-through from public.res_company.name. | |
| CompanyEmail | SCD1 | varchar(255) | varchar(255) | Pass-through from public.res_company.email. | |
| CompanyPhone | SCD1 | varchar(64) | varchar(64) | Pass-through from public.res_company.phone. | |
| IsActive | SCD1 | boolean | boolean | Pass-through from public.res_company.active. | |

## Transformation Logic
The table is populated by selecting active records from the `public.res_company` source table. The `CompanyKey` is generated as a surrogate key, while the `CompanyBK` maps to the source `id`. Attributes are passed through directly from the source.

## Lineage
- Reads from: [public.res_company](../Staging/public.res_company.md)

## Notes
- The `CompanyBK` corresponds to the `id` column in the source Odoo `res_company` table.
- The `IsActive` flag should be used to filter out inactive companies in downstream reporting unless specifically required.
- This dimension supports multi-company reporting in the `DWH.FactPurchaseOrderLine` fact table.