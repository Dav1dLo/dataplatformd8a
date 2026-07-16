# stock_picking_sms_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the column names `confirm_stock_sms_id` and `stock_picking_id` is characteristic of Odoo's many-to-many relationship tables, which link SMS confirmation records to stock picking (inventory movement) events.

## Functional process 
This table supports the inventory management and notification pipeline. It tracks the association between specific stock picking operations (e.g., delivery orders or receipts) and the SMS notifications sent to stakeholders regarding the confirmation or status of those operations.

## Description
Each row represents a single link between a stock picking record and an SMS confirmation record. It serves as a junction table in the staging layer, maintaining the many-to-many relationship required to map multiple SMS notifications to multiple inventory movements.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| confirm_stock_sms_id | INTEGER | false | Foreign key to the SMS confirmation record. | Links to the primary key of the SMS notification table. |
| stock_picking_id | INTEGER | false | Foreign key to the stock picking record. | Links to the primary key of the stock picking table. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of `(confirm_stock_sms_id, stock_picking_id)`.
- **Foreign keys (inferred):** 
    - `confirm_stock_sms_id` → `confirm_stock_sms.id`: This column references the SMS notification entity.
    - `stock_picking_id` → `stock_picking.id`: This column references the inventory movement entity.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes other than the two foreign keys.
- There is no surrogate primary key provided; queries should likely use the combination of both columns to ensure uniqueness.
- As a staging table, this represents a raw snapshot of the relationship; verify if the source system performs hard deletes on these relationships or if they persist indefinitely.