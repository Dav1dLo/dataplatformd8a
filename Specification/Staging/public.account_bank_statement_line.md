# account_bank_statement_line

## Source system
This table originates from Odoo (ERP), as evidenced by the naming convention (`account_bank_statement_line`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of `JSONB` for transaction details, which is characteristic of Odoo's PostgreSQL-based architecture.

## Functional process 
This table supports the financial reconciliation and cash management process. It records individual line items from bank statements imported into the ERP, linking them to accounting entries (`move_id`), business partners (`partner_id`), and specific bank journals (`journal_id`) to ensure that bank balances match internal ledger records.

## Description
One row represents a single transaction line extracted from a bank statement or electronic payment feed. It serves as a raw staging entity that captures the details of incoming or outgoing cash movements before they are fully reconciled against accounting journal entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| move_id | INTEGER | false | Foreign key to account move | Links to the accounting journal entry. |
| journal_id | INTEGER | false | Foreign key to bank journal | Identifies the bank account/journal. |
| company_id | INTEGER | false | Foreign key to company | Multi-company context identifier. |
| statement_id | INTEGER | true | Foreign key to bank statement | Links to the parent statement header. |
| sequence | INTEGER | true | Display order sequence | Used for UI sorting. |
| partner_id | INTEGER | true | Foreign key to partner | The customer or vendor involved. |
| currency_id | INTEGER | true | Foreign key to currency | The currency of the statement line. |
| foreign_currency_id | INTEGER | true | Foreign key to currency | Used if transaction is in a non-base currency. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| account_number | VARCHAR | true | Counterparty account number | IBAN or local account identifier. |
| partner_name | VARCHAR | true | Counterparty name | Raw name provided by the bank. |
| transaction_type | VARCHAR | true | Bank transaction code | Type of transaction (e.g., credit, debit). |
| payment_ref | VARCHAR | true | Payment reference | Memo or description from the bank. |
| internal_index | VARCHAR | true | Internal matching index | Used for automated reconciliation. |
| transaction_details | JSONB | true | Raw transaction metadata | Contains unstructured bank-specific data. |
| amount | NUMERIC | true | Transaction amount | In the currency of the journal. |
| amount_currency | NUMERIC | true | Amount in foreign currency | Value in the transaction's original currency. |
| is_reconciled | BOOLEAN | true | Reconciliation status | Flag indicating if matched to a move line. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| amount_residual | DOUBLE PRECISION | true | Remaining amount to reconcile | Used for partial reconciliation. |
| pos_session_id | INTEGER | true | Foreign key to POS session | Links to Point of Sale activity. |
| employee_id | INTEGER | true | Foreign key to employee | Links to specific staff if applicable. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `move_id` → `account_move.id` (Standard Odoo accounting link)
    - `journal_id` → `account_journal.id` (Links to the bank journal definition)
    - `company_id` → `res_company.id` (Standard Odoo multi-company link)
    - `partner_id` → `res_partner.id` (Links to the business entity)
- **Natural keys (inferred):** Not confidently inferable; likely relies on a combination of `statement_id` and `sequence` or a bank-provided transaction ID within `transaction_details`.

## Caveats for downstream consumers

- **Sensitive Data:** The `account_number` and `partner_name` columns contain PII/financial data and should be masked in non-production environments.
- **Timestamps:** `create_date` and `write_date` are stored in UTC as per standard Odoo/PostgreSQL practice.
- **Data Integrity:** `amount` and `amount_currency` are `NUMERIC` types; ensure downstream systems handle decimal precision correctly to avoid rounding errors.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` flag; assume standard CRUD operations.
- **JSONB:** The `transaction_details` column is semi-structured; queries extracting data from this column will require PostgreSQL `->>` or `->` operators.