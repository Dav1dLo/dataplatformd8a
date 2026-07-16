# stock_conflict_quant_rel

## Source system
The table likely originates from an Odoo ERP system or a similar modular inventory management platform. The naming convention `stock_conflict_quant_rel` is characteristic of a many-to-many join table used to link inventory conflict records with specific stock quant (quantity) records.

## Functional process 
This table supports the inventory reconciliation and conflict resolution process. It maps specific stock quantity records (`stock_quant_id`) that are currently flagged or involved in an inventory discrepancy or conflict (`stock_inventory_conflict_id`), allowing the system to track which specific inventory units are affected by a reported stock issue.

## Description
Each row represents a single association between an inventory conflict event and a specific stock quantity record. As a staging table, it serves as a raw landed copy of the join relationship, intended to be used for reconstructing the link between inventory discrepancies and the underlying stock data.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_inventory_conflict_id | INTEGER | false | Foreign key to the inventory conflict header record. | Links to the parent conflict entity. |
| stock_quant_id | INTEGER | false | Foreign key to the specific stock quantity record. | Identifies the specific quant involved in the conflict. |

## Keys

- **Primary key (inferred):** The combination of (`stock_inventory_conflict_id`, `stock_quant_id`) is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `stock_inventory_conflict_id` → `stock_inventory_conflict.id`: This column references the primary identifier of the conflict event.
    - `stock_quant_id` → `stock_quant.id`: This column references the primary identifier of the stock quantity record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; rely on the parent tables for temporal context.
- Ensure that joins to this table are performed on both columns to maintain the integrity of the many-to-many relationship.