# res_country_group

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `res_country_group`, the use of `create_uid`/`write_uid` audit columns, and the `JSONB` type for the `name` field, which is characteristic of Odoo's multi-language field storage.

## Functional process 
This table supports the management of geographical groupings of countries, often used in ERP systems to define regional pricing, tax jurisdictions, or shipping zones. It allows the business to bundle multiple countries into a single entity for simplified configuration across sales and logistics modules.

## Description
One row represents a single country group definition within the system. It serves as a raw landed copy of the Odoo `res.country.group` model, capturing the metadata and localized names for these groupings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `res_country_group_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users.id`. |
| name | JSONB | false | Localized name of the country group | Stores translations; query using `->>` operator. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming pattern for creator audit fields).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming pattern for modifier audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`. To extract the default language name, use `name->>'en_US'` or similar depending on your instance configuration.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table does not implement soft deletes; records are typically removed or updated directly in the source.
- `create_uid` and `write_uid` may be null if the record was created via a system process or migration script rather than a user action.