# report_layout

## Source system
This table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` on a `_seq` sequence for the primary key, is characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the reporting and document generation module. It manages the configuration and layout definitions for specific report views, likely determining the order (`sequence`) and associated assets (images or PDF templates) used when rendering business documents.

## Description
One row in this table represents a specific layout configuration for a report view. It acts as a raw landing copy of the system's report definition metadata, capturing the association between a view, its display sequence, and any associated binary file paths or names.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.report_layout_id_seq`. |
| view_id | INTEGER | false | Foreign key to the report view | Likely references a `ir.ui.view` or similar table. |
| sequence | INTEGER | true | Display order index | Used to sort layouts within a view. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| image | VARCHAR | true | Image file path or binary reference | Stores reference to layout imagery. |
| pdf | VARCHAR | true | PDF template file path | Stores reference to PDF layout files. |
| name | VARCHAR | true | Layout name | Human-readable identifier for the layout. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id` (guess): Standard Odoo pattern for linking layout configurations to view definitions.
    - `create_uid` → `res_users.id` (guess): Standard Odoo pattern for audit tracking of record creation.
    - `write_uid` → `res_users.id` (guess): Standard Odoo pattern for audit tracking of record updates.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume rows are physically removed if missing from source.
- **Data Integrity:** The `image` and `pdf` columns are `VARCHAR` types; verify if these contain file paths, URLs, or base64-encoded strings before processing.
- **Audit Columns:** `create_uid` and `write_uid` are integers; these should be joined against the `res_users` table to resolve human-readable names.