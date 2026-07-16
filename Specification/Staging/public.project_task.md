# project_task

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming conventions (e.g., `create_uid`, `write_uid`, `write_date`, `active`), the presence of `JSONB` fields for dynamic properties, and the specific pattern of `partner_id` and `company_id` foreign keys are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the Project Management module, specifically the task tracking and execution workflow. It manages the lifecycle of individual tasks within a project, tracking assignments, deadlines, stage transitions, and resource allocation (allocated hours), while integrating with sales (via `sale_order_id`) and customer communication (via `partner_id` and email fields).

## Description
One row represents a single task within a project, capturing its current status, assigned resources, and temporal constraints. This table serves as a raw landed copy of the Odoo `project.task` model, providing the base grain for project progress reporting and resource utilization analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order index | Used for UI sorting. |
| stage_id | INTEGER | true | Foreign key to project stage | Links to the task's current workflow state. |
| project_id | INTEGER | true | Foreign key to project | The parent project container. |
| partner_id | INTEGER | true | Foreign key to partner | The customer or contact associated with the task. |
| company_id | INTEGER | true | Foreign key to company | Multi-company context identifier. |
| color | INTEGER | true | UI color index | Used for Kanban board styling. |
| displayed_image_id | INTEGER | true | Foreign key to image | Reference to an attachment/image. |
| parent_id | INTEGER | true | Foreign key to parent task | Used for sub-task hierarchies. |
| milestone_id | INTEGER | true | Foreign key to milestone | Links task to a project milestone. |
| recurrence_id | INTEGER | true | Foreign key to recurrence | Links to recurring task configuration. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| email_cc | VARCHAR | true | CC email addresses | Comma-separated list of CC recipients. |
| access_token | VARCHAR | true | Public access token | Used for portal/external sharing. |
| name | VARCHAR | false | Task title | The descriptive name of the task. |
| priority | VARCHAR | true | Priority level | Usually a string code (e.g., '0', '1'). |
| state | VARCHAR | false | Workflow state | Current status (e.g., 'draft', 'done'). |
| html_field_history | JSONB | true | History of HTML changes | Audit log of description changes. |
| task_properties | JSONB | true | Dynamic task attributes | Custom fields defined in Odoo Studio. |
| description | TEXT | true | Task details | Full text description of the task. |
| working_hours_open | NUMERIC | true | Hours to open | Metric for SLA tracking. |
| working_hours_close | NUMERIC | true | Hours to close | Metric for SLA tracking. |
| active | BOOLEAN | true | Soft-delete flag | False indicates the record is archived. |
| display_in_project | BOOLEAN | true | Visibility flag | Controls visibility in project views. |
| recurring_task | BOOLEAN | true | Recurrence flag | Indicates if this is a recurring task. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| date_end | TIMESTAMP | true | Completion date | Timestamp when task was marked done. |
| date_assign | TIMESTAMP | true | Assignment date | Timestamp when user was assigned. |
| date_deadline | TIMESTAMP | true | Deadline date | Target completion date. |
| date_last_stage_update | TIMESTAMP | true | Stage change timestamp | Tracks movement through workflow. |
| rating_last_value | DOUBLE PRECISION | true | Last customer rating | Numerical score from feedback. |
| allocated_hours | DOUBLE PRECISION | true | Planned effort | Estimated hours for the task. |
| working_days_open | DOUBLE PRECISION | true | Days to open | Metric for SLA tracking. |
| working_days_close | DOUBLE PRECISION | true | Days to close | Metric for SLA tracking. |
| email_from | VARCHAR | true | Originating email | Email address of the task requester. |
| partner_name | VARCHAR | true | Partner display name | Denormalized name from partner record. |
| partner_phone | VARCHAR | true | Partner phone number | Denormalized phone from partner record. |
| partner_company_name | VARCHAR | true | Partner company name | Denormalized company name. |
| sale_order_id | INTEGER | true | Foreign key to sale order | Links task to a specific sales contract. |
| sale_line_id | INTEGER | true | Foreign key to sale order line | Links task to a specific line item. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `project_id` → `project.id` (Likely target based on naming convention)
    - `partner_id` → `res_partner.id` (Standard Odoo pattern for contact links)
    - `stage_id` → `project_task_type.id` (Standard Odoo pattern for task stages)
    - `sale_order_id` → `sale_order.id` (Links to sales module)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `email_cc`, `email_from`, `partner_phone`, and `partner_name`. Ensure these are masked if exposing to non-authorized users.
- **Timestamps:** All `TIMESTAMP` fields are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column is used for soft deletes. Queries should generally filter by `WHERE active = TRUE` unless performing historical analysis.
- **Denormalization:** Several columns (e.g., `partner_name`, `partner_phone`) are denormalized from the `res_partner` table; these may become stale if the source partner record is updated.
- **JSONB:** `task_properties` and `html_field_history` contain unstructured data; use PostgreSQL JSONB operators (e.g., `->>`) to extract specific keys.