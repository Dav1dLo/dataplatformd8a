# account_invoice_transaction_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular accounting system. The naming convention `_rel` is a standard pattern in Odoo for join tables that manage many-to-many relationships between core entities like invoices and payment transactions.

## Functional process 
This table supports the reconciliation process within the accounts receivable or accounts payable pipeline. It maps individual financial transactions (such as payments or credit memos) to the specific invoices they settle, ensuring that the ledger accurately reflects which payments have been applied to which outstanding balances.

## Description
This table acts as a link entity representing the many-to-many relationship between invoices and transactions. Each row represents a single association between one invoice and one transaction. As a staging table, it provides a raw, un-transformed view of the link records as they exist in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| invoice_id | INTEGER | false | Foreign key to the invoice record | Represents the unique identifier of the invoice being settled. |
| transaction_id | INTEGER | false | Foreign key to the transaction record | Represents the unique identifier of the payment or credit transaction. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(invoice_id, transaction_id)`.
- **Foreign keys (inferred):** 
    - `invoice_id` → `public.invoice.id` (Inferred based on standard naming conventions for invoice entities).
    - `transaction_id` → `public.transaction.id` (Inferred based on standard naming conventions for transaction entities).
- **Natural keys (inferred):** The combination of `(invoice_id, transaction_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table contains no timestamps or audit metadata; it is a pure join table.
- There are no sensitive PII columns in this table, as it only contains surrogate keys.
- Ensure that joins to this table are handled carefully to avoid fan-out if a transaction is associated with multiple invoices or vice versa.
- The table is strictly a mapping; it does not contain the actual amounts or dates associated with the invoice or transaction.