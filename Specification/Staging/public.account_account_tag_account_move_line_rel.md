# account_account_tag_account_move_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific association between `account_move_line` (general ledger entries) and `account_account_tag` (analytical or reporting tags) is characteristic of Odoo's many-to-many relationship join tables.

## Functional process 
This table supports the financial reporting and analytical accounting process. It maps specific general ledger line items to reporting tags, allowing users to categorize transactions for tax reporting, budget tracking, or custom financial analysis without altering the core ledger structure.

## Description
One row in this table represents a single association between a specific general ledger line item and a reporting tag. It serves as a raw junction table in the staging layer to resolve a many-to-many relationship between accounting moves and account tags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_line_id | INTEGER | false | Foreign key to the account move line | Links to the specific ledger entry. |
| account_account_tag_id | INTEGER | false | Foreign key to the account tag | Links to the specific reporting tag definition. |

## Keys

- **Primary key (inferred):** The composite key `(account_move_line_id, account_account_tag_id)`.
- **Foreign keys (inferred):** 
    - `account_move_line_id` → `account_move_line.id`: This column references the primary key of the ledger entry table.
    - `account_account_tag_id` → `account_account_tag.id`: This column references the primary key of the accounting tag definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this table between `account_move_line` and `account_account_tag` to retrieve meaningful business data.
- There are no timestamps or soft-delete flags; this table reflects the current state of associations as captured during the last ingestion.
- Ensure that joins are performed on both columns to maintain referential integrity, as neither column is unique in isolation.