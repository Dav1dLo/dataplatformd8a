# project_tags

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `JSONB` for the `name` field (often used for multi-language support in Odoo), is characteristic of the Odoo ORM metadata structure.

## Functional process 
This table supports the project management module by maintaining a registry of labels or tags that can be associated with project tasks or issues. It allows for the categorization and filtering of project-related work items across the organization.

## Description
One row in this table represents a single project tag definition available for use within the project management system. This is a raw landing copy of the source table, serving as the primary staging entity for downstream dimension modeling of project metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.project_tags_id_seq`. |
| color | INTEGER | true | UI color index | Represents an integer index mapped to a color palette in the frontend. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system users table. |
| name | JSONB | false | Tag label | Stores the tag name, potentially localized; requires parsing for SQL access. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on standard Odoo behavior. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on standard Odoo behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is a `JSONB` type; queries must use the `->>` operator (e.g., `name->>'en_US'`) to extract string values.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table does not appear to implement soft-delete flags; assume all records are active unless otherwise specified by business logic.
- The `color` column is an integer index; it does not contain hex codes or RGB values directly and requires a lookup against the application's UI configuration.