# account_reconcile_model_line_account_tax_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific association of `account_reconcile_model_line` and `account_tax` is characteristic of Odoo's many-to-many relationship tables, which are used to link reconciliation model lines to applicable tax definitions.

## Functional process 
This table supports the automated bank reconciliation process. It defines the many-to-many relationship between reconciliation model lines (which dictate how bank statement lines are processed) and the specific taxes that should be applied to those transactions during the reconciliation workflow.

## Description
One row represents a single association between a specific reconciliation model line and a tax record. It acts as a join table to enable multiple taxes to be linked to a single reconciliation model line, ensuring that the correct tax logic is applied during financial statement matching.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_reconcile_model_line_id | INTEGER | false | Foreign key to the reconciliation model line | Links to the parent configuration line. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Identifies the specific tax to be applied. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both `account_reconcile_model_line_id` and `account_tax_id`.
- **Foreign keys (inferred):** 
    - `account_reconcile_model_line_id` → `account_reconcile_model_line.id` (Guess: standard Odoo naming convention for M2M relations).
    - `account_tax_id` → `account_tax.id` (Guess: standard Odoo naming convention for M2M relations).
- **Natural keys (inferred):** The combination of `(account_reconcile_model_line_id, account_tax_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table.
- Ensure that joins to the parent tables handle the potential for missing records if the source system has performed partial deletions or if referential integrity is not strictly enforced at the database level.
- This table is strictly for mapping; it does not contain the tax rates or model line logic itself.