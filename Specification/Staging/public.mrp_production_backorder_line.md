# mrp_production_backorder_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mrp_production_backorder_line`), the use of `create_uid`/`write_uid` audit columns, and the standard PostgreSQL sequence pattern for the primary key.

## Functional process 
This table supports the manufacturing execution process, specifically tracking backordered items within production orders. It links specific production backorder headers to their corresponding production orders, determining whether individual lines should be processed as backorders (`to_backorder`).

## Description
Each row represents a single line item associated with a manufacturing backorder event. It serves as a raw landed copy of the Odoo `mrp.production.backorder.line` model, capturing the relationship between backorder headers and production orders at the time of creation or update.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mrp_production_backorder_line_id_seq`. |
| mrp_production_backorder_id | INTEGER | false | Foreign key to the backorder header | Links to the parent backorder record. |
| mrp_production_id | INTEGER | false | Foreign key to the production order | Identifies the specific manufacturing order involved. |
| create_uid | INTEGER | true | User ID who created the record | References the `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res.users` table. |
| to_backorder | BOOLEAN | true | Backorder status flag | Indicates if this line is marked for backordering. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mrp_production_backorder_id` → `mrp_production_backorder.id` (Inferred from naming convention).
    - `mrp_production_id` → `mrp_production.id` (Inferred from naming convention).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume records are hard-deleted if they disappear from the source.
- **Audit Columns:** `create_uid` and `write_uid` are internal Odoo identifiers and may not be meaningful without joining to the `res_users` table in the source system.
- **Data Integrity:** As a staging table, this data is raw; ensure downstream models handle potential nulls in `to_backorder` if the business logic requires a default state.