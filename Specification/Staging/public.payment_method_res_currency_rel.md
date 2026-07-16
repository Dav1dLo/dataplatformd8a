# payment_method_res_currency_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables (join tables) between two entities, in this case, payment methods and currencies.

## Functional process 
This table supports the configuration of payment gateways and their supported currencies. It defines which currencies are valid for processing transactions through specific payment methods, ensuring that a payment method is only offered to a user if it supports the currency of their transaction.

## Description
Each row represents a single valid association between a payment method and a currency. It acts as a junction table in the staging layer, providing a raw mapping of supported currency-to-payment-method combinations as defined in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_method_id | INTEGER | false | Foreign key to the payment method definition | Maps to the primary key of the payment methods table. |
| res_currency_id | INTEGER | false | Foreign key to the currency definition | Maps to the primary key of the currencies table. |

## Keys

- **Primary key (inferred):** The composite key `(payment_method_id, res_currency_id)` is the inferred primary key.
- **Foreign keys (inferred):** 
    - `payment_method_id → payment_method.id`: This column references the payment method entity.
    - `res_currency_id → res_currency.id`: This column references the currency entity (Odoo standard naming for currency is `res_currency`).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a join table; expect no non-key attributes.
- There are no timestamps or audit columns present; it is impossible to determine the history of these associations from this table alone.
- Ensure inner joins are used when filtering by both payment method and currency to avoid cartesian products.