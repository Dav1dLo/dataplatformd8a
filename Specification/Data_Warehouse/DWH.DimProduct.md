# Fully Qualified Name: DWH.DimProduct

## Description
This dimension table provides descriptive attributes for products and their variants, enabling analysis of procurement and sales by product characteristics. It consolidates information from the product template and variant levels.

## Grain
One row per unique product variant.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| ProductKey | SK | bigint | 8 bytes | System-generated surrogate key. | |
| ProductBK | BK | integer | 4 bytes | Source `public.product_product.id`. | |
| ProductTemplateBK | SCD1 | integer | 4 bytes | Source `public.product_product.product_tmpl_id`. | |
| SKU | SCD1 | varchar(255) | 255 | Source `public.product_product.default_code` (or `public.product_template.default_code` if variant code is null). | |
| ProductName | SCD1 | varchar(1024) | 1024 | Source `public.product_template.name` (extracted from JSONB). | |
| ProductType | SCD1 | varchar(50) | 50 | Source `public.product_template.type`. | |
| IsActive | SCD1 | boolean | 1 | Source `public.product_product.active`. | |
| Weight | SCD1 | numeric(18,6) | 18,6 | Source `public.product_product.weight`. | |
| Volume | SCD1 | numeric(18,6) | 18,6 | Source `public.product_product.volume`. | |

## Transformation Logic
The table is populated by joining `public.product_product` (as the base grain) with `public.product_template` on `product_product.product_tmpl_id = product_template.id`. The `ProductName` is extracted from the `JSONB` field in `product_template.name` (defaulting to the 'en_US' key if available). The `SKU` is prioritized from the variant level (`product_product.default_code`), falling back to the template level (`product_template.default_code`).

## Lineage
- Reads from: [public.product_product](../Staging/public.product_product.md)
- Reads from: [public.product_template](../Staging/public.product_template.md)

## Notes
- `ProductName` extraction assumes a standard Odoo JSONB structure where keys represent language codes.
- `Weight` and `Volume` precision is set to `numeric(18,6)` as a safe default for physical measurements.
- `IsActive` filter should be applied by downstream consumers if they only wish to see currently active products.