# account_account_account_journal_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `account_account_account_journal_rel` is a standard pattern used by the Odoo ORM to represent a many-to-many relationship table between the `account.account` (General Ledger accounts) and `account.journal` (Accounting Journals) models.

## Functional process 
This table supports the configuration of accounting journals, specifically defining which General Ledger accounts are permitted or linked to specific journals. This is a critical component of the financial accounting module, ensuring that journal entries are restricted to valid, pre-configured accounts.

## Description
One row in this table represents a single association between a specific General Ledger account and an accounting journal. It serves as a raw, junction table in the staging layer, facilitating the many-to-many relationship required for journal-account validation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_account_id | INTEGER | false | Foreign key to the account.account table | Represents the GL account identifier. |
| account_journal_id | INTEGER | false | Foreign key to the account.journal table | Represents the accounting journal identifier. |

## Keys

- **Primary key (inferred):** The composite of (`account_account_id`, `account_journal_id`).
- **Foreign keys (inferred):** 
    - `account_account_id` → `account_account.id`: Links to the master list of GL accounts.
    - `account_journal_id` → `account_journal.id`: Links to the master list of accounting journals.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure that joins to the parent tables handle the potential for orphaned records if the source system's referential integrity is not strictly enforced at the database level.