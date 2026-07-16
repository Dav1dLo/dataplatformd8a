# stock_picking_backorder_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` is characteristic of Odoo's automated many-to-many relationship tables, and the column names `stock_backorder_confirmation_id` and `stock_picking_id` align with Odoo's inventory management module (Stock) schema.

## Functional process 
This table supports the inventory fulfillment process, specifically managing backorders. It acts as a join table to associate backorder confirmation events with the specific stock picking operations that were split or deferred due to insufficient inventory.

## Description
One row in this table represents a single link between a backorder confirmation record and a stock picking operation. It serves as a raw landing copy of the many-to-many relationship table used to track which pickings are associated with which backorder confirmation in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_backorder_confirmation_id | INTEGER | false | Foreign key to the backorder confirmation record | Links to the parent confirmation event. |
| stock_picking_id | INTEGER | false | Foreign key to the stock picking record | Links to the specific picking operation involved. |

## Keys

- **Primary key (inferred):** The combination of `(stock_backorder_confirmation_id, stock_picking_id)` is the inferred primary key as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `stock_backorder_confirmation_id` → `stock_backorder_confirmation.id` (Inferred from naming convention).
    - `stock_picking_id` → `stock_picking.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a many-to-many relationship between backorder confirmations and stock pickings.
- There are no timestamps or audit columns present; this table represents the current state of the relationship as captured during the last ingestion.
- Ensure joins to parent tables handle potential missing records if the source system performs hard deletes on the parent entities.