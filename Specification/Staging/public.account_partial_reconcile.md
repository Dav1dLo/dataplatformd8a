# account_partial_reconcile

## Source system
This table originates from Odoo (ERP), as evidenced by the naming convention (`account_partial_reconcile`), the use of `_id` suffixes for relational links, and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the accounting reconciliation process, specifically tracking partial payments or matches between debit and credit ledger entries. It is central to the "Order-to-Cash" and "Procure-to-Pay" cycles, where invoices are partially settled by payments or credit notes.

## Description
One row in this table represents a single partial reconciliation event linking a specific debit ledger entry to a credit ledger entry. It serves as a raw landed copy of the Odoo `account.partial.reconcile` model, capturing the financial amount matched and the associated currency details.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| debit_move_id | INTEGER | false | Foreign key to debit move | Links to `account_move_line`. |
| credit_move_id | INTEGER | false | Foreign key to credit move | Links to `account_move_line`. |
| full_reconcile_id | INTEGER | true | Foreign key to full reconcile | Links to `account_full_reconcile` if the match is completed. |
| exchange_move_id | INTEGER | true | Foreign key to exchange move | Links to `account_move` for currency gain/loss. |
| debit_currency_id | INTEGER | true | Foreign key to currency | Links to `res_currency`. |
| credit_currency_id | INTEGER | true | Foreign key to currency | Links to `res_currency`. |
| company_id | INTEGER | true | Foreign key to company | Links to `res_company`. |
| create_uid | INTEGER | true | Creator user ID | Links to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res_users`. |
| max_date | DATE | true | Latest transaction date | The date of the most recent move line involved. |
| amount | NUMERIC | true | Reconciliation amount | The amount in company currency. |
| debit_amount_currency | NUMERIC | true | Debit amount in foreign currency | Amount in the currency of the debit move. |
| credit_amount_currency | NUMERIC | true | Credit amount in foreign currency | Amount in the currency of the credit move. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `debit_move_id` → `account_move_line.id` (Standard Odoo ledger link)
    - `credit_move_id` → `account_move_line.id` (Standard Odoo ledger link)
    - `full_reconcile_id` → `account_full_reconcile.id` (Links to the parent reconciliation object)
    - `company_id` → `res_company.id` (Multi-company architecture)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** This table does not appear to implement soft deletes; records are typically immutable once created in the Odoo accounting module.
- **Precision:** `NUMERIC` types do not specify scale/precision in the metadata; assume standard accounting precision (e.g., `NUMERIC(16,2)`) but verify against source DDL if performing high-precision financial aggregations.
- **Data Integrity:** `full_reconcile_id` is nullable; a null value indicates the reconciliation remains "partial" and has not been fully cleared.