# account_bank_statement

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`account_bank_statement`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the sequence-based primary key pattern.

## Functional process 
This table supports the financial accounting and reconciliation process. It acts as a staging record for bank statements imported into the system, tracking the opening and closing balances of bank accounts to ensure that internal ledger entries reconcile with external bank activity.

## Description
One row represents a single bank statement header record, capturing the summary information for a specific period or transaction batch. It serves as a raw landing copy of the statement metadata, providing the starting and ending balances used to validate the integrity of bank transactions within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the legal entity owning the statement. |
| journal_id | INTEGER | true | Foreign key to the bank journal | Links the statement to the specific bank account journal. |
| create_uid | INTEGER | true | User ID who created the record | Reference to the system user who imported/created the statement. |
| write_uid | INTEGER | true | User ID who last modified the record | Reference to the system user who last updated the statement. |
| name | VARCHAR | true | Statement reference name | Often contains the bank statement number or internal identifier. |
| reference | VARCHAR | true | External reference | Additional descriptive text or bank-provided reference code. |
| first_line_index | VARCHAR | true | Index of the first statement line | Used for internal navigation or parsing of statement lines. |
| date | DATE | true | Statement date | The date associated with the bank statement period. |
| balance_start | NUMERIC | true | Opening balance | The starting balance of the bank account for this statement. |
| balance_end | NUMERIC | true | Computed ending balance | The expected ending balance based on statement lines. |
| balance_end_real | NUMERIC | true | Actual ending balance | The final balance as reported by the bank. |
| is_complete | BOOLEAN | true | Completion status flag | Indicates if the statement reconciliation is marked as complete. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp; timezone is typically UTC in Odoo. |
| write_date | TIMESTAMP | true | Record modification timestamp | Audit timestamp; timezone is typically UTC in Odoo. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `journal_id` → `account_journal.id` (Standard Odoo accounting module link).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Precision:** `NUMERIC` types do not specify scale/precision in the metadata; assume standard financial precision (e.g., 16,2) but verify against source DDL if performing exact balance calculations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
- **Completeness:** The `is_complete` flag should be used to filter for finalized statements when calculating financial reporting metrics.