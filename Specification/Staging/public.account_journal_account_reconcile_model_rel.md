# account_journal_account_reconcile_model_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `account_journal` and `account_reconcile_model` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link journals to reconciliation models.

## Functional process 
This table supports the automated bank and cash reconciliation process. It defines which reconciliation models (rules for matching payments to invoices or statements) are available for use within specific accounting journals, ensuring that only relevant matching logic is presented to users during the reconciliation workflow.

## Description
One row represents a single association between a specific accounting journal and a reconciliation model. This is a junction table used to resolve a many-to-many relationship between the two entities. It serves as a raw landed copy of the Odoo database schema in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_reconcile_model_id | INTEGER | false | Foreign key to the reconciliation model definition. | Links to the primary key of the reconciliation model table. |
| account_journal_id | INTEGER | false | Foreign key to the accounting journal definition. | Links to the primary key of the journal table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of `(account_reconcile_model_id, account_journal_id)`.
- **Foreign keys (inferred):** 
    - `account_reconcile_model_id` → `account_reconcile_model.id`: This column references the specific reconciliation rule configuration.
    - `account_journal_id` → `account_journal.id`: This column references the specific journal (e.g., Bank, Cash) where the rule is applied.
- **Natural keys (inferred):** The combination of `(account_reconcile_model_id, account_journal_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table contains no surrogate primary key; ensure your join logic accounts for the composite nature of the relationship.
- As a junction table, it contains no business data other than the foreign key references.
- There are no timestamps or soft-delete flags; this table reflects the current state of the relationship as defined in the source system.