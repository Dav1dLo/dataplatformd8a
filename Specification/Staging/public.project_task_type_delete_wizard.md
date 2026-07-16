# project_task_type_delete_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (`_delete_wizard`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of Postgres sequence-based primary keys are characteristic of Odoo's transient model architecture.

## Functional process 
This table supports the "Task Management" business process. It functions as a transient wizard model used to handle the logic and user confirmation steps required when deleting specific task types within the project management module.

## Description
One row in this table represents a single execution instance of a task type deletion wizard session. It is a transient staging entity used to capture the state of a user's request to remove a project task category before the deletion is committed to the core project configuration tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `project_task_type_delete_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the wizard session | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last modified the wizard session | References `res_users.id`. |
| create_date | TIMESTAMP | true | Timestamp of wizard creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last wizard modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a "wizard" or "transient" model; data is typically short-lived and may be purged by the source system periodically.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- No PII is explicitly identified in these columns, but verify if the wizard captures task-specific metadata in other columns not present in this schema.
- The table does not implement soft-delete; it is a transient state container.