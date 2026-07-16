# stock_replenishment_info

## Source system
This table originates from an Odoo ERP system. The naming convention (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the inventory replenishment process, specifically tracking the metadata and audit trail for stock order points. It links configuration settings that trigger automated procurement or manufacturing orders when stock levels fall below defined thresholds.

## Description
One row in this table represents the audit and administrative metadata for a specific stock order point configuration. It serves as a raw landing copy of the Odoo `stock.warehouse.orderpoint` (or related) audit fields, capturing who created or modified the replenishment rule and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `public.stock_replenishment_info_id_seq`. |
| orderpoint_id | INTEGER | true | Foreign key to the order point definition | Links to the specific replenishment rule configuration. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time (usually UTC). |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time (usually UTC). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `orderpoint_id` → `stock_orderpoint.id` (Guess: links to the primary replenishment rule definition).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the server's local time; verify if the Odoo instance is configured for UTC (standard practice).
- **Audit Fields:** `create_uid` and `write_uid` are internal Odoo user IDs; they do not contain human-readable names without joining to the `res_users` table.
- **Data Completeness:** As a staging table, this may contain historical versions or partial updates depending on the ingestion pipeline's logic.
- **Sensitivity:** No PII is present, but internal user IDs should be handled with standard access controls.