# mrp_workcenter_capacity

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `mrp_workcenter_capacity` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the Manufacturing Resource Planning (MRP) process, specifically defining the production capacity of specific work centers for given products. It is used to calculate scheduling constraints and throughput limits within the production floor management module.

## Description
One row in this table represents a specific capacity configuration for a product assigned to a work center. It serves as a raw landed copy of the Odoo `mrp.workcenter.capacity` model, capturing the time constraints and throughput capacity for manufacturing operations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mrp_workcenter_capacity_id_seq`. |
| workcenter_id | INTEGER | false | Foreign key to the work center | Links to the `mrp_workcenter` table. |
| product_id | INTEGER | false | Foreign key to the product | Links to the `product_product` table. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users`. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed based on Odoo standards. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed based on Odoo standards. |
| capacity | DOUBLE PRECISION | true | Production capacity | Units depend on configuration (e.g., units per hour). |
| time_start | DOUBLE PRECISION | true | Start time offset | Likely represented in hours or minutes. |
| time_stop | DOUBLE PRECISION | true | Stop time offset | Likely represented in hours or minutes. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id` (Standard Odoo naming convention for work center relations).
    - `product_id` → `product_product.id` (Standard Odoo naming convention for product relations).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Types:** `DOUBLE PRECISION` is used for capacity and time fields; ensure downstream casting handles potential floating-point precision issues if performing exact arithmetic.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Audit Columns:** `create_uid` and `write_uid` may be null if the record was created via a system process rather than a user action.