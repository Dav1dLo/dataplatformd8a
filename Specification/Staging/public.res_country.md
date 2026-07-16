# res_country

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`res_country`, `create_uid`, `write_uid`, `res_country_id_seq`) and the use of `JSONB` for localized fields like `name` and `vat_label`, which is characteristic of Odoo's multi-language support.

## Functional process 
This table supports the global master data management process, specifically defining country-level configurations for address validation, taxation, and communication. It is used to drive logic in the lead-to-cash and procurement pipelines, such as determining if a state or zip code is required for tax compliance or shipping calculations.

## Description
One row in this table represents a single country entity defined within the ERP system. It serves as a raw landed staging table containing both static metadata (country codes, phone prefixes) and configuration settings (address formats, validation requirements).

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| address_view_id | INTEGER | true | Foreign key to address view | Links to a specific UI/layout definition. |
| currency_id | INTEGER | true | Foreign key to currency | The default currency associated with the country. |
| phone_code | INTEGER | true | International dialing prefix | Numeric prefix for phone numbers. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| code | VARCHAR(2) | false | ISO 3166-1 alpha-2 code | Standard two-letter country code. |
| name_position | VARCHAR | true | Display position | Defines how the name is displayed in address blocks. |
| name | JSONB | false | Country name | Localized name stored as a JSON object. |
| vat_label | JSONB | true | VAT identifier label | Localized label for tax identification numbers. |
| address_format | TEXT | true | Address template | Jinja2 or similar template for formatting addresses. |
| state_required | BOOLEAN | true | State requirement flag | Indicates if a state/province is mandatory for addresses. |
| zip_required | BOOLEAN | true | Zip requirement flag | Indicates if a postal code is mandatory for addresses. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id` (Likely links to the currency master table).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit trails).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit trails).
- **Natural keys (inferred):** 
    - `code` (The ISO 3166-1 alpha-2 code is the standard business identifier for countries).

## Caveats for downstream consumers

- **Localization:** The `name` and `vat_label` columns are `JSONB`. Downstream consumers must extract the relevant language key (e.g., `name->>'en_US'`) to get a readable string.
- **Timestamps:** Timestamps are stored in the system's local time (typically UTC in Odoo deployments), but verify against the application server configuration.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` flag; standard Odoo practice is hard deletion, though audit columns (`write_date`) are present.
- **Data Integrity:** `address_format` contains template logic; ensure downstream systems can parse or ignore this if only the country name is required.