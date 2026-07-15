# lot_label_layout_stock_move_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link two primary entities—in this case, label layouts and stock move lines—within the inventory management module.

## Functional process 
This table supports the inventory labeling and logistics process. It facilitates a many-to-many relationship between specific label layout configurations and the individual stock move lines (the granular records of items moving into, out of, or within a warehouse), ensuring that the correct label format is associated with the correct inventory movement.

## Description
One row represents a single association between a specific label layout configuration and a stock move line. This is a junction table used to resolve a many-to-many relationship, serving as a raw landed copy of the Odoo relational link for downstream staging and transformation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| lot_label_layout_id | INTEGER | false | Foreign key to the label layout definition | References the layout configuration used for printing. |
| stock_move_line_id | INTEGER | false | Foreign key to the stock move line | References the specific inventory movement record. |

## Keys

- **Primary key (inferred):** Not confidently inferable. This table likely uses a composite primary key consisting of both `lot_label_layout_id` and `stock_move_line_id`.
- **Foreign keys (inferred):** 
    - `lot_label_layout_id` → `lot_label_layout.id` (Guess: standard Odoo naming convention for relational links).
    - `stock_move_line_id` → `stock_move_line.id` (Guess: standard Odoo naming convention for relational links).
- **Natural keys (inferred):** The combination of `(lot_label_layout_id, stock_move_line_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table contains no timestamps or audit columns; it is a pure relational bridge.
- There are no sensitive PII columns in this table.
- As a junction table, it should be joined to the parent entities to provide context for the labels being generated.
- Expect high cardinality if the system generates many labels per stock movement.