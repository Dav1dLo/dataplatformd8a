# account_analytic_line_stock_move_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `account_analytic_line_stock_move_rel` is characteristic of Odoo's many-to-many relationship tables, which link analytic accounting entries to inventory movement records.

## Functional process 
This table supports the cost accounting and inventory valuation process. It bridges the gap between physical stock movements (inventory) and analytic accounting lines, allowing the system to attribute the financial impact of specific stock operations to analytic accounts (e.g., projects, departments, or cost centers).

## Description
One row in this table represents a single association between an inventory stock movement and an analytic accounting line. It serves as a raw junction table in the staging layer, facilitating the join between the inventory management module and the analytic accounting module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_move_id | INTEGER | false | Foreign key to the stock move record | Links to the inventory movement. |
| account_analytic_line_id | INTEGER | false | Foreign key to the analytic line record | Links to the analytic accounting entry. |

## Keys

- **Primary key (inferred):** The combination of `(stock_move_id, account_analytic_line_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `stock_move_id` → `stock_move.id`: This column references the primary key of the inventory stock movement table.
    - `account_analytic_line_id` → `account_analytic_line.id`: This column references the primary key of the analytic accounting lines table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship between two entities.
- Ensure that joins to this table are performed on both columns to maintain referential integrity, as neither column is unique on its own.
- As a staging table, this reflects the raw state of the Odoo database; verify if the source system performs hard or soft deletes on these relationships before building incremental logic.