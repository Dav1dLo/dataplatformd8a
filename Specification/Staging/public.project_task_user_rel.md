# project_task_user_rel

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `*_rel` for many-to-many relationship tables and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the project management module, specifically tracking the assignment of users to specific tasks within a project. It acts as a junction table to manage the many-to-many relationship between tasks and users, potentially including stage-specific tracking for those assignments.

## Description
One row in this table represents a single association between a user and a task, defining their involvement or role in that task. As a staging table, it provides a raw, landed copy of the relationship data directly from the source database, intended for use in downstream transformation pipelines.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `project_task_user_rel_id_seq`. |
| task_id | INTEGER | false | Foreign key to the task | Links to the project task entity. |
| user_id | INTEGER | false | Foreign key to the user | Links to the system user entity. |
| stage_id | INTEGER | true | Foreign key to the task stage | Represents the specific workflow stage of the assignment. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last record modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `task_id` → `project_task.id` (Inferred from standard Odoo naming patterns).
    - `user_id` → `res_users.id` (Inferred from standard Odoo naming patterns).
    - `stage_id` → `project_task_type.id` (Inferred from standard Odoo naming patterns).
- **Natural keys (inferred):** 
    - `(task_id, user_id)` (The combination of task and user is expected to be unique in this relationship table).

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`, `user_id`) which may need to be joined with a user directory to identify individuals.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all records are active unless otherwise specified by business logic.
- **Data Integrity:** As a staging table, ensure that downstream models handle potential orphan records where `task_id` or `user_id` might not exist in their respective master tables.