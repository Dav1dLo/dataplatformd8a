# account_payment_term_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`account_payment_term_line`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value for the `id` column.

## Functional process 
This table supports the Accounts Receivable/Payable configuration process, specifically defining the breakdown of payment terms. It dictates how a total invoice amount is split into multiple installments or due dates (e.g., "30% due in 15 days, 70% due at end of month").

## Description
Each row represents a single line item within a payment term definition, specifying a portion of an invoice amount and the timing for its payment. As a staging table, it serves as a raw, direct reflection of the Odoo `account.payment.term.line` model, capturing the logic used to calculate payment deadlines.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_payment_term_line_id_seq`. |
| nb_days | INTEGER | true | Number of days for the payment term | Used when `delay_type` is 'days'. |
| payment_id | INTEGER | false | Foreign key to the parent payment term | Links to `account_payment_term`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users`. |
| value | VARCHAR | false | Type of value calculation | e.g., 'percent', 'fixed', 'balance'. |
| delay_type | VARCHAR | false | Method of calculating the due date | e.g., 'days', 'days_after_end_of_month'. |
| days_next_month | VARCHAR(2) | true | Day of the month for payment | Used for end-of-month calculations. |
| value_amount | NUMERIC | true | The amount or percentage value | Represents a ratio or fixed currency amount. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `payment_id` → `account_payment_term.id`: This column links the line item to its parent payment term definition.
    - `create_uid` → `res_users.id`: Standard Odoo audit field for record creation.
    - `write_uid` → `res_users.id`: Standard Odoo audit field for record modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Sensitivity:** Contains no PII or sensitive financial data, though it reflects internal business logic for payment terms.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely hard-deleted if removed in the source system.
- **Precision:** `value_amount` is defined as `NUMERIC` without explicit scale/precision; downstream consumers should cast to `NUMERIC(16, 4)` or similar to ensure financial accuracy.