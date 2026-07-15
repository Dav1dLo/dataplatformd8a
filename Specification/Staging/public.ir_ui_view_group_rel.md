# ir_ui_view_group_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_ui_view_group_rel` is characteristic of Odoo's internal registry (IR) tables, specifically representing a many-to-many relationship between user interface views and security groups.

## Functional process 
This table supports the Access Control List (ACL) management process within the application. It defines which security groups are granted access to specific UI views, ensuring that users only see interface elements (forms, lists, menus) permitted by their assigned security roles.

## Description
One row in this table represents a single association between a specific UI view and a security group. It acts as a join table in the staging layer, providing a raw, un-transformed mapping of the many-to-many relationship between the `ir.ui.view` and `res.groups` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| view_id | INTEGER | false | Foreign key to the UI view definition | References the primary key of the view table. |
| group_id | INTEGER | false | Foreign key to the security group definition | References the primary key of the groups table. |

## Keys

- **Primary key (inferred):** The combination of (`view_id`, `group_id`) acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id` (Inferred from Odoo naming conventions).
    - `group_id` → `res_groups.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this represents the current state of the relationship as captured during the last ingestion.
- Ensure that joins to target tables handle the `INTEGER` types correctly to avoid implicit casting issues in downstream transformations.