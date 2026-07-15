# account_move_account_resequence_wizard_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific business entities `account_resequence_wizard` and `account_move` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link wizard sessions to specific accounting journal entries.

## Functional process 
This table supports the "Journal Entry Resequencing" process. It acts as a join table that tracks which specific accounting moves (`account_move`) are currently being processed or resequenced by a specific instance of the resequence wizard (`account_resequence_wizard`).

## Description
One row in this table represents a single association between a resequence wizard session and an accounting move. It is a raw landed copy of an Odoo many-to-many join table, used to maintain the relationship state during the resequencing operation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_resequence_wizard_id | INTEGER | false | Foreign key to the resequence wizard instance. | Links to the wizard session configuration. |
| account_move_id | INTEGER | false | Foreign key to the accounting move. | Identifies the specific journal entry being resequenced. |

## Keys

- **Primary key (inferred):** Not confidently inferable. Odoo many-to-many tables often lack a surrogate primary key, relying on a composite unique index on both columns.
- **Foreign keys (inferred):** 
    - `account_resequence_wizard_id` → `account_resequence_wizard.id`: This column links to the wizard session that manages the resequencing logic.
    - `account_move_id` → `account_move.id`: This column links to the specific journal entry record being processed.
- **Natural keys (inferred):** The combination of `(account_resequence_wizard_id, account_move_id)` is the natural key for this relationship.

## Caveats for downstream consumers

- This table is a join table; it contains no business data other than the relationship between the two entities.
- There are no timestamps or audit columns present in this table.
- As a staging table for a transient wizard process, this data may be ephemeral and cleared by the source system once the resequencing operation is completed.
- No PII is present in this table.