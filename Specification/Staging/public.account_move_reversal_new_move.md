# account_move_reversal_new_move

## Source system
This table likely originates from an Odoo ERP system. The naming convention `account_move_reversal` is a standard pattern in Odoo's accounting module, which tracks the relationship between original journal entries and their corresponding reversal entries.

## Functional process 
This table supports the accounting reconciliation and audit trail process. It maps a reversal journal entry to the specific new journal entry created to offset or correct a previous financial transaction, ensuring that the ledger remains balanced and traceable.

## Description
Each row represents a link between a reversal record and the resulting new journal entry. It serves as a raw landing table in the staging layer, capturing the relationship between two accounting movements to maintain a clear audit trail of financial corrections.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| reversal_id | INTEGER | false | Foreign key to the reversal record | Links to the primary account move reversal entity. |
| new_move_id | INTEGER | false | Foreign key to the new journal entry | The identifier of the newly created journal entry that performs the reversal. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of `(reversal_id, new_move_id)`.
- **Foreign keys (inferred):** 
    - `reversal_id` → `account_move_reversal.id` (Guess: links to the parent reversal definition).
    - `new_move_id` → `account_move.id` (Guess: links to the actual journal entry record).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; expect many-to-many or one-to-many relationships depending on the ERP configuration.
- No audit timestamps (e.g., `created_at`) are present; rely on the source system's transaction logs for temporal analysis.
- The table contains only integer identifiers; join with the relevant `account_move` tables to retrieve human-readable financial data.