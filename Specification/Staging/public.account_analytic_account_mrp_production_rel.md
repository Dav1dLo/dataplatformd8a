# account_analytic_account_mrp_production_rel

## Source system
This table originates from an Odoo ERP environment, as indicated by the naming convention `account_analytic_account_mrp_production_rel`, which follows the standard Odoo pattern for many-to-many relationship tables linking analytic accounts to manufacturing production orders.

## Functional process 
This table supports the Cost Accounting and Manufacturing integration process. It maps manufacturing production orders to specific analytic accounts, allowing the business to track production costs (materials, labor, overhead) against specific projects, departments, or cost centers defined in the analytic accounting module.

## Description
This table represents a join entity that establishes a many-to-many relationship between analytic accounts and manufacturing production orders. Each row signifies that a specific production order is associated with a specific analytic account for financial reporting purposes. It serves as a raw landing copy of the link table from the source ERP database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_analytic_account_id | INTEGER | false | Foreign key to the analytic account | Links to the primary key of the analytic account table. |
| mrp_production_id | INTEGER | false | Foreign key to the manufacturing production order | Links to the primary key of the MRP production table. |

## Keys

- **Primary key (inferred):** The combination of `(account_analytic_account_id, mrp_production_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `account_analytic_account_id` → `account_analytic_account.id`: This column references the analytic account entity.
    - `mrp_production_id` → `mrp_production.id`: This column references the manufacturing production order entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect many-to-many cardinality between the two parent entities.
- There are no timestamps or audit columns present in this table; it represents the current state of the relationship as captured during the last ingestion.
- Ensure joins to parent tables handle potential missing records if the source system allows orphaned references in the link table.