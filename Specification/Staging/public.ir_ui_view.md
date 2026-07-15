# ir_ui_view

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_ui_view` (Internal Registry User Interface View) is a standard Odoo core table used to store XML architecture definitions for the user interface.

## Functional process 
This table supports the UI rendering and customization engine of the Odoo platform. It manages the inheritance, priority, and structural definitions of views (forms, trees, kanban, etc.) used across the application, including website-specific theme templates and SEO metadata configurations.

## Description
One row represents a single UI view definition or customization, storing its XML architecture, inheritance rules, and associated metadata. It serves as a raw landing copy of the Odoo system's view registry, capturing both base views and user-defined customizations at the grain of a single view record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| priority | INTEGER | false | Rendering priority | Lower numbers indicate higher priority. |
| inherit_id | INTEGER | true | Parent view ID | Self-referencing FK to `ir_ui_view.id`. |
| create_uid | INTEGER | true | Creator user ID | FK to `res_users.id`. |
| write_uid | INTEGER | true | Last modifier user ID | FK to `res_users.id`. |
| name | VARCHAR | false | View name | Human-readable identifier. |
| model | VARCHAR | true | Associated data model | The Odoo model (e.g., `sale.order`) this view applies to. |
| key | VARCHAR | true | Unique view key | Used for programmatic lookups. |
| type | VARCHAR | true | View type | e.g., 'form', 'tree', 'kanban', 'qweb'. |
| arch_fs | VARCHAR | true | File system path | Path to the XML file if defined on disk. |
| mode | VARCHAR | false | View mode | 'primary' or 'extension'. |
| arch_db | JSONB | true | View architecture | The XML structure stored in the database. |
| arch_prev | TEXT | true | Previous architecture | Backup of the previous XML state. |
| arch_updated | BOOLEAN | true | Update flag | Indicates if the architecture has been modified. |
| active | BOOLEAN | true | Soft-delete flag | If false, the view is disabled. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| customize_show | BOOLEAN | true | Customization visibility | Flag for UI customization tools. |
| website_id | INTEGER | true | Website ID | FK to `website.id` for multi-site setups. |
| theme_template_id | INTEGER | true | Theme template ID | FK to `ir_ui_view.id` or theme registry. |
| website_meta_og_img | VARCHAR | true | OpenGraph image URL | SEO metadata. |
| visibility | VARCHAR | true | Visibility restriction | Access control setting. |
| visibility_password | VARCHAR | true | Visibility password | Plaintext or hashed password for access. |
| website_meta_title | JSONB | true | SEO Title | Multi-language JSON object. |
| website_meta_description | JSONB | true | SEO Description | Multi-language JSON object. |
| website_meta_keywords | JSONB | true | SEO Keywords | Multi-language JSON object. |
| seo_name | JSONB | true | SEO Name | Multi-language JSON object. |
| track | BOOLEAN | true | Tracking enabled | Flag for analytics/tracking. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `inherit_id` → `ir_ui_view.id`: References the parent view for inheritance chains.
    - `create_uid` / `write_uid` → `res_users.id`: References the system users who created or modified the record.
    - `website_id` → `website.id`: Links the view to a specific website instance in multi-site Odoo environments.
- **Natural keys (inferred):**
    - `key`: In many Odoo installations, the `key` field acts as a unique identifier for specific system views.

## Caveats for downstream consumers

- **Sensitive Data:** `visibility_password` may contain sensitive credentials and should be masked or excluded from general reporting.
- **Timezones:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo.
- **Soft Deletes:** The `active` column is used for soft deletes; ensure queries filter by `active = true` to get current records.
- **JSONB Complexity:** Columns like `website_meta_title` and `arch_db` contain complex nested data; use PostgreSQL JSONB operators (e.g., `->>`) to extract values.
- **Data Grain:** This table contains both base system views and user-defined customizations; distinguish them using the `mode` column.