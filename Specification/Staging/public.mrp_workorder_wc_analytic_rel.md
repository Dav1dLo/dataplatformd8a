# mrp_workorder_wc_analytic_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the naming convention `mrp_workorder` (Manufacturing Resource Planning) and `account_analytic_line` (Analytical Accounting), which are standard modules within the Odoo framework.

## Functional process 
This table supports the manufacturing cost-tracking process by linking specific work orders to their corresponding analytical accounting lines. It enables the allocation of labor, machine, or overhead costs incurred during production to specific analytical accounts for project or department-level financial reporting.

## Description
One row in this table represents a many-to-many relationship link between a manufacturing work order and an analytical accounting line. It serves as a raw junction table in the staging layer, facilitating the association of production activities with financial cost records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_workorder_id | INTEGER | false | Foreign key to the manufacturing work order | Links to the primary key of the `mrp_workorder` table. |
| account_analytic_line_id | INTEGER | false | Foreign key to the analytical accounting line | Links to the primary key of the `account_analytic_line` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of `(mrp_workorder_id, account_analytic_line_id)`.
- **Foreign keys (inferred):** 
    - `mrp_workorder_id` → `mrp_workorder.id`: Links the record to the specific manufacturing work order.
    - `account_analytic_line_id` → `account_analytic_line.id`: Links the record to the specific financial analytical line.
- **Natural keys (inferred):** The combination of `mrp_workorder_id` and `account_analytic_line_id` acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; ensure joins to parent tables are handled carefully to avoid fan-out if multiple analytical lines are associated with a single work order.
- No audit timestamps (e.g., `created_at`) are present in this table; rely on the parent tables for temporal context.
- The table does not contain soft-delete flags; assume records are removed if the relationship is severed in the source system.