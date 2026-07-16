# stock_change_product_qty

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns such as `product_tmpl_id`, `create_uid`, `write_uid`, and the use of standard Odoo sequence-based primary keys.

## Functional process 
This table supports the inventory adjustment and stock management process. It tracks specific quantity changes applied to products, likely serving as a staging log for inventory reconciliation or stock level updates within the warehouse management module.

## Description
Each row represents a single record of a product quantity adjustment event. This is a raw landed staging table, capturing the state of stock changes as they exist in the source ERP, intended for subsequent transformation into inventory fact tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.stock_change_product_qty_id_seq`. |
| product_id | INTEGER | false | Unique identifier for the specific product variant | Foreign key to product variant table. |
| product_tmpl_id | INTEGER | false | Unique identifier for the product template | Links to the base product definition. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| new_quantity | NUMERIC | false | The updated stock quantity value | Unit of measure depends on the product configuration. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Likely reference to the specific product variant).
    - `product_tmpl_id` → `product_template.id` (Likely reference to the base product template).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names; no direct PII is present in this table.
- **Soft Deletes:** This table does not explicitly show a `deleted` or `active` flag; assume all records are current unless a business logic layer filters them.
- **Precision:** `new_quantity` is `NUMERIC` without defined scale/precision; verify if downstream systems require rounding to specific decimal places (e.g., 2 or 4) based on product UOM.