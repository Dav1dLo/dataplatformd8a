# ir_ui_menu_group_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_ui_menu_group_rel` is characteristic of Odoo's internal "ir" (ir_ui_menu) module, which manages the relationship between user interface menu items and security groups.

## Functional process 
This table supports the access control and authorization process within the application. It defines the many-to-many relationship between menu items and user groups, determining which groups have visibility or access to specific UI menu elements.

## Description
Each row represents a single association between a specific menu item and a security group. It acts as a join table in the staging layer, providing a raw, un-transformed mapping of the application's menu-to-group permissions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| menu_id | INTEGER | false | Foreign key to the menu definition | References the primary key of the menu table. |
| gid | INTEGER | false | Foreign key to the security group definition | References the primary key of the group table. |

## Keys

- **Primary key (inferred):** The combination of `(menu_id, gid)` is the inferred composite primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `menu_id` → `ir_ui_menu.id` (Inferred from Odoo schema naming conventions).
    - `gid` → `res_groups.id` (Inferred from Odoo schema naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure that downstream joins handle the many-to-many nature of this relationship to avoid fan-out issues when querying menu permissions.