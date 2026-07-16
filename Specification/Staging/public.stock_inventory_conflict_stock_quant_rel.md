# stock_inventory_conflict_stock_quant_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `stock_inventory_conflict_stock_quant_rel` follows the standard pattern for a many-to-many join table in Odoo, where `_rel` denotes a relationship table linking two primary entities: inventory conflict records and stock quantity records.

## Functional process 
This table supports the inventory reconciliation and stock management process. It maps specific stock quantity records (`stock_quant`) to inventory conflict events, likely used to track which specific inventory items were involved in a discrepancy or conflict during an audit or stock-take.

## Description
One row in this table represents a single association between an inventory conflict record and a stock quantity record. It serves as a raw landing copy of the join table, maintaining the many-to-many relationship between inventory conflicts and stock quants at the grain of the individual link.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_inventory_conflict_id | INTEGER | false | Foreign key to the inventory conflict record. | Links to the parent conflict event. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quantity record. | Links to the specific stock quant involved. |

## Keys

- **Primary key (inferred):** The combination of (`stock_inventory_conflict_id`, `stock_quant_id`) is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `stock_inventory_conflict_id` → `stock_inventory_conflict.id` (Inferred based on Odoo naming conventions).
    - `stock_quant_id` → `stock_quant.id` (Inferred based on Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume this table reflects the current state of relationships as captured during the last ingestion.
- Ensure that any joins to the parent tables handle the potential for orphaned records if referential integrity is not strictly enforced in the source system.