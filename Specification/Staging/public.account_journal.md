# account_journal

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `create_uid`, `write_uid`, `JSONB` for translatable fields, and specific account-related foreign keys) is characteristic of the Odoo framework's accounting module.

## Functional process 
This table supports the General Ledger and financial reporting processes. It defines the journals (e.g., Sales, Purchase, Bank, Cash) used to categorize accounting entries, manage sequence numbering for invoices/payments, and map specific accounts for suspense, profit, and loss handling.

## Description
One row represents a single accounting journal configuration within the Odoo system. It acts as a raw landed copy of the journal definition, providing the structural settings and account mappings required to process financial transactions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| alias_id | INTEGER | true | Link to email alias | Used for incoming mail integration. |
| default_account_id | INTEGER | true | Default GL account | Used for journal entries. |
| suspense_account_id | INTEGER | true | Suspense GL account | Used for bank reconciliation. |
| sequence | INTEGER | true | Display order | UI sorting index. |
| currency_id | INTEGER | true | Journal currency | Foreign key to currency table. |
| company_id | INTEGER | false | Owning company | Multi-company context. |
| profit_account_id | INTEGER | true | Profit GL account | Used for exchange rate gains. |
| loss_account_id | INTEGER | true | Loss GL account | Used for exchange rate losses. |
| bank_account_id | INTEGER | true | Linked bank account | Foreign key to bank account. |
| create_uid | INTEGER | true | Creator user ID | Audit trail. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail. |
| color | INTEGER | true | UI color index | Used for dashboard styling. |
| access_token | VARCHAR | true | Security token | Used for external access. |
| code | VARCHAR(5) | false | Journal short code | Business identifier (e.g., 'INV'). |
| type | VARCHAR | false | Journal type | e.g., 'sale', 'purchase', 'bank'. |
| invoice_reference_type | VARCHAR | false | Reference format | Logic for invoice numbering. |
| invoice_reference_model | VARCHAR | false | Reference model | Logic for invoice numbering. |
| bank_statements_source | VARCHAR | true | Import source | e.g., 'file_import', 'online_sync'. |
| name | JSONB | false | Journal name | Multilingual field. |
| sequence_override_regex | TEXT | true | Sequence regex | Pattern for custom numbering. |
| active | BOOLEAN | true | Soft-delete flag | True if journal is enabled. |
| autocheck_on_post | BOOLEAN | true | Validation toggle | Auto-check during posting. |
| restrict_mode_hash_table | BOOLEAN | true | Integrity flag | Used for legal audit compliance. |
| refund_sequence | BOOLEAN | true | Refund sequence flag | Use separate sequence for refunds. |
| payment_sequence | BOOLEAN | true | Payment sequence flag | Use separate sequence for payments. |
| show_on_dashboard | BOOLEAN | true | Dashboard visibility | Toggle for UI display. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company link)
    - `currency_id` → `res_currency.id` (Standard Odoo currency link)
    - `bank_account_id` → `res_partner_bank.id` (Links to bank account details)
- **Natural keys (inferred):** 
    - `code` (Unique short code per company)

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `access_token` should be treated as a credential and masked.
- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = true` unless historical analysis is required.
- **JSONB:** The `name` column is a `JSONB` object; use `name->>'en_US'` or similar syntax to extract specific language values.