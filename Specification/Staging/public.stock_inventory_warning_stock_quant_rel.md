# stock_inventory_warning_stock_quant_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `stock_inventory_warning` and `stock_quant` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link inventory warning records to specific stock quant (quantity) records.

## Functional process 
This table supports the inventory management and replenishment process. It acts as a join table that associates specific inventory warning alerts with the underlying stock quant records that triggered or are relevant to those warnings, facilitating visibility into which specific stock batches or locations are causing inventory threshold violations.

## Description
One row in this table represents a single association between an inventory warning record and a stock quantity record. As a staging layer table, it provides a raw, normalized link between these two entities, allowing downstream models to reconstruct the relationship between alerts and physical stock levels.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_inventory_warning_id | INTEGER | false | Foreign key to the inventory warning record. | Links to the parent warning entity. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant record. | Links to the specific stock quantity/batch record. |

## Keys

- **Primary key (inferred):** Not confidently inferable. This table likely uses a composite primary key consisting of both columns `(stock_inventory_warning_id, stock_quant_id)`.
- **Foreign keys (inferred):** 
    - `stock_inventory_warning_id` → `stock_inventory_warning.id`: This column references the primary key of the inventory warning table.
    - `stock_quant_id` → `stock_quant.id`: This column references the primary key of the stock quant table.
- **Natural keys (inferred):** The combination of `(stock_inventory_warning_id, stock_quant_id)` acts as the natural key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes other than the foreign keys.
- There are no timestamps or soft-delete flags present; the existence of a row implies an active relationship in the source system.
- Ensure that joins to the parent tables handle potential orphans if the source system's referential integrity is not strictly enforced at the database level.