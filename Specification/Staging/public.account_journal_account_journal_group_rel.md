# account_journal_account_journal_group_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `model_a_model_b_rel` is the standard pattern used by the Odoo ORM to manage many-to-many relationship tables in the underlying PostgreSQL database.

## Functional process 
This table supports the configuration of financial reporting structures by mapping individual journals to specific journal groups. It enables the grouping of journals for consolidated reporting, dashboard filtering, and access control within the accounting module.

## Description
One row in this table represents a single association between an account journal and an account journal group. It serves as a raw, junction table in the staging layer, facilitating the many-to-many relationship required to categorize journals into logical sets.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_journal_group_id | INTEGER | false | Foreign key to the account journal group definition. | Links to the parent group entity. |
| account_journal_id | INTEGER | false | Foreign key to the specific account journal. | Links to the child journal entity. |

## Keys

- **Primary key (inferred):** The composite key `(account_journal_group_id, account_journal_id)`.
- **Foreign keys (inferred):** 
    - `account_journal_group_id` → `account_journal_group.id`: This column references the primary key of the journal group definition table.
    - `account_journal_id` → `account_journal.id`: This column references the primary key of the account journal table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure that joins to the target tables handle potential orphans if referential integrity is not strictly enforced at the database level in the source system.