# stock_orderpoint_snooze_stock_warehouse_orderpoint_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `stock_orderpoint_snooze_..._rel` is characteristic of Odoo's automated many-to-many relationship tables, which link a snooze configuration (used to temporarily disable replenishment triggers) to specific warehouse order points (reordering rules).

## Functional process 
This table supports the inventory replenishment and procurement process. It manages the association between "snooze" events—where a user has opted to temporarily ignore or delay a stock reordering rule—and the specific `stock.warehouse.orderpoint` records that define minimum and maximum stock levels for products in specific locations.

## Description
Each row represents a single link between a snooze configuration record and a warehouse order point record. It acts as a join table in a many-to-many relationship, allowing multiple order points to be associated with a single snooze event, or vice versa. This is a raw landed copy of the Odoo relational mapping table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_orderpoint_snooze_id | INTEGER | false | Foreign key to the snooze configuration record | Links to the parent snooze event. |
| stock_warehouse_orderpoint_id | INTEGER | false | Foreign key to the warehouse order point record | Links to the specific reordering rule being snoozed. |

## Keys

- **Primary key (inferred):** The combination of `stock_orderpoint_snooze_id` and `stock_warehouse_orderpoint_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `stock_orderpoint_snooze_id` → `stock_orderpoint_snooze.id` (Inferred from Odoo naming convention).
    - `stock_warehouse_orderpoint_id` → `stock_warehouse_orderpoint.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no business data other than the relationship identifiers.
- There are no timestamps or soft-delete flags present; the existence of a row implies an active relationship.
- Ensure that joins to the parent tables handle the potential for orphaned records if the source system's referential integrity is not strictly enforced at the database level.