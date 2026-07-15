# hr_resume_line_type

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`hr_resume_line_type`), the use of `create_uid`/`write_uid` audit columns, and the `JSONB` data type for multi-language field support, which is characteristic of Odoo's PostgreSQL backend.

## Functional process 
This table supports the Human Resources module, specifically the configuration of resume line types (e.g., "Education", "Experience", "Certification"). It defines the categories used to structure an employee's professional history within the HR profile.

## Description
One row represents a single category or type of resume entry available for selection in the HR module. It serves as a raw landed configuration table in the Staging layer, capturing the metadata and localization settings for resume line classifications.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_resume_line_type_id_seq`. |
| sequence | INTEGER | true | Display order index | Used for UI sorting in the application. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| name | JSONB | false | Display name | Contains localized strings; structure is typically `{"en_US": "Value", ...}`. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`. Downstream consumers must extract the relevant language key (e.g., `name->>'en_US'`) to use this as a readable string.
- Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo, but verify against the application server configuration.
- This is a configuration/lookup table; it is unlikely to contain PII, but `create_uid` and `write_uid` link to user identity.
- No soft-delete flag is present; assume standard CRUD operations.