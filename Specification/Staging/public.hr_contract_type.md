# hr_contract_type

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`hr_contract_type`), the use of `JSONB` for multi-language fields (`name`), and the standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the Human Resources module, specifically the configuration of contract types (e.g., "Full-time", "Part-time", "Fixed-term"). It is used to categorize employment agreements within the organization, potentially filtered by country-specific regulations via the `country_id` column.

## Description
One row represents a single definition of a contract type available within the HR system. This is a reference/lookup table in the staging layer, providing a raw, un-transformed copy of the source configuration data.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_contract_type_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort types in the UI. |
| country_id | INTEGER | true | Foreign key to country | Links contract type to a specific jurisdiction. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| code | VARCHAR | true | Internal code | Short alphanumeric identifier for the contract type. |
| name | JSONB | false | Display name | Multi-language string stored as JSON. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `country_id` → `res_country.id` (Likely target based on Odoo standard schema).
    - `create_uid` → `res_users.id` (Likely target for audit tracking).
    - `write_uid` → `res_users.id` (Likely target for audit tracking).
- **Natural keys (inferred):** 
    - `code` (Assuming unique business identifier for contract types).

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may be considered PII depending on organizational policy.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Format:** The `name` column is `JSONB`; downstream consumers will need to use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract human-readable text.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are assumed to be active unless otherwise specified by business logic.