# account_payment_account_bank_statement_line_rel

## Source system
The table likely originates from an Odoo ERP system. The naming convention `_rel` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link records between two distinct business objects: bank statement lines and payment records.

## Functional process 
This table supports the bank reconciliation process within the financial accounting module. It maps individual bank statement lines (representing incoming or outgoing cash movements) to specific payment records, ensuring that ledger entries are correctly reconciled against actual bank transactions.

## Description
One row in this table represents a single link between a bank statement line and a payment record. It acts as a join table to facilitate a many-to-many relationship between the `account_bank_statement_line` and `account_payment` entities. As a staging table, it provides a raw, un-transformed view of these associations as they exist in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_bank_statement_line_id | INTEGER | false | Foreign key to the bank statement line record. | Links to the primary key of the bank statement line table. |
| account_payment_id | INTEGER | false | Foreign key to the payment record. | Links to the primary key of the payment table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both `account_bank_statement_line_id` and `account_payment_id`.
- **Foreign keys (inferred):** 
    - `account_bank_statement_line_id` → `account_bank_statement_line.id`: Evidence is the column name suffix matching the target table.
    - `account_payment_id` → `account_payment.id`: Evidence is the column name suffix matching the target table.
- **Natural keys (inferred):** The combination of `(account_bank_statement_line_id, account_payment_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table contains no PII or sensitive financial values directly, but it is critical for auditing the reconciliation of payments.
- There are no timestamps or soft-delete flags present; this table represents the current state of the relationship as defined in the source.
- As a join table, it should be used to bridge queries between the payment and bank statement line entities; ensure inner joins are used if you only require fully reconciled records.