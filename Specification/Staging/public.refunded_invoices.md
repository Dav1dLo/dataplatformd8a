# refunded_invoices

## Source system
The table likely originates from an ERP or accounting system such as Odoo, given the specific terminology "account_move," which is the standard nomenclature for journal entries and invoice records in that ecosystem.

## Functional process 
This table supports the accounts receivable and credit management process. It tracks the relationship between original invoices and the subsequent credit notes or refund transactions issued against them, facilitating the reconciliation of financial records.

## Description
Each row represents a single link between an original invoice and its corresponding refund transaction. As a staging table, it provides a raw, one-to-one mapping of account move identifiers to ensure traceability between financial documents.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| refund_account_move | INTEGER | false | The unique identifier of the refund/credit note transaction. | Foreign key to the account_move table. |
| original_account_move | INTEGER | false | The unique identifier of the original invoice being refunded. | Foreign key to the account_move table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of both columns.
- **Foreign keys (inferred):** 
    - `refund_account_move` → `account_move.id`: Links to the transaction record representing the refund.
    - `original_account_move` → `account_move.id`: Links to the transaction record representing the original invoice.
- **Natural keys (inferred):** The combination of `(refund_account_move, original_account_move)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table contains no timestamps or audit metadata; it is a pure mapping table.
- There are no sensitive PII columns in this specific table.
- Ensure that joins to the `account_move` table are handled carefully, as `original_account_move` may appear multiple times if an invoice is partially refunded across different transactions.