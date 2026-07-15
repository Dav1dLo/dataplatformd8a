# account_cash_rounding

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for relational fields (common in Odoo's PostgreSQL implementation for multi-company or translated fields), and the specific sequence-based primary key pattern.

## Functional process 
This table supports the financial accounting and invoicing process by defining how cash payments should be rounded when the currency's smallest unit is larger than the transaction's precision. It dictates the mathematical strategy (e.g., rounding up, down, or half-up) and identifies the specific general ledger accounts used to record the resulting profit or loss from these rounding adjustments.

## Description
One row represents a single cash rounding configuration rule defined within the accounting module. It acts as a raw landed copy of the Odoo configuration entity, capturing the rounding precision, the method applied, and the associated accounting impact.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res.users`. |
| strategy | VARCHAR | false | The mathematical rounding strategy | e.g., 'add_invoice_line', 'biggest_tax'. |
| rounding_method | VARCHAR | false | The rounding direction method | e.g., 'HALF-UP', 'UP', 'DOWN'. |
| name | JSONB | false | Display name of the rounding rule | Likely contains multi-language labels. |
| profit_account_id | JSONB | true | GL account for rounding profit | Stored as JSONB; likely contains ID and name. |
| loss_account_id | JSONB | true | GL account for rounding loss | Stored as JSONB; likely contains ID and name. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record last modification timestamp | UTC assumed. |
| rounding | DOUBLE PRECISION | false | The rounding precision value | The increment to which amounts are rounded. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Data Type:** The `JSONB` columns (`name`, `profit_account_id`, `loss_account_id`) require extraction (e.g., `->> 'id'`) to be used in joins or filters.
- **Timestamps:** Timestamps are stored in the database's native format; verify if the source Odoo instance is configured for UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
- **Precision:** The `rounding` column is a `DOUBLE PRECISION` float; use caution when performing exact equality comparisons due to floating-point arithmetic.