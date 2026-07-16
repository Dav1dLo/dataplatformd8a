# stock_move_line_consume_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular inventory management system. The naming convention `_rel` is characteristic of Odoo's ORM-generated join tables used to manage many-to-many relationships between stock move lines, specifically linking consumption records to production records.

## Functional process 
This table supports the inventory manufacturing and consumption process. It tracks the relationship between raw material consumption (stock move lines) and the resulting production output (stock move lines), ensuring traceability between components used and finished goods produced.

## Description
Each row represents a single link between a consumption stock move line and a production stock move line. It serves as a raw junction table in the staging layer, mapping the many-to-many dependency between input materials and output products within a manufacturing order.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| consume_line_id | INTEGER | false | Foreign key to the stock move line representing the consumed material. | Maps to the source system's stock move line ID. |
| produce_line_id | INTEGER | false | Foreign key to the stock move line representing the produced item. | Maps to the source system's stock move line ID. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`consume_line_id`, `produce_line_id`).
- **Foreign keys (inferred):** 
    - `consume_line_id` → `stock_move_line.id`: Links to the specific inventory movement record for the consumed component.
    - `produce_line_id` → `stock_move_line.id`: Links to the specific inventory movement record for the produced item.
- **Natural keys (inferred):** The combination of (`consume_line_id`, `produce_line_id`) acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes other than the two foreign keys.
- There are no timestamps or audit columns; rely on the parent `stock_move_line` table for temporal context.
- Ensure joins to `stock_move_line` are handled carefully, as a single consumption line may be associated with multiple production lines and vice versa.