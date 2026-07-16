# stock_move_move_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `table_name_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link two related entities within the inventory or manufacturing modules.

## Functional process 
This table supports the inventory traceability and supply chain process. It maps the relationship between source stock moves and destination stock moves, effectively tracking the lineage of goods as they move through various warehouse locations or production stages (e.g., linking a procurement move to a delivery move).

## Description
Each row represents a single directed relationship between two stock move records. It acts as a join table to establish the dependency or sequence between an originating stock move and a destination stock move. As a staging table, it provides a raw, normalized view of these associations as they exist in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| move_orig_id | INTEGER | false | Foreign key to the originating stock move | References the parent move in the chain. |
| move_dest_id | INTEGER | false | Foreign key to the destination stock move | References the child move in the chain. |

## Keys

- **Primary key (inferred):** The combination of `move_orig_id` and `move_dest_id` forms the composite primary key.
- **Foreign keys (inferred):**
    - `move_orig_id` → `stock_move.id`: This column represents the source side of the inventory movement relationship.
    - `move_dest_id` → `stock_move.id`: This column represents the destination side of the inventory movement relationship.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume this table reflects the current state of relationships as captured during the last ingestion.
- Ensure that joins to the `stock_move` table are handled carefully to avoid fan-outs, as one move may have multiple origins or destinations depending on the business logic.