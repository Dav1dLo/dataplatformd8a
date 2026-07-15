# hr_skill_type

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`hr_skill_type`), the use of `create_uid`/`write_uid` audit columns, and the `JSONB` data type for the `name` field, which is characteristic of Odoo's multi-language field storage.

## Functional process 
This table supports the Human Resources management module, specifically the configuration of skill categories or types (e.g., "Technical Skills", "Languages", "Soft Skills"). It provides the taxonomy used to categorize individual employee skills within the HR profile.

## Description
One row in this table represents a single skill category definition used to group specific skills. This is a raw landed staging table containing the configuration metadata for skill types, including audit timestamps and user tracking for record creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_skill_type_id_seq`. |
| color | INTEGER | true | UI display color index | Represents an integer index for color-coding in the Odoo frontend. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| name | JSONB | false | Skill type name | Multilingual string stored as JSON; extract using `name->>'en_US'` or similar. |
| active | BOOLEAN | true | Soft-delete flag | If false, the skill type is hidden from the UI. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on standard Odoo patterns. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC based on standard Odoo patterns. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column referencing the users table).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column referencing the users table).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified; this table contains configuration metadata.
- **Timezones:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` unless historical/archived data is required.
- **JSONB Handling:** The `name` column is a `JSONB` object. Downstream consumers must use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to access the actual string values.