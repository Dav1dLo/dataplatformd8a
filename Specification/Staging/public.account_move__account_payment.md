# account_move__account_payment

## Source system
This table originates from an Odoo ERP system. The naming convention `account_move__account_payment` is characteristic of Odoo's relational mapping, where a many-to-many relationship table is generated to link invoice records (`account.move`) to payment records (`account.payment`).

## Functional process 
This table supports the Accounts Receivable and Accounts Payable reconciliation process. It acts as a join table to track which specific payments have been applied to which invoices, facilitating the calculation of outstanding balances and the status of financial transactions.

## Description
One row in this table represents a single association between an invoice and a payment, indicating that a specific payment has been applied to a specific invoice. As a staging table, it provides a raw, normalized link between the two entities, intended for use in downstream financial reporting and ledger reconciliation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| invoice_id | INTEGER | false | Foreign key to the invoice record | References the primary key of the `account_move` table. |
| payment_id | INTEGER | false | Foreign key to the payment record | References the primary key of the `account_payment` table. |

## Keys

- **Primary key (inferred):** The combination of (`invoice_id`, `payment_id`) forms the composite primary key.
- **Foreign keys (inferred):** 
    - `invoice_id` → `account_move.id`: Links the payment association to the specific invoice document.
    - `payment_id` → `account_payment.id`: Links the invoice association to the specific payment transaction.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table represents a many-to-many relationship; expect multiple rows per `invoice_id` if an invoice is paid in installments, or multiple rows per `payment_id` if a single payment covers multiple invoices.
- There are no timestamps or audit columns present; this table reflects the current state of the link as captured during the last ingestion.
- Ensure that joins to `account_move` and `account_payment` are handled as inner joins if you only require validated transaction links.