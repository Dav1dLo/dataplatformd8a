# account_account_account_merge_wizard_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pattern of linking a wizard ID to an account ID is characteristic of Odoo's many-to-many relationship tables generated for transient data management during record merging operations.

## Functional process 
This table supports the "Account Merge" business process, which allows users to consolidate duplicate financial or customer accounts into a single master record. It tracks the association between a specific merge wizard session and the individual account records selected for that merge operation.

## Description
One row in this table represents a single link between a merge wizard session and an account record involved in that session. It serves as a raw, junction-table copy from the source system, capturing the state of accounts queued for merging before the final consolidation is committed.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_merge_wizard_id | INTEGER | false | Foreign key to the merge wizard session | Links to the parent wizard record. |
| account_account_id | INTEGER | false | Foreign key to the account record | The specific account being merged. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(account_merge_wizard_id, account_account_id)`.
- **Foreign keys (inferred):** 
    - `account_merge_wizard_id` → `account_merge_wizard.id` (Guess: links to the wizard session header).
    - `account_account_id` → `account_account.id` (Guess: links to the master account table).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; expect many-to-many relationships between wizards and accounts.
- No audit timestamps are present in this table; rely on the parent `account_merge_wizard` table for creation/modification context.
- This table contains transient data; rows may be deleted or truncated by the source system once the merge wizard session is completed or closed.