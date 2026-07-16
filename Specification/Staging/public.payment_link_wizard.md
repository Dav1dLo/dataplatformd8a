# payment_link_wizard

## Source system
The table originates from an Odoo ERP system. The naming convention (`res_id`, `res_model`, `create_uid`, `write_uid`) and the use of `nextval` sequences for primary keys are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the "Payment Link Generation" business process, which allows users to create ad-hoc payment requests for specific business objects (e.g., invoices or sales orders). It tracks the configuration of these links, including currency, target amounts, and eligibility for early payment discounts.

## Description
One row in this table represents a single configuration instance of a payment link wizard session. It acts as a staging record for the parameters used to generate a payment URL for a specific record in the system. This table serves as a raw landed copy of the wizard's state before the payment link is finalized or processed.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| res_id | INTEGER | false | ID of the related business object | References the record being paid. |
| currency_id | INTEGER | true | Foreign key to currency | Links to the currency definition. |
| partner_id | INTEGER | true | Foreign key to partner | The customer or vendor associated with the link. |
| create_uid | INTEGER | true | Creator user ID | References the system user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | References the system user who last updated the wizard. |
| res_model | VARCHAR | false | Model name of the related object | e.g., 'account.move' or 'sale.order'. |
| amount | NUMERIC | false | Target payment amount | The amount requested via the link. |
| amount_max | NUMERIC | true | Maximum allowed payment amount | Used for partial payment limits. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |
| discount_date | DATE | true | Early payment discount deadline | Date threshold for discount eligibility. |
| open_installments | JSONB | true | Installment schedule details | Stores structured data for payment plans. |
| has_eligible_epd | BOOLEAN | true | Early payment discount flag | Indicates if the link qualifies for a discount. |
| amount_paid | NUMERIC | true | Amount already settled | Tracks partial payments against the link. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id` (Guess: standard Odoo currency reference)
    - `partner_id` → `res_partner.id` (Guess: standard Odoo partner reference)
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference)
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `partner_id` and potentially sensitive financial amounts; ensure access is restricted to authorized financial reporting roles.
- **Timestamps:** All `create_date` and `write_date` fields are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are permanent unless otherwise specified by the source application logic.
- **JSONB:** The `open_installments` column contains nested data; downstream consumers should use PostgreSQL JSONB operators (e.g., `->>`) to extract specific fields.