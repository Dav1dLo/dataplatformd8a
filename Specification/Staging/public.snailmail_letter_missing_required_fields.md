# snailmail_letter_missing_required_fields

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `partner_id`, `create_uid`, `write_date`) and the use of standard Odoo sequence generators for the primary key are characteristic of the Odoo ORM's underlying database schema.

## Functional process 
This table supports the "Snailmail" mailing automation process. It acts as an exception log or staging area for letters that failed validation due to missing address components (street, city, zip, or country) required for physical mail delivery.

## Description
One row represents a single instance of a mailing attempt that was flagged for missing mandatory address fields. It serves as a raw landing record in the Staging layer, capturing the state of the address data at the time the validation error occurred.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `nextval` sequence. |
| partner_id | INTEGER | true | Foreign key to the partner | Links to the recipient entity. |
| letter_id | INTEGER | true | Foreign key to the letter | Links to the specific mailing document. |
| state_id | INTEGER | true | Foreign key to the state/province | Part of the address validation. |
| country_id | INTEGER | true | Foreign key to the country | Part of the address validation. |
| create_uid | INTEGER | true | User ID who created the record | References the system user. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user. |
| street | VARCHAR | true | Street address line 1 | Missing or invalid data. |
| street2 | VARCHAR | true | Street address line 2 | Missing or invalid data. |
| zip | VARCHAR | true | Postal code | Missing or invalid data. |
| city | VARCHAR | true | City name | Missing or invalid data. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo naming convention for partner references).
    - `letter_id` → `snailmail_letter.id` (Standard Odoo naming convention for letter references).
    - `state_id` → `res_country_state.id` (Standard Odoo naming convention for state references).
    - `country_id` → `res_country.id` (Standard Odoo naming convention for country references).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains address information (`street`, `city`, `zip`) which may be considered PII depending on regional regulations.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Quality:** As this is an exception/error log, many fields are intentionally null or contain incomplete data; do not assume address completeness.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely appended as errors occur.