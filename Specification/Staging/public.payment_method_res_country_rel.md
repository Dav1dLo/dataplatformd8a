# payment_method_res_country_rel

## Source system
The table likely originates from an Odoo ERP system, as indicated by the `res_country` naming convention, which is standard for Odoo's partner and country management modules. The `_rel` suffix is characteristic of Odoo's auto-generated many-to-many join tables.

## Functional process 
This table supports the configuration of payment method availability by country. It defines which payment methods are permitted or enabled for transactions originating from specific geographic regions, ensuring compliance with regional financial regulations or service provider availability.

## Description
Each row represents a single association between a specific payment method and a country. It serves as a raw landing copy of a many-to-many relationship table, used to resolve which payment options are valid for a given customer's country of residence.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_method_id | INTEGER | false | Foreign key to the payment method definition | Links to the primary payment method registry. |
| res_country_id | INTEGER | false | Foreign key to the country definition | Links to the standard Odoo country table. |

## Keys

- **Primary key (inferred):** The combination of `(payment_method_id, res_country_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `payment_method_id` → `payment_method.id` (Inferred from standard Odoo naming conventions).
    - `res_country_id` → `res_country.id` (Inferred from standard Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when a relationship was created or modified from this table alone.
- As a staging table, it should be joined against the corresponding master tables (`payment_method` and `res_country`) to retrieve human-readable names or codes.