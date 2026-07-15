# account_move_mrp_production_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `account_move_mrp_production_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link accounting entries (`account_move`) to manufacturing production orders (`mrp_production`).

## Functional process 
This table supports the manufacturing-to-finance integration process. It tracks the association between specific manufacturing production orders and the corresponding accounting journal entries generated during the production lifecycle, such as the consumption of raw materials or the valuation of finished goods.

## Description
One row in this table represents a single link between an accounting move and a manufacturing production order. It serves as a raw junction table in the staging layer, enabling the reconstruction of relationships between financial records and production activities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_id | INTEGER | false | Foreign key to the accounting move record | References the primary key of the `account_move` table. |
| mrp_production_id | INTEGER | false | Foreign key to the manufacturing production record | References the primary key of the `mrp_production` table. |

## Keys

- **Primary key (inferred):** The combination of `(account_move_id, mrp_production_id)` is the composite primary key for this relationship table.
- **Foreign keys (inferred):** 
    - `account_move_id` → `account_move.id`: Links to the financial transaction record.
    - `mrp_production_id` → `mrp_production.id`: Links to the manufacturing order record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no attributes other than the two foreign keys.
- There are no timestamps or audit columns present in this table; rely on the parent tables for creation or modification dates.
- Ensure that joins to this table are performed on both columns to maintain the integrity of the many-to-many relationship.