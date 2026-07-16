# payment_currency_rel

## Source system
Unknown — insufficient evidence. The table name suggests a mapping or junction table, but the column names lack specific vendor prefixes (e.g., `stripe_`, `adyen_`) or unique identifiers that would link it to a specific third-party payment gateway or ERP system.

## Functional process 
This table supports the configuration of payment processing capabilities by defining which currencies are supported or enabled for specific payment providers. It acts as a bridge in a multi-currency payment architecture, ensuring that the system only attempts to process transactions in currencies supported by the selected provider.

## Description
One row in this table represents a single valid association between a payment provider and a currency. It is a raw landed junction table used to enforce business logic regarding payment method availability during the checkout or settlement process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_provider_id | INTEGER | false | Surrogate key for the payment provider | Foreign key to a provider dimension table. |
| currency_id | INTEGER | false | Surrogate key for the currency | Foreign key to a currency dimension table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`payment_provider_id`, `currency_id`).
- **Foreign keys (inferred):** 
    - `payment_provider_id` → `payment_providers.id` (guess: standard naming convention for provider entities).
    - `currency_id` → `currencies.id` (guess: standard naming convention for currency lookup tables).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction (many-to-many) entity; ensure joins are handled correctly to avoid row duplication in downstream models.
- No audit timestamps (e.g., `created_at`) are present, so incremental loading based on ingestion time is not possible without metadata from the source system.
- The table contains no soft-delete flags; assume the presence of a row indicates an active relationship.