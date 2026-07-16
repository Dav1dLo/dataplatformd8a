# res_groups_spreadsheet_dashboard_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_groups_*_rel` is a standard pattern used by the Odoo ORM to manage many-to-many relationship tables between security groups (`res_groups`) and other system entities, in this case, spreadsheet dashboards.

## Functional process 
This table supports the Access Control List (ACL) management process for spreadsheet dashboards. It defines which user security groups are granted access to specific dashboard configurations, ensuring that only authorized roles can view or modify sensitive business intelligence reports.

## Description
One row represents a single association between a security group and a spreadsheet dashboard. This is a junction table used to resolve a many-to-many relationship, serving as a raw landed copy of the Odoo database link table in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| spreadsheet_dashboard_id | INTEGER | false | Foreign key to the spreadsheet dashboard entity | Maps to the primary key of the dashboard definition table. |
| res_groups_id | INTEGER | false | Foreign key to the security group entity | Maps to the primary key of the `res_groups` table. |

## Keys

- **Primary key (inferred):** The combination of `(spreadsheet_dashboard_id, res_groups_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `spreadsheet_dashboard_id` → `spreadsheet_dashboard.id` (Inferred from Odoo naming convention).
    - `res_groups_id` → `res_groups.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` fields.
- Ensure that joins to `res_groups` or `spreadsheet_dashboard` handle potential orphans if the source system's referential integrity is not strictly enforced at the database level.