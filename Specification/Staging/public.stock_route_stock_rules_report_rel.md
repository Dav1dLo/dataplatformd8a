# stock_route_stock_rules_report_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular business management system. The naming convention `_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link core business entities (in this case, stock rules reports and stock routes) within the inventory management module.

## Functional process 
This table supports the inventory configuration and reporting process. It maintains the many-to-many relationship between stock rules reports and the specific stock routes included in those reports, allowing the system to track which routing configurations are associated with which reporting snapshots.

## Description
One row in this table represents a single association between a stock rules report and a stock route. It serves as a raw junction table in the staging layer, capturing the link between these two entities as they exist in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_rules_report_id | INTEGER | false | Foreign key to the stock rules report entity | Links to the parent report record. |
| stock_route_id | INTEGER | false | Foreign key to the stock route entity | Links to the specific route configuration. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`stock_rules_report_id`, `stock_route_id`).
- **Foreign keys (inferred):** 
    - `stock_rules_report_id` → `stock_rules_report.id` (Inferred from naming convention).
    - `stock_route_id` → `stock_route.id` (Inferred from naming convention).
- **Natural keys (inferred):** The combination of (`stock_rules_report_id`, `stock_route_id`) acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes other than the two foreign keys.
- Ensure inner joins are used when traversing to parent tables to avoid orphaned records if referential integrity is not strictly enforced in the source.
- As a staging table, this data reflects the raw state of the source system; verify if the source performs hard or soft deletes on relationship records.