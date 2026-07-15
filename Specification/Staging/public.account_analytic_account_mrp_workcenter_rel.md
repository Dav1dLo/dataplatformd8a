# account_analytic_account_mrp_workcenter_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `account_analytic_account_mrp_workcenter_rel` is a standard pattern used by Odoo's ORM to represent a many-to-many relationship table (often referred to as a "relation" or "link" table) between analytic accounts and manufacturing work centers.

## Functional process 
This table supports the Cost Accounting and Manufacturing integration process. It maps analytic accounts (used for cost tracking and project accounting) to specific manufacturing work centers, allowing costs incurred at a work center to be allocated to the appropriate analytic account for financial reporting and project profitability analysis.

## Description
This table represents a many-to-many association between analytic accounts and manufacturing work centers. Each row defines a link between one analytic account and one work center, enabling the system to associate manufacturing activities with specific cost centers. It serves as a raw landing copy of the join table from the source ERP database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_analytic_account_id | INTEGER | false | Foreign key to the analytic account | Links to the primary key of the analytic account table. |
| mrp_workcenter_id | INTEGER | false | Foreign key to the MRP work center | Links to the primary key of the MRP work center table. |

## Keys

- **Primary key (inferred):** The combination of `(account_analytic_account_id, mrp_workcenter_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `account_analytic_account_id` → `account_analytic_account.id`: This column references the analytic account entity.
    - `mrp_workcenter_id` → `mrp_workcenter.id`: This column references the manufacturing work center entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes or timestamps.
- There are no sensitive columns (PII) present in this table.
- As a join table, it does not implement soft deletes; records are typically inserted or deleted directly by the application logic.
- Ensure that joins to this table are performed on both columns to maintain referential integrity with the parent entities.