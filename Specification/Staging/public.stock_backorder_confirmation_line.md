# stock_backorder_confirmation_line

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_date`, `picking_id`) and the use of sequence-based primary keys are characteristic of Odoo's ORM layer, which manages inventory picking and backorder workflows.

## Functional process 
This table supports the inventory management and order fulfillment process, specifically tracking the confirmation of backordered items during the picking process. It records whether specific picking operations should generate a backorder when stock is insufficient to fulfill the original request.

## Description
One row in this table represents a single line item within a backorder confirmation event, linking a specific picking operation to a backorder decision. As a staging table, it serves as a raw, landed copy of the Odoo `stock.backorder.confirmation.line` model, capturing the state of backorder flags at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `public.stock_backorder_confirmation_line_id_seq`. |
| backorder_confirmation_id | INTEGER | true | Foreign key to the parent confirmation record | Links to the header record for the backorder confirmation. |
| picking_id | INTEGER | true | Foreign key to the stock picking record | Identifies the specific picking operation being confirmed. |
| create_uid | INTEGER | true | User ID who created the record | References the `res.users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res.users` table. |
| to_backorder | BOOLEAN | true | Backorder decision flag | If true, indicates a backorder should be created for this picking. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `backorder_confirmation_id` → `stock_backorder_confirmation.id` (Inferred from Odoo naming patterns).
    - `picking_id` → `stock_picking.id` (Inferred from Odoo naming patterns).
    - `create_uid` → `res_users.id` (Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically managed via Odoo's internal lifecycle.
- **Data Integrity:** As a staging table, `backorder_confirmation_id` and `picking_id` may contain orphaned references if the parent records were purged or failed to land in the staging layer.
- **PII:** No direct PII is present, though `create_uid` and `write_uid` link to user metadata which may be considered sensitive in some contexts.