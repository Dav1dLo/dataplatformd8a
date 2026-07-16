# payment_method_payment_provider_rel

## Source system
Unknown — insufficient evidence. The table name suggests a junction table linking payment methods to payment providers, which is common in custom-built billing engines or ERP systems. There is no specific vendor naming convention (e.g., Stripe, Braintree) present in the schema or column names.

## Functional process 
This table supports the payment processing and billing configuration process. It acts as a bridge to define which payment providers (e.g., gateways like PayPal, Adyen, or Stripe) are authorized or configured to process specific payment methods (e.g., credit cards, bank transfers, digital wallets).

## Description
One row in this table represents a single association between a specific payment method and a payment provider. It serves as a raw landing copy of a many-to-many relationship mapping, ensuring that the downstream billing logic knows which provider to route transactions through for a given payment method.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_method_id | INTEGER | false | Surrogate key for the payment method | Foreign key reference to the payment_method table. |
| payment_provider_id | INTEGER | false | Surrogate key for the payment provider | Foreign key reference to the payment_provider table. |

## Keys

- **Primary key (inferred):** The composite of (`payment_method_id`, `payment_provider_id`).
- **Foreign keys (inferred):** 
    - `payment_method_id` → `payment_method.id`: Guessed based on the column name suffix.
    - `payment_provider_id` → `payment_provider.id`: Guessed based on the column name suffix.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a many-to-many relationship between the two entities.
- No audit or timestamp columns are present, so it is impossible to determine when these associations were created or if they are currently active without joining to parent tables.
- There are no sensitive PII columns in this table.