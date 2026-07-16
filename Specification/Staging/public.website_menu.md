# website_menu

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for localized fields like `name`.

## Functional process 
This table supports the website content management process, specifically defining the hierarchical structure of navigation menus for web pages. It manages the organization, ordering, and display properties of menu items across different website instances within the ERP.

## Description
One row in this table represents a single menu item within a website navigation structure. This is a raw staging table containing the direct representation of menu configurations, including parent-child relationships, display sequences, and associated page links.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| page_id | INTEGER | true | Foreign key to the linked page | Links to the specific web page content. |
| controller_page_id | INTEGER | true | Foreign key to a controller | Used for dynamic or system-generated pages. |
| sequence | INTEGER | true | Display order index | Used to sort menu items. |
| website_id | INTEGER | true | Foreign key to the website | Identifies which website this menu belongs to. |
| parent_id | INTEGER | true | Self-referencing foreign key | Defines the menu hierarchy. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| theme_template_id | INTEGER | true | Theme template reference | Links to specific UI/UX templates. |
| url | VARCHAR | true | Target URL | The destination path for the menu item. |
| parent_path | VARCHAR | true | Materialized path | Used for efficient hierarchical queries. |
| mega_menu_classes | VARCHAR | true | CSS classes for mega menu | Styling configuration for complex menus. |
| name | JSONB | false | Menu display name | Multilingual content stored as JSON. |
| mega_menu_content | JSONB | true | Mega menu configuration | Structured content for advanced menu layouts. |
| new_window | BOOLEAN | true | Open in new tab flag | UI behavior toggle. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `page_id` → `website_page.id` (guess: links to page definitions)
    - `website_id` → `website.id` (guess: links to website configuration)
    - `parent_id` → `website_menu.id` (self-reference for hierarchy)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified, though `create_uid` and `write_uid` link to internal user records.
- **Timestamps:** Assumed to be in UTC; verify against Odoo system settings if local time conversion is required.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if missing.
- **JSONB:** The `name` and `mega_menu_content` columns contain nested structures; use PostgreSQL `->>` or `->` operators to extract specific keys.
- **Hierarchy:** Use the `parent_path` column for efficient recursive tree traversals rather than self-joining on `parent_id` where possible.