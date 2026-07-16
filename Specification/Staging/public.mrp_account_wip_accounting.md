# mrp_account_wip_accounting

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `mrp_account_wip_accounting`, the use of `create_uid`/`write_uid` audit columns, and the `nextval` sequence pattern typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the manufacturing accounting process, specifically tracking Work-in-Progress (WIP) accounting entries. It links manufacturing journal entries to specific dates and references, facilitating the reconciliation of production costs against the general ledger.

## Description
One row in this table represents a single WIP accounting record associated with a manufacturing journal entry. It serves as a raw landed copy of the Odoo `mrp.account.wip.accounting` model, capturing the audit trail and temporal attributes of WIP adjustments.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mrp_account_wip_accounting_id_seq`. |
| journal_id | INTEGER | false | Foreign key to the journal | Links to the accounting journal entry. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| reference | VARCHAR | true | Transaction reference | External or internal document reference string. |
| date | DATE | true | Accounting date | The date the WIP entry is effective for accounting. |
| reversal_date | DATE | false | Reversal date | The date on which this entry is scheduled to be reversed. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `journal_id` → `account_journal.id` (Guess: Standard Odoo pattern for linking accounting records to journals).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit column pattern).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit column pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against `res_users` to resolve names, potentially exposing internal employee information.
- **Data Integrity:** `reference` is nullable; queries relying on this for business logic should handle potential nulls.
- **Soft Deletes:** Odoo typically uses hard deletes for this model; however, verify if the source system has custom archival logic.