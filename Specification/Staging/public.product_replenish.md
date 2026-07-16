# product_replenish

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `product_tmpl_id`, `product_uom_id`, `create_uid`, `write_uid`) and the presence of `nextval` sequences are characteristic of Odoo's PostgreSQL database schema.

## Functional process 
This table supports the inventory replenishment and supply chain planning process. It tracks planned stock movements or procurement requirements for specific products within defined warehouses, linking them to supply routes, bills of materials (`bom_id`), and suppliers.

## Description
One row in this table represents a single planned replenishment event or stock requirement for a specific product at a given warehouse. As a staging table, it serves as a raw, landed copy of the Odoo replenishment records, providing the base grain for downstream inventory forecasting and procurement analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_replenish_id_seq`. |
| route_id | INTEGER | true | Foreign key to procurement route | Defines the supply path (e.g., Buy, MTO). |
| product_id | INTEGER | false | Foreign key to product variant | Specific product variant being replenished. |
| product_tmpl_id | INTEGER | false | Foreign key to product template | The base product definition. |
| product_uom_id | INTEGER | false | Foreign key to unit of measure | The measurement unit for the quantity. |
| warehouse_id | INTEGER | false | Foreign key to warehouse | The destination warehouse for the stock. |
| company_id | INTEGER | true | Foreign key to company | Multi-company context identifier. |
| create_uid | INTEGER | true | Foreign key to user | User who created the record. |
| write_uid | INTEGER | true | Foreign key to user | User who last modified the record. |
| product_has_variants | BOOLEAN | false | Variant flag | Indicates if the product has multiple variants. |
| date_planned | TIMESTAMP | false | Planned date | The scheduled date for the replenishment. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time in the source system. |
| write_date | TIMESTAMP | true | Modification timestamp | Last update time in the source system. |
| quantity | DOUBLE PRECISION | false | Replenishment quantity | The amount of product to be replenished. |
| bom_id | INTEGER | true | Foreign key to Bill of Materials | Used if replenishment is triggered by manufacturing. |
| supplier_id | INTEGER | true | Foreign key to supplier | The vendor responsible for the supply. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `product_id` → `product_product.id` (Standard Odoo product reference)
    - `warehouse_id` → `stock_warehouse.id` (Standard Odoo warehouse reference)
    - `supplier_id` → `res_partner.id` (Standard Odoo vendor reference)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments, but verify against the source system's `timezone` configuration.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows are active unless filtered by business logic.
- **Precision:** `quantity` is stored as `DOUBLE PRECISION`; ensure appropriate rounding is applied for financial or inventory reporting to avoid floating-point artifacts.
- **Audit:** `create_uid` and `write_uid` refer to the `res_users` table in the source system.