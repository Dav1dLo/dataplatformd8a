# stock_move_created_purchase_line_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` is characteristic of Odoo's many-to-many relationship tables, and the column names `move_id` and `purchase_line_id` align with the standard Odoo schema for linking inventory stock moves to purchase order lines.

## Functional process 
This table supports the procurement-to-inventory pipeline. It maintains the traceability link between specific inventory stock movements (e.g., goods received) and the corresponding purchase order lines that authorized the procurement, ensuring that inventory levels are correctly reconciled against purchase commitments.

## Description
Each row represents a single association between an inventory stock move and a purchase order line. It serves as a raw, junction-table copy in the staging layer, facilitating the resolution of many-to-many relationships between procurement records and warehouse logistics.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| created_purchase_line_id | INTEGER | false | Foreign key to the purchase order line | Links to the source purchase order line record. |
| move_id | INTEGER | false | Foreign key to the stock move | Links to the specific inventory movement record. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`created_purchase_line_id`, `move_id`).
- **Foreign keys (inferred):**
    - `created_purchase_line_id` → `purchase_order_line.id`: This column references the line item detail of a purchase order.
    - `move_id` → `stock_move.id`: This column references the specific inventory transaction record.
- **Natural keys (inferred):** The combination of (`created_purchase_line_id`, `move_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; rely on the parent tables (`stock_move` or `purchase_order_line`) for temporal context.
- Ensure inner joins are used when traversing these relationships to avoid orphaned records if referential integrity is not strictly enforced at the source.