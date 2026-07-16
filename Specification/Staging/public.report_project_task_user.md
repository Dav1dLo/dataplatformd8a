# report_project_task_user

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (e.g., `partner_id`, `stage_id`, `sale_order_id`) and the specific pattern of tracking project task metrics alongside sales integration fields.

## Functional process 
This table supports the project management and service delivery pipeline, specifically tracking task assignments, project milestones, and the correlation between project tasks and sales orders. It is used to monitor task progress, SLA adherence (via `working_days_close` and `date_deadline`), and customer satisfaction ratings.

## Description
One row represents a single project task assigned to a user, capturing its current state, timing metrics, and associated project/sales metadata. This is a staging table providing a raw, denormalized view of task-level data, intended for downstream transformation into project performance reporting models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| nbr | INTEGER | true | Row count or sequence identifier | Likely used for reporting aggregations. |
| id | INTEGER | true | Unique identifier for the task record | Surrogate key from source. |
| task_id | INTEGER | true | Foreign key to the base task entity | Links to the primary task definition. |
| active | BOOLEAN | true | Soft-delete flag | True if the task is currently active. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| date_assign | TIMESTAMP | true | Date the task was assigned | |
| date_end | TIMESTAMP | true | Date the task was completed | |
| date_last_stage_update | TIMESTAMP | true | Last update to task stage | |
| date_deadline | TIMESTAMP | true | Task deadline | |
| project_id | INTEGER | true | Foreign key to the project | |
| priority | VARCHAR | true | Task priority level | |
| name | VARCHAR | true | Task name or title | |
| company_id | INTEGER | true | Owning company identifier | |
| partner_id | INTEGER | true | Customer/Partner identifier | |
| parent_id | INTEGER | true | Parent task identifier | Used for sub-task hierarchies. |
| stage_id | INTEGER | true | Current stage identifier | |
| state | VARCHAR | true | Current workflow state | |
| milestone_id | INTEGER | true | Associated milestone identifier | |
| is_closed | BOOLEAN | true | Completion status | |
| has_late_and_unreached_milestone | BOOLEAN | true | Milestone status flag | |
| description | TEXT | true | Detailed task description | |
| rating_last_value | DOUBLE PRECISION | true | Most recent rating score | |
| rating_avg | DOUBLE PRECISION | true | Average rating score | |
| working_days_close | DOUBLE PRECISION | true | Days taken to close | |
| working_days_open | DOUBLE PRECISION | true | Days task has been open | |
| working_hours_open | NUMERIC | true | Hours task has been open | |
| working_hours_close | NUMERIC | true | Hours taken to close | |
| delay_endings_days | NUMERIC | true | Days delayed past deadline | |
| dependent_ids_count | BIGINT | true | Count of dependent tasks | |
| sale_line_id | INTEGER | true | Associated sales order line | |
| sale_order_id | INTEGER | true | Associated sales order | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `task_id` → `project_task.id` (Inferred from naming convention)
    - `project_id` → `project_project.id` (Inferred from naming convention)
    - `partner_id` → `res_partner.id` (Standard Odoo pattern)
    - `sale_order_id` → `sale_order.id` (Standard Odoo pattern)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC; verify against source system configuration if time-zone sensitive calculations are required.
- **Soft Deletes:** The `active` column should be used to filter out inactive records in all downstream models.
- **Data Quality:** `working_hours` and `delay_endings_days` are `NUMERIC` types; ensure precision is handled correctly during aggregation to avoid rounding errors.
- **PII:** The `description` field may contain unstructured PII; ensure appropriate masking if exposing to non-authorized users.