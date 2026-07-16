# mrp_production_mrp_production_backorder_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `mrp_production_mrp_production_backorder_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link the Manufacturing Order (`mrp_production`) to its associated backorder records.

## Functional process 
This table supports the manufacturing execution and inventory management process. It maintains the link between primary manufacturing orders and the backorders generated when production is split or partially fulfilled, ensuring traceability of production requirements across multiple fulfillment cycles.

## Description
One row in this table represents a single association between a manufacturing order and a specific backorder record. It serves as a raw junction table in the staging layer, facilitating the resolution of many-to-many relationships between production entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_production_backorder_id | INTEGER | false | Foreign key to the backorder record | Links to the primary key of the backorder table. |
| mrp_production_id | INTEGER | false | Foreign key to the manufacturing order | Links to the primary key of the production table. |

## Keys

- **Primary key (inferred):** The composite of (`mrp_production_backorder_id`, `mrp_production_id`).
- **Foreign keys (inferred):** 
    - `mrp_production_backorder_id` → `mrp_production_backorder.id` (Inferred from Odoo naming conventions).
    - `mrp_production_id` → `mrp_production.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship identifiers.
- There are no timestamps or audit columns present in this table; rely on the parent tables for creation or modification context.
- Ensure inner joins are used when resolving these relationships to avoid orphaned records if referential integrity is not enforced at the database level.