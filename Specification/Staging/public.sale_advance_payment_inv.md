# sale_advance_payment_inv

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`sale_advance_payment_inv`), the use of `create_uid`/`write_uid` for audit tracking, and the sequence-based default value for the `id` column.

## Functional process 
This table supports the sales order-to-invoice pipeline, specifically managing the configuration and parameters for advance payments (down payments) on sales orders. It captures how a user has configured the invoicing of an advance payment, such as whether to use a fixed amount or a percentage, and whether to consolidate billing.

## Description
One row in this table represents a specific configuration or request instance for an advance payment invoice associated with a sales process. It serves as a raw landing record in the staging layer, capturing the parameters selected by a user during the "Create Invoice" wizard in the sales module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sale_advance_payment_inv_id_seq`. |
| currency_id | INTEGER | true | Foreign key to currency | Links to the currency used for the advance payment. |
| company_id | INTEGER | true | Foreign key to company | Identifies the organizational entity. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| advance_payment_method | VARCHAR | false | Payment method type | Defines the strategy (e.g., 'fixed', 'percentage'). |
| fixed_amount | NUMERIC | true | Fixed payment amount | The specific monetary value if method is fixed. |
| deduct_down_payments | BOOLEAN | true | Deduction flag | Indicates if previous down payments should be deducted. |
| consolidated_billing | BOOLEAN | true | Consolidation flag | Indicates if multiple orders should be billed together. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the application layer. |
| amount | DOUBLE PRECISION | true | Payment amount | The calculated or input amount for the advance. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id` (Standard Odoo naming convention for currency references).
    - `company_id` → `res_company.id` (Standard Odoo naming convention for multi-company architecture).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments, but should be verified against the source server configuration.
- **Data Sensitivity:** Contains `create_uid` and `write_uid` which link to user records; ensure access controls are applied if user identity is sensitive.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column), which is common in other Odoo tables; assume all records are active unless otherwise specified by business logic.
- **Precision:** `fixed_amount` is `NUMERIC` (arbitrary precision), while `amount` is `DOUBLE PRECISION` (floating point). Use `NUMERIC` for financial calculations to avoid rounding errors.