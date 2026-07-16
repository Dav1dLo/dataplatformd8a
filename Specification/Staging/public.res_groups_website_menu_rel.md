# res_groups_website_menu_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_groups_website_menu_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link security groups (`res_groups`) to specific website menu items (`website_menu`).

## Functional process 
This table supports the Access Control List (ACL) management for website navigation. It defines which user groups have permission to view or interact with specific menu items on the website, ensuring that sensitive or role-specific navigation elements are only visible to authorized users.

## Description
One row represents a single association between a security group and a website menu item. This is a junction table used to resolve a many-to-many relationship, serving as a raw landed copy of the Odoo database schema in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| website_menu_id | INTEGER | false | Foreign key to the website menu definition | Links to the primary key of the website menu table. |
| res_groups_id | INTEGER | false | Foreign key to the security group definition | Links to the primary key of the res_groups table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`website_menu_id`, `res_groups_id`).
- **Foreign keys (inferred):** 
    - `website_menu_id` → `website_menu.id`: Links to the menu item definition.
    - `res_groups_id` → `res_groups.id`: Links to the security group definition.
- **Natural keys (inferred):** The combination of (`website_menu_id`, `res_groups_id`) acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table contains no non-key attributes; it is strictly a relationship mapping.
- There are no timestamps or audit columns present in this table; changes to permissions are not tracked historically here.
- Ensure joins to `res_groups` and `website_menu` are performed using inner joins if you only require active associations.