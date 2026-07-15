# change_production_qty

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `mo_id`, `create_uid`, `write_uid`, `write_date`) and the use of standard Odoo sequence generators for the primary key are characteristic of Odoo's internal ORM-managed tables used for tracking manufacturing order adjustments.

## Functional process 
This table supports the manufacturing execution process, specifically tracking historical changes or adjustments made to the planned production quantities of Manufacturing Orders (MOs). It acts as an audit or change-log mechanism to ensure traceability when production targets are modified after an order has been initiated.

## Description
Each row represents a single modification event to the production quantity of a specific manufacturing order. As a staging table, it provides a raw, append-only record of these quantity changes, capturing the user responsible for the change and the timestamp of the update.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.change_production_qty_id_seq`. |
| mo_id | INTEGER | false | Foreign key to Manufacturing Order | Links to the parent production order being modified. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the change record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| product_qty | NUMERIC | false | Adjusted quantity | The new or modified quantity value for the production order. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp when the change record was first created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mo_id` → `mrp_production.id` (Inferred based on standard Odoo naming conventions for manufacturing order links).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may link to a separate `res_users` table containing PII.
- **Data Integrity:** This table appears to be an audit-style log; ensure queries handle potential duplicate `mo_id` entries if multiple changes were made to the same order over time.
- **Precision:** The `product_qty` column uses `NUMERIC` without defined scale/precision; verify if downstream systems require explicit casting to avoid rounding errors.