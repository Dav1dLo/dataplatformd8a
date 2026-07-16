# website_configurator_feature

## Source system
The table likely originates from an Odoo ERP instance, indicated by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized fields like `name` and `description`, which is characteristic of Odoo's PostgreSQL schema.

## Functional process 
This table supports the website configuration and navigation management process. It tracks specific features or modules available within a website configurator, defining their display order, associated page views, and metadata required to render the user interface.

## Description
One row represents a single configurable feature or menu item within the website configurator tool. This is a raw landing table in the staging layer, containing the direct state of feature definitions as they exist in the source application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `website_configurator_feature_id_seq`. |
| sequence | INTEGER | true | Display order index | Used for sorting features in the UI. |
| page_view_id | INTEGER | true | Foreign key to page view | Links the feature to a specific page view definition. |
| module_id | INTEGER | true | Foreign key to module | Identifies the software module providing this feature. |
| menu_sequence | INTEGER | true | Menu display order | Specific sequence for menu-based rendering. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| icon | VARCHAR | true | Icon identifier | CSS class or path for the feature icon. |
| iap_page_code | VARCHAR | true | IAP page code | Internal code for In-App Purchase integration. |
| website_config_preselection | VARCHAR | true | Preselection logic | Configuration string for default feature selection. |
| feature_url | VARCHAR | true | Target URL | The destination path for the feature. |
| name | JSONB | true | Localized feature name | Multilingual name stored as a JSON object. |
| description | JSONB | true | Localized description | Multilingual description stored as a JSON object. |
| menu_company | BOOLEAN | true | Company menu flag | Indicates if the feature is scoped to a specific company. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `page_view_id` → `website_page_view.id` (guess: links to a page view definition table)
    - `module_id` → `ir_module.id` (guess: standard Odoo module registry link)
    - `create_uid` → `res_users.id` (guess: standard Odoo user reference)
    - `write_uid` → `res_users.id` (guess: standard Odoo user reference)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Localization:** The `name` and `description` columns are `JSONB` types; downstream consumers must parse these to extract the relevant language key (e.g., `->> 'en_US'`).
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal system user IDs; these will not resolve to meaningful names without joining to the `res_users` table.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all records are active unless otherwise specified by business logic.