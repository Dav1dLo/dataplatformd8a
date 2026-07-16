# stock_inventory_adjustment_name_stock_quant_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `stock_inventory_adjustment` and `stock_quant` is characteristic of Odoo's automated many-to-many relationship tables generated for ORM models.

## Functional process 
This table supports the inventory management and stock reconciliation process. It acts as a join table linking specific stock quantity records (`stock_quant`) to inventory adjustment events, allowing the system to track which physical stock units were affected by a particular inventory adjustment session.

## Description
One row represents a single association between an inventory adjustment record and a specific stock quantity record. It serves as a raw landing copy of the many-to-many relationship table, used to resolve the link between adjustment sessions and the underlying stock quant entities in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| "stock_inventory_adjustment_name_id" | INTEGER | false | Foreign key to the inventory adjustment record | Links to the parent adjustment session. |
| "stock_quant_id" | INTEGER | false | Foreign key to the stock quant record | Links to the specific stock quantity entity. |

## Keys

- **Primary key (inferred):** The composite of ("stock_inventory_adjustment_name_id", "stock_quant_id").
- **Foreign keys (inferred):** 
    - "stock_inventory_adjustment_name_id" → "stock_inventory_adjustment_name".id (Inferred from Odoo naming convention).
    - "stock_quant_id" → "stock_quant".id (Inferred from Odoo naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; rely on the parent tables for temporal context.
- Ensure inner joins are used when traversing this relationship to avoid orphaned records if referential integrity is not strictly enforced at the source.