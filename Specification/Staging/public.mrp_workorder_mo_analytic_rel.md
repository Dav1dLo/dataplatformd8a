# mrp_workorder_mo_analytic_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the naming convention `mrp_workorder` (Manufacturing Resource Planning) and `account_analytic_line` (Accounting/Costing module). The `_rel` suffix is a standard Odoo pattern for many-to-many join tables.

## Functional process 
This table supports the cost-tracking and manufacturing accounting process. It links specific manufacturing work orders to their corresponding analytic accounting lines, allowing the business to attribute labor or machine costs incurred during production to specific analytic accounts (e.g., projects, departments, or cost centers).

## Description
One row represents a single association between a manufacturing work order and an analytic accounting line. It serves as a raw junction table in the staging layer, enabling the mapping of production activities to financial cost records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_workorder_id | INTEGER | false | Foreign key to the manufacturing work order | Links to the production activity record. |
| account_analytic_line_id | INTEGER | false | Foreign key to the analytic accounting line | Links to the financial cost/revenue record. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite primary key consisting of both columns.
- **Foreign keys (inferred):**
    - `mrp_workorder_id` → `mrp_workorder.id`: Based on the standard Odoo naming convention for foreign keys.
    - `account_analytic_line_id` → `account_analytic_line.id`: Based on the standard Odoo naming convention for foreign keys.
- **Natural keys (inferred):** The combination of `(mrp_workorder_id, account_analytic_line_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no other columns (like timestamps or status flags) to be present.
- There are no sensitive PII columns in this table.
- Ensure that joins to the parent tables (`mrp_workorder` and `account_analytic_line`) handle potential orphans if referential integrity is not strictly enforced in the source system.