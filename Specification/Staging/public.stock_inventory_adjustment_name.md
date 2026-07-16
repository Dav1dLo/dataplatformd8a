# stock_inventory_adjustment_name

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence-based default for the `id` column, is characteristic of the Odoo ORM framework.

## Functional process 
This table supports the inventory management process, specifically tracking descriptive labels or naming conventions applied to inventory adjustments. It likely serves as a lookup or configuration table to categorize or identify specific stock adjustment events within the warehouse management module.

## Description
Each row represents a unique inventory adjustment name or category definition used to label stock reconciliation activities. This is a raw landed staging table, providing a direct copy of the configuration data from the source system for downstream transformation into analytical dimensions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_inventory_adjustment_name_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| inventory_adjustment_name | VARCHAR | true | Descriptive name of the adjustment | The business-facing label for the adjustment type. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** 
    - `inventory_adjustment_name` (assuming the name is unique within the business context).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are recorded in the source system's time zone; verify if this is UTC or local server time before performing time-series analysis.
- **Audit Columns:** `create_uid` and `write_uid` are system-level identifiers and may not be present in the target data warehouse if the `res_users` table is not synchronized.
- **Data Quality:** As a staging table, this may contain legacy or deprecated adjustment names; check for nulls in `inventory_adjustment_name` before using it as a join key.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all records are current unless otherwise specified by the source system's business logic.