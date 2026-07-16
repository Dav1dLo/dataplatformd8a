# pos_payment

## Source system
This table originates from an Odoo ERP system, indicated by the characteristic naming conventions such as `account_move_id`, `create_uid`, `write_uid`, and the use of `nextval` sequences for primary keys.

## Functional process 
This table supports the Point of Sale (POS) financial reconciliation process. It captures individual payment transactions linked to POS orders, tracking payment methods, card details, and transaction statuses to ensure accurate financial reporting and ledger integration via `account_move_id`.

## Description
One row represents a single payment transaction associated with a specific Point of Sale order. This table serves as a raw landed staging entity, providing a granular audit trail of all payment activities, including card processing details and transaction status, before they are reconciled into the general ledger.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `pos_payment_id_seq`. |
| pos_order_id | INTEGER | false | Foreign key to POS order | Links payment to the parent order. |
| payment_method_id | INTEGER | false | Payment method identifier | References the method used (e.g., cash, card). |
| session_id | INTEGER | true | POS session identifier | Groups payments by POS session. |
| company_id | INTEGER | true | Company identifier | Multi-company context. |
| account_move_id | INTEGER | true | Ledger entry identifier | Links to the accounting journal entry. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | true | Payment reference name | Often a human-readable transaction label. |
| card_type | VARCHAR | true | Type of card used | e.g., Credit, Debit. |
| card_brand | VARCHAR | true | Brand of card | e.g., Visa, Mastercard. |
| card_no | VARCHAR | true | Masked card number | Contains PII; handle with care. |
| cardholder_name | VARCHAR | true | Name on card | Contains PII. |
| payment_ref_no | VARCHAR | true | External reference number | Transaction reference from payment gateway. |
| payment_method_authcode | VARCHAR | true | Authorization code | Gateway auth code. |
| payment_method_issuer_bank | VARCHAR | true | Issuing bank name | Bank associated with the card. |
| payment_method_payment_mode | VARCHAR | true | Payment mode | Specific mode of payment processing. |
| transaction_id | VARCHAR | true | Unique transaction ID | Gateway-specific transaction identifier. |
| payment_status | VARCHAR | true | Status of payment | e.g., 'done', 'pending', 'cancelled'. |
| ticket | VARCHAR | true | Ticket reference | POS receipt reference. |
| uuid | VARCHAR | true | Global unique identifier | Used for synchronization. |
| amount | NUMERIC | false | Payment amount | Monetary value. |
| is_change | BOOLEAN | true | Change flag | Indicates if this record represents change returned. |
| payment_date | TIMESTAMP | false | Transaction timestamp | Date and time of the payment. |
| create_date | TIMESTAMP | true | Record creation timestamp | Ingestion/creation time. |
| write_date | TIMESTAMP | true | Last update timestamp | Last modification time. |
| employee_id | INTEGER | true | Employee identifier | The employee who processed the payment. |
| online_account_payment_id | INTEGER | true | Online payment reference | Links to external online payment records. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `pos_order_id` → `pos_order.id` (Standard Odoo relationship pattern).
    - `account_move_id` → `account_move.id` (Standard Odoo accounting relationship).
    - `payment_method_id` → `pos_payment_method.id` (Standard Odoo POS relationship).
- **Natural keys (inferred):** 
    - `uuid` (Used for system-wide synchronization).

## Caveats for downstream consumers

- **PII:** Columns `card_no` and `cardholder_name` contain sensitive customer information and should be masked or restricted.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are immutable once created or updated via standard Odoo `write` operations.
- **Precision:** `amount` is stored as `NUMERIC`; ensure downstream systems maintain this precision to avoid rounding errors in financial reporting.