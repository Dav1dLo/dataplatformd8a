# account_payment_register

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `create_uid`, `write_date`, `partner_id`, `journal_id`) and the use of sequences for primary keys are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the "Accounts Receivable/Payable" and "Payment Processing" business processes. It acts as a transient wizard or registration object used to capture payment details (such as amount, currency, and journal) before they are committed to the accounting ledger as formal payment records.

## Description
One row in this table represents a single payment registration event or a configuration state for a payment wizard. It captures the intent to pay, including the associated partner, currency, and payment method, serving as a staging record before final accounting entry creation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| currency_id | INTEGER | true | Target currency identifier | Foreign key to currency table. |
| journal_id | INTEGER | true | Accounting journal identifier | Foreign key to account journal. |
| partner_bank_id | INTEGER | true | Partner bank account identifier | Foreign key to res.partner.bank. |
| custom_user_currency_id | INTEGER | true | User-defined currency override | Used for multi-currency manual adjustments. |
| source_currency_id | INTEGER | true | Original transaction currency | Used for cross-currency reconciliation. |
| company_id | INTEGER | true | Company identifier | Multi-company scope. |
| partner_id | INTEGER | true | Partner identifier | Foreign key to res.partner. |
| payment_method_line_id | INTEGER | true | Payment method line identifier | Defines the payment instrument/method. |
| writeoff_account_id | INTEGER | true | Write-off account identifier | Used for payment difference accounting. |
| create_uid | INTEGER | true | Creator user identifier | Foreign key to res.users. |
| write_uid | INTEGER | true | Last modifier user identifier | Foreign key to res.users. |
| communication | VARCHAR | true | Payment reference/memo | Free-text field for payment description. |
| installments_mode | VARCHAR | true | Installment configuration | Defines if payment is split. |
| payment_type | VARCHAR | true | Payment direction | e.g., 'inbound', 'outbound'. |
| partner_type | VARCHAR | true | Partner category | e.g., 'customer', 'supplier'. |
| payment_difference_handling | VARCHAR | true | Difference handling strategy | e.g., 'open', 'reconcile'. |
| writeoff_label | VARCHAR | true | Write-off description | Label for the accounting entry line. |
| payment_date | DATE | false | Transaction date | The effective date of the payment. |
| amount | NUMERIC | true | Payment amount | In the currency of the journal. |
| custom_user_amount | NUMERIC | true | Manual amount override | User-entered amount for custom scenarios. |
| source_amount | NUMERIC | true | Original source amount | Amount in the source currency. |
| source_amount_currency | NUMERIC | true | Source amount in currency | Denormalized source currency value. |
| group_payment | BOOLEAN | true | Grouping flag | Indicates if multiple invoices are paid together. |
| can_edit_wizard | BOOLEAN | true | UI permission flag | Indicates if the wizard is editable. |
| can_group_payments | BOOLEAN | true | UI permission flag | Indicates if grouping is allowed. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| payment_token_id | INTEGER | true | Payment token identifier | Reference to stored payment methods. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo partner link)
    - `journal_id` → `account_journal.id` (Standard Odoo accounting link)
    - `currency_id` → `res_currency.id` (Standard Odoo currency link)
    - `company_id` → `res_company.id` (Standard Odoo multi-company link)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `partner_id` and `communication` (memo) fields which may contain PII or sensitive business transaction details.
- **Timestamps:** `create_date` and `write_date` are stored in UTC, consistent with Odoo standard practices.
- **Data Lifecycle:** This table acts as a staging/wizard object; records may be transient and not represent finalized accounting entries.
- **Precision:** `NUMERIC` types do not have explicit scale/precision defined in the schema; assume standard accounting precision (e.g., 16, 2). Confirm against Odoo `ir.model.fields` if exact precision is required for financial reporting.