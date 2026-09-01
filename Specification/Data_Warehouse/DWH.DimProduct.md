# Fully Qualified Name: DWH.DimProduct

## Description
This dimension table represents the product catalog, containing unique product variants sourced from the Odoo ERP system. It provides descriptive attributes for products, enabling categorization and analysis in procurement and sales reporting.

## Grain
One row per unique product variant.

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
The table is populated by selecting unique product variants from the source `public.product_product` table. The `ProductKey` is generated as a surrogate key. The business key `ProductBK` is mapped from the source `id`. Attributes are mapped directly from the source, with `numeric` types standardized to `numeric(38,6)` to ensure consistent precision for downstream calculations.

## Lineage
- Reads from: [public.product_product](../Staging/public.product_product.md)

## Notes
- The `ProductSKU` and `ProductBarcode` are mapped to `varchar(255)` as a safe default for string identifiers where source precision is not explicitly defined.
- `IsActive` should be used to filter for currently active products in standard reporting.
- Future iterations may include attributes from the `product_template` table to provide a more comprehensive product hierarchy.