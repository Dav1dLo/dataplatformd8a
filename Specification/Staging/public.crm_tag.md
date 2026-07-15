# crm_tag

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `JSONB` for translatable fields (like `name`), is characteristic of the Odoo ORM framework.

## Functional process 
This table supports the Customer Relationship Management (CRM) module by managing metadata tags used to categorize leads, opportunities, or customers. These tags allow users to segment their sales pipeline and track specific attributes or interests associated with CRM entities.

## Description
One row in this table represents a single CRM tag definition available for assignment to records within the system. It serves as a raw landing copy of the tag master data, capturing the tag's display name and audit metadata for tracking record creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.crm_tag_id_seq`. |
| color | INTEGER | true | UI color index | Represents the color assigned to the tag in the CRM interface. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the tag. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the tag. |
| name | JSONB | false | Tag display name | Multilingual string stored as JSON; usually contains keys for different locales. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** 
    - `name` (Assuming the tag name is unique within the system context).

## Caveats for downstream consumers

- **Sensitive Data:** None identified; this table contains configuration/metadata rather than PII.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Format:** The `name` column is `JSONB`. Downstream consumers must use PostgreSQL JSON operators (e.g., `->>`) to extract the string value for reporting.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are currently active unless otherwise specified by the source system's business logic.