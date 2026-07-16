# project_update

## Source system
This table likely originates from an Odoo or similar ERP/Project Management system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` is a standard pattern for Odoo's ORM audit fields, and the naming convention for the sequence `project_update_id_seq` strongly supports this inference.

## Functional process 
This table supports the project tracking and status reporting process. It captures periodic snapshots or updates regarding project progress, task completion metrics, and status changes, allowing stakeholders to monitor project health over time.

## Description
One row in this table represents a single status update or progress report for a specific project. It serves as a raw landed copy of project update records, capturing both quantitative metrics (progress percentage, task counts) and qualitative descriptions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `project_update_id_seq`. |
| progress | INTEGER | true | Project completion percentage | Expected range 0-100. |
| user_id | INTEGER | false | Owner of the update | Foreign key to a user/employee table. |
| project_id | INTEGER | false | Associated project | Foreign key to a project master table. |
| task_count | INTEGER | true | Total tasks in project | Snapshot of total scope at time of update. |
| closed_task_count | INTEGER | true | Completed tasks | Used to calculate completion ratio. |
| create_uid | INTEGER | true | Creator user ID | Audit field for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field for record modification. |
| email_cc | VARCHAR | true | CC email addresses | Comma-separated list of recipients. |
| name | VARCHAR | false | Update title or summary | Short descriptive text for the update. |
| status | VARCHAR | false | Project status label | e.g., 'on_track', 'at_risk', 'off_track'. |
| date | DATE | true | Business date of update | The effective date for reporting purposes. |
| description | TEXT | true | Detailed update notes | Rich text or long-form status commentary. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Standard Odoo pattern for user associations).
    - `project_id` → `project_project.id` (Standard Odoo pattern for project associations).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard PostgreSQL/Odoo deployments.
- **Sensitivity:** The `email_cc` column may contain PII; ensure appropriate masking if exposing to non-authorized users.
- **Data Quality:** `progress` and `task_count` fields are snapshots; they may not be updated in real-time and depend on the frequency of manual entry.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all records are currently active unless otherwise specified by the source system's business logic.