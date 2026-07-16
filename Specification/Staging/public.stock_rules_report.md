# stock_rules_report

## Source system
This table originates from an Odoo ERP system. The naming convention (using `_id` suffixes, `create_uid`/`write_uid` audit columns, and `product_tmpl_id`) is characteristic of Odoo's internal ORM structure, where `product_tmpl_id` refers to the product template and `id` is the standard surrogate primary key.

## Functional process 
This table supports inventory management and supply chain configuration processes. It tracks specific rules or reporting parameters applied to products and their variants, likely used to determine replenishment logic, stock movement constraints, or automated procurement triggers within the warehouse management module.

## Description
One row in this table represents a specific configuration or rule applied to a product or product template. It serves as a raw landed copy of the Odoo `stock.rules.report` model, capturing the association between products and their governing stock rules at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `stock_rules_report_id_seq`. |
| product_id | INTEGER | false | Foreign key to product | References the specific product variant. |
| product_tmpl_id | INTEGER | false | Foreign key to product template | References the parent product template. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| product_has_variants | BOOLEAN | false | Variant flag | Indicates if the product has multiple variants. |
| create_date | TIMESTAMP | true | Creation timestamp | Inferred UTC; audit field. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC; audit field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Inferred from Odoo naming conventions).
    - `product_tmpl_id` → `product_template.id` (Inferred from Odoo naming conventions).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit Fields:** `create_uid` and `write_uid` are nullable; expect missing values for legacy records or system-generated entries.
- **Soft Deletes:** This table does not appear to contain a `active` boolean flag, which is common in Odoo; assume all records are currently active unless otherwise specified by business logic.
- **Data Integrity:** As a staging table, this is a direct dump; verify referential integrity against the `product_product` and `product_template` tables before joining.