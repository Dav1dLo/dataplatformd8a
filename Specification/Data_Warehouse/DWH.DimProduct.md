# Fully Qualified Name: DWH.DimProduct

## Description
This dimension table represents the product catalog, containing details for individual product variants. It is used to categorize and filter financial and operational data by product in P&L and inventory reports.

## Grain
One row per product variant.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| ProductKey | SK | integer | integer | System-generated surrogate key. | |
| ProductBK | BK | integer | integer | Pass-through from public.product_product.id. | |
| ProductSKU | SCD1 | varchar(255) | varchar(255) | Pass-through from public.product_product.default_code. | |
| ProductBarcode | SCD1 | varchar(255) | varchar(255) | Pass-through from public.product_product.barcode. | |
| ProductVolume | SCD1 | numeric(38,6) | numeric(38,6) | Pass-through from public.product_product.volume. | |
| ProductWeight | SCD1 | numeric(38,6) | numeric(38,6) | Pass-through from public.product_product.weight. | |
| IsActive | SCD1 | boolean | boolean | Pass-through from public.product_product.active. | |

## Transformation Logic
The table is populated by selecting unique records from the source `public.product_product` table. The `ProductKey` is generated as a surrogate key. The business key `ProductBK` is mapped directly from the source `id`. Attributes are mapped directly, with `numeric` types standardized to `numeric(38,6)` to ensure consistent precision for downstream calculations.

## Lineage
- Reads from: [public.product_product](../Staging/public.product_product.md)

## Notes
- The `ProductSKU` and `ProductBarcode` are treated as Type 1 attributes as they are considered stable identifiers for the product variant.
- `numeric` precision is set to `(38,6)` as a safe default for physical measurements (volume/weight) where source precision was unspecified.
- The `active` flag from the source is preserved to allow filtering of archived products in downstream reports.