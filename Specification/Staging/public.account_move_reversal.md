# account_move_reversal

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `account_move_reversal` and the presence of `journal_id`, `company_id`, and `create_uid` are characteristic of Odoo's accounting module schema, which tracks the reversal of financial journal entries.

## Functional process 
This table supports the financial accounting and audit trail process, specifically the reversal of journal entries. It records the intent and metadata for reversing accounting moves, ensuring that corrections or cancellations of financial transactions are tracked for compliance and reporting purposes.

## Description
One row in this table represents a single reversal request or event linked to an accounting move. It serves as a raw landed copy of the Odoo staging data, capturing the business reason, the associated journal, and the audit timestamps for the reversal operation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_move_reversal_id_seq`. |
| journal_id | INTEGER | false | Foreign key to the accounting journal | Identifies which journal the reversal belongs to. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the legal entity associated with the reversal. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated the reversal. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the record. |
| reason | VARCHAR | true | Textual description of the reversal | Explains why the accounting move was reversed. |
| date | DATE | true | Effective date of the reversal | The accounting date assigned to the reversal entry. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp; timezone typically UTC in Odoo. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit timestamp; timezone typically UTC in Odoo. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `journal_id` → `account_journal.id` (Inferred from Odoo standard schema naming).
    - `company_id` → `res_company.id` (Inferred from Odoo standard schema naming).
    - `create_uid` → `res_users.id` (Inferred from Odoo standard schema naming).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard schema naming).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid` which link to user identity; ensure access is restricted if PII policies apply to user lists.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's internal storage standards.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Data Precision:** The `VARCHAR` type for `reason` does not specify a length; downstream consumers should handle variable-length strings appropriately.