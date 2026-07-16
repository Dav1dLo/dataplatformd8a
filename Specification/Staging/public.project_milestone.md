# project_milestone

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo's ORM layer.

## Functional process 
This table supports the project management and billing process, specifically tracking progress milestones within projects. It links project deliverables to sales orders via `sale_line_id` and tracks completion status and deadlines, likely feeding into revenue recognition or project invoicing workflows.

## Description
One row in this table represents a specific milestone associated with a project, defining a target deadline and completion status. As a staging table, it serves as a raw landed copy of the Odoo `project.milestone` model, preserving the source system's audit trail and relational links.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `project_milestone_id_seq`. |
| project_id | INTEGER | false | Foreign key to the parent project | Links to the project definition. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| name | VARCHAR | false | Milestone description | The human-readable name of the milestone. |
| deadline | DATE | true | Target completion date | Expected date for milestone achievement. |
| reached_date | DATE | true | Actual completion date | The date the milestone was marked as reached. |
| is_reached | BOOLEAN | true | Completion status flag | Indicates if the milestone has been achieved. |
| create_date | TIMESTAMP | true | Record creation timestamp | Likely in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Likely in UTC. |
| sale_line_id | INTEGER | true | Foreign key to sales order line | Links milestone to specific billing items. |
| quantity_percentage | DOUBLE PRECISION | true | Progress weight | Percentage of project completion represented by this milestone. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `project_id` → `project.id` (Inferred from naming convention)
    - `create_uid` → `res_users.id` (Standard Odoo pattern)
    - `write_uid` → `res_users.id` (Standard Odoo pattern)
    - `sale_line_id` → `sale_order_line.id` (Inferred from naming convention)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; check if the source system uses hard deletes.
- **Data Quality:** `quantity_percentage` is a `DOUBLE PRECISION` type; ensure rounding is applied if used for financial calculations downstream.