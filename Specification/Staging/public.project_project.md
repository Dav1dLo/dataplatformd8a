# project_project

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (e.g., `create_uid`, `write_uid`, `company_id`, `partner_id`), the use of `JSONB` for localized fields like `name`, and the specific sequence-based primary key pattern common in Odoo's PostgreSQL backend.

## Functional process 
This table supports the Project Management module, specifically the "Project-to-Task" lifecycle. It tracks project metadata, visibility settings, and configuration for task management, billing, and milestone tracking within the organization.

## Description
One row represents a single project entity within the system, capturing its configuration, status, and associated business logic. It serves as the raw landed staging record for project definitions, including settings for task dependencies, billing, and rating status.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| account_id | INTEGER | true | Analytical account reference | Links to financial accounting. |
| alias_id | INTEGER | false | Email alias reference | Used for project-specific email routing. |
| sequence | INTEGER | true | Display order index | Used for UI sorting. |
| partner_id | INTEGER | true | Customer/Partner reference | The client associated with the project. |
| company_id | INTEGER | true | Multi-company scope | Identifies the owning entity. |
| color | INTEGER | true | UI color index | Used for dashboard categorization. |
| user_id | INTEGER | true | Project manager reference | The primary user responsible for the project. |
| stage_id | INTEGER | true | Project stage reference | Current status in the project pipeline. |
| last_update_id | INTEGER | true | Last update log reference | Links to update history. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for updates. |
| access_token | VARCHAR | true | Public access token | Used for external portal sharing. |
| privacy_visibility | VARCHAR | false | Visibility scope | Defines who can view the project. |
| rating_status | VARCHAR | false | Rating configuration | Current status of customer feedback. |
| rating_status_period | VARCHAR | false | Rating frequency | Periodicity for feedback requests. |
| last_update_status | VARCHAR | false | Update status | Current health/status indicator. |
| date_start | DATE | true | Start date | Planned start date of the project. |
| date | DATE | true | Deadline/End date | Planned completion date. |
| name | JSONB | false | Project name | Multilingual field stored as JSON. |
| label_tasks | JSONB | true | Task labels | Custom labels for project tasks. |
| task_properties_definition | JSONB | true | Task property schema | Dynamic fields definition for tasks. |
| description | TEXT | true | Project description | Long-form project details. |
| active | BOOLEAN | true | Soft-delete flag | False indicates archived/deleted. |
| allow_task_dependencies | BOOLEAN | true | Dependency toggle | Enables task sequencing. |
| allow_milestones | BOOLEAN | true | Milestone toggle | Enables milestone tracking. |
| rating_active | BOOLEAN | true | Rating enabled flag | Whether feedback is requested. |
| rating_request_deadline | TIMESTAMP | true | Feedback deadline | Timestamp for rating requests. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| x_plan2_id | INTEGER | true | Custom plan reference 2 | Likely a custom field extension. |
| x_plan3_id | INTEGER | true | Custom plan reference 3 | Likely a custom field extension. |
| sale_line_id | INTEGER | true | Sale order line reference | Links project to specific sales items. |
| reinvoiced_sale_order_id | INTEGER | true | Re-invoicing SO reference | Links to the SO for billing. |
| allow_billable | BOOLEAN | true | Billable toggle | Enables time/material billing. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Likely reference to the customer entity)
    - `company_id` → `res_company.id` (Likely reference to the organization entity)
    - `user_id` → `res_users.id` (Likely reference to the project manager)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `name` and `description` fields may contain sensitive project details.
- **Timestamps:** All `TIMESTAMP` fields are assumed to be in UTC, consistent with Odoo's standard behavior.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = true` to retrieve current records.
- **JSONB:** The `name`, `label_tasks`, and `task_properties_definition` columns require PostgreSQL JSONB operators (e.g., `->>`) for extraction.
- **Custom Fields:** Columns prefixed with `x_` are custom fields added to the Odoo instance and may not exist in standard Odoo schemas.