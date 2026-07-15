# ir_asset

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP and CRM platform. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's ORM layer, which manages assets and web resources.

## Functional process 
This table supports the web asset management process, specifically tracking static resources (CSS, JS, images) used by the Odoo website builder. It manages the bundling and pathing of assets required to render the frontend, linking specific assets to website configurations and theme templates.

## Description
One row in this table represents a single web asset record, defining its file path, bundle association, and deployment directive. It serves as a raw landing copy of the Odoo `ir.asset` model, capturing the metadata required to resolve and serve static files in the application's web interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `ir_asset_id_seq` sequence. |
| sequence | INTEGER | false | Display/processing order | Used to determine asset loading priority. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to `res_users`. |
| name | VARCHAR | false | Asset name | Descriptive label for the asset. |
| bundle | VARCHAR | false | Asset bundle name | The group (e.g., 'web.assets_frontend') this asset belongs to. |
| directive | VARCHAR | true | Deployment directive | Instruction for asset processing (e.g., 'include', 'append'). |
| path | VARCHAR | false | File path | Relative path to the asset file. |
| target | VARCHAR | true | Target location | Specific target for the asset injection. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the asset is currently enabled. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo ORM. |
| website_id | INTEGER | true | Website ID | Foreign key to `website`. |
| theme_template_id | INTEGER | true | Theme template ID | Foreign key to `theme_template`. |
| key | VARCHAR | true | Unique asset key | Business-level identifier for the asset. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `create_uid` → `res_users.id` (Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Standard Odoo audit column).
    - `website_id` → `website.id` (Links asset to a specific website instance).
    - `theme_template_id` → `theme_template.id` (Links asset to a specific theme).
- **Natural keys (inferred):**
    - `key` (Often used by Odoo to uniquely identify assets across environments).

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with user tables to resolve names.
- **Timestamps:** All `_date` columns are stored in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing an audit.
- **Data Integrity:** As a staging table, this represents the raw state; ensure downstream models handle potential nulls in `directive` and `target` fields appropriately.