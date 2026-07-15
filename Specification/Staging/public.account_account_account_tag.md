# account_account_account_tag

## Source system
The table likely originates from an Odoo or similar ERP/Accounting system, as indicated by the naming convention `account_account_account_tag`, which is characteristic of Odoo's relational mapping for many-to-many associations between accounts and their associated tags.

## Functional process 
This table supports the financial reporting and categorization process. It acts as a junction table to map specific general ledger accounts to one or more accounting tags, which are typically used for analytical accounting, tax reporting, or grouping accounts for financial statement presentation.

## Description
One row in this table represents a single association between a general ledger account and an accounting tag. It is a raw landing copy of a many-to-many relationship table, serving as the bridge to resolve account-to-tag mappings in downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_account_id | INTEGER | false | Foreign key to the account definition | Represents the specific ledger account. |
| account_account_tag_id | INTEGER | false | Foreign key to the tag definition | Represents the specific tag applied to the account. |

## Keys

- **Primary key (inferred):** The combination of `account_account_id` and `account_account_tag_id` is inferred as the composite primary key.
- **Foreign keys (inferred):** 
    - `account_account_id` → `account_account.id` (Inferred from naming convention).
    - `account_account_tag_id` → `account_account_tag.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a many-to-many relationship between accounts and tags.
- No audit timestamps or soft-delete flags are present; assume this table reflects the current state of associations as captured during the last ingestion.
- Ensure joins to parent tables handle potential missing records if referential integrity is not strictly enforced in the source system.