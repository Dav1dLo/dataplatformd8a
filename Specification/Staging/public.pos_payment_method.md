# pos_payment_method

## Source system
This table originates from Odoo ERP, indicated by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for localized fields (like `name`). The structure is typical of Odoo's Point of Sale (PoS) module configuration tables.

## Functional process 
This table supports the Point of Sale configuration and payment processing pipeline. It defines the various payment methods (e.g., cash, bank, terminal, QR code) available at a PoS terminal, linking them to specific accounting journals and receivable accounts to ensure financial transactions are correctly recorded in the general ledger.

## Description
One row in this table represents a single payment method configuration available for use within the Point of Sale system. It acts as a raw landing copy of the Odoo `pos.payment.method` model, capturing the operational settings, accounting mappings, and terminal integration status for each method.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order | Used for UI sorting in the PoS interface. |
| outstanding_account_id | INTEGER | true | Accounting account for outstanding payments | Foreign key to account.account. |
| receivable_account_id | INTEGER | true | Accounting account for receivables | Foreign key to account.account. |
| journal_id | INTEGER | true | Linked accounting journal | Foreign key to account.journal. |
| company_id | INTEGER | true | Owning company ID | Foreign key to res.company. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to res.users. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to res.users. |
| use_payment_terminal | VARCHAR | true | Integrated terminal provider | e.g., 'adyen', 'stripe'. |
| payment_method_type | VARCHAR | false | Category of payment method | e.g., 'cash', 'bank', 'pay_later'. |
| qr_code_method | VARCHAR | true | QR code provider identifier | Used if payment method supports QR. |
| name | JSONB | false | Localized display name | Contains translations for the payment method. |
| is_cash_count | BOOLEAN | true | Requires cash counting | Flag for cash-based methods. |
| split_transactions | BOOLEAN | true | Supports split payments | Whether the method allows partial payments. |
| active | BOOLEAN | true | Soft-delete flag | If false, the method is hidden from the UI. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| is_online_payment | BOOLEAN | true | Online payment flag | Indicates if processed via web gateway. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `journal_id` → `account_journal.id` (Links to the accounting journal used for this method)
    - `company_id` → `res_company.id` (Links to the multi-company entity)
    - `create_uid` / `write_uid` → `res_users.id` (Links to the system users who managed this record)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but `name` (JSONB) may contain internal business logic or localized strings.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column is used for soft deletes; queries should generally filter by `WHERE active = TRUE`.
- **JSONB:** The `name` column requires extraction (e.g., `name->>'en_US'`) to be used in standard reporting.