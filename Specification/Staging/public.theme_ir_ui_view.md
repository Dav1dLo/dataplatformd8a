# theme_ir_ui_view

## Source system
This table originates from Odoo (OpenERP), an open-source ERP system. The naming convention `ir_ui_view` is a standard Odoo internal table name representing the "Interface View" registry, which stores XML/JSON definitions for the user interface components.

## Functional process 
This table supports the UI rendering and customization engine of the Odoo platform. It manages the definitions of views (forms, lists, trees, etc.), tracking how they inherit from base templates (`inherit_id`) and their priority in the rendering stack, which is critical for the "View Inheritance" mechanism used to customize Odoo modules without modifying core code.

## Description
One row represents a single UI view definition or a customization layer applied to an existing view. It stores the architectural definition of the interface in a JSONB format, allowing the system to dynamically construct the user interface. This is a raw landing of the Odoo `ir.ui.view` model, serving as the staging layer for UI metadata analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| priority | INTEGER | false | Rendering order | Lower numbers take precedence in view inheritance. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the view. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the view. |
| name | VARCHAR | false | View name | Descriptive label for the view. |
| key | VARCHAR | true | Unique identifier key | Often used for specific system-level views. |
| type | VARCHAR | true | View type | e.g., 'form', 'tree', 'kanban', 'search'. |
| mode | VARCHAR | true | View mode | 'primary' or 'extension'. |
| arch_fs | VARCHAR | true | File system path | Path to the XML file if defined on disk. |
| inherit_id | VARCHAR | true | Parent view ID | References the view being extended. |
| arch | JSONB | true | View architecture | The structural definition of the UI component. |
| active | BOOLEAN | true | Active status | Soft-delete flag; if false, the view is ignored. |
| customize_show | BOOLEAN | true | Customization visibility | Flag for UI customization tools. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `inherit_id` → `ir_ui_view.id` (Guess: self-referencing hierarchy for view inheritance).
- **Natural keys (inferred):** 
    - `name` (Note: In Odoo, names are often unique within a module context, but not globally).

## Caveats for downstream consumers

- **Sensitive Data:** Contains system architecture definitions; while not PII, it may expose internal system paths (`arch_fs`).
- **Timestamps:** Timestamps are stored in the server's local time; verify the Odoo instance timezone configuration before performing time-series analysis.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless auditing historical view states.
- **JSONB Complexity:** The `arch` column contains complex nested structures. Downstream consumers should use PostgreSQL JSONB operators (e.g., `->>`) to extract specific UI attributes.