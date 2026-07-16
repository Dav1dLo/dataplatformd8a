# theme_website_menu

## Source system
This table originates from an Odoo ERP environment, evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for translatable fields like `name`.

## Functional process 
This table supports the website content management process, specifically the configuration of navigation menus for the web storefront. It manages the hierarchy, ordering, and display properties of menu items, including support for mega-menus and external URL linking.

## Description
One row represents a single menu item within the website navigation structure. It defines the label, target URL, display order, and hierarchical relationship to other menu items. This is a raw landing table in the staging layer, capturing the current state of website menu configurations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| page_id | INTEGER | true | Foreign key to the linked website page | Links to the content page if the menu item is internal. |
| sequence | INTEGER | true | Display order index | Used for sorting menu items. |
| parent_id | INTEGER | true | Self-referencing parent menu ID | Defines the menu hierarchy. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user table. |
| url | VARCHAR | true | Target URL for the menu item | Can be relative or absolute. |
| mega_menu_classes | VARCHAR | true | CSS classes for mega-menu styling | Used for frontend rendering. |
| name | JSONB | false | Menu item label | Multilingual content stored as JSON. |
| mega_menu_content | TEXT | true | HTML content for mega-menu | Contains raw HTML for complex menu layouts. |
| new_window | BOOLEAN | true | Flag to open link in new tab | True if the link should open in a new window. |
| use_main_menu_as_parent | BOOLEAN | true | Flag for parent menu behavior | Determines if the main menu acts as a container. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `page_id` → `website_page.id` (Guess: links to the page management table).
    - `parent_id` → `theme_website_menu.id` (Self-referencing: defines the tree structure).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo pattern for audit trails).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **JSONB:** The `name` column contains localized strings; ensure your extraction logic handles the JSON structure (e.g., `name->>'en_US'`).
- **Hierarchy:** The table is self-referential via `parent_id`; recursive CTEs will be required to reconstruct the full menu tree.
- **Data Integrity:** As a staging table, this may contain orphaned records or historical configurations; verify `page_id` existence before joining.