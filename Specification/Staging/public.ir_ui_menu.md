# ir_ui_menu

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_ui_menu` (Internal Resource User Interface Menu) is a standard Odoo system table used to define the application's navigation structure and menu hierarchy.

## Functional process 
This table supports the application's navigation and UI configuration process. It defines the hierarchical menu tree displayed to users in the Odoo web interface, linking specific menu items to backend actions and controlling their visibility and ordering within the system.

## Description
One row in this table represents a single menu item within the application's navigation tree. It acts as a raw landed copy of the Odoo system configuration, capturing the menu's display name, its position in the hierarchy, and the associated action triggered when the menu is selected.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `ir_ui_menu_id_seq`. |
| sequence | INTEGER | true | Sort order index | Used to determine the display order of sibling menu items. |
| parent_id | INTEGER | true | Self-referencing foreign key | Points to the parent menu item ID to form a tree structure. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the menu entry. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the menu entry. |
| parent_path | VARCHAR | true | Materialized path | A string representation of the hierarchy (e.g., "1/5/10") for efficient tree traversal. |
| web_icon | VARCHAR | true | Icon identifier | Path or reference to the icon displayed in the UI. |
| action | VARCHAR | true | Action reference | The technical name or reference of the action to execute. |
| name | JSONB | false | Menu display name | Multilingual label stored as a JSON object. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the menu item is currently enabled in the UI. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `public.ir_ui_menu.id`: Defines the parent-child relationship for the menu hierarchy.
    - `create_uid` → `public.res_users.id` (guess): Likely references the system user who created the record.
    - `write_uid` → `public.res_users.id` (guess): Likely references the system user who last modified the record.
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but `create_uid` and `write_uid` link to user identities.
- **Timezone:** Timestamps are typically stored in UTC in Odoo; verify against system configuration.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = true` to retrieve only currently visible menu items.
- **JSONB:** The `name` column contains JSONB data; use PostgreSQL JSONB operators (e.g., `->>`) to extract specific language labels.
- **Hierarchy:** Use the `parent_path` column for efficient recursive queries rather than self-joining on `parent_id` where possible.