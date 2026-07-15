# ir_actions_todo

## Source system
This table originates from an Odoo ERP system, as evidenced by the `ir_` (internal registry) prefix, the use of `create_uid`/`write_uid` audit columns, and the standard Odoo sequence/state pattern.

## Functional process 
This table supports the "Action Todo" or "Server Action" management process, which tracks pending tasks or automated actions that need to be executed within the Odoo framework. It is used to manage the lifecycle of system-level actions, tracking who created or modified them and their current execution state.

## Description
One row represents a single "To-Do" action item within the Odoo internal registry. This table serves as a raw landed copy of the system's action queue, capturing the configuration and audit metadata for each task.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `ir_actions_todo_id_seq` sequence. |
| action_id | INTEGER | false | Reference to the base action | Likely links to `ir_actions` table. |
| sequence | INTEGER | true | Execution order | Determines the priority or order of operations. |
| create_uid | INTEGER | true | Creator user ID | Links to `res_users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res_users` table. |
| state | VARCHAR | false | Current status | Indicates if the action is open, done, or cancelled. |
| name | VARCHAR | true | Action name | Descriptive label for the task. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `action_id` → `ir_actions.id` (Inferred from Odoo naming conventions).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the server's local time; verify the Odoo instance timezone configuration before performing time-series analysis.
- **Sensitive Data:** `create_uid` and `write_uid` link to user records which may contain PII; ensure appropriate access controls are applied when joining to user tables.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are physically removed if they disappear from the source.
- **Data Integrity:** As a staging table, ensure that `action_id` references are validated against the master `ir_actions` table, as referential integrity may not be strictly enforced at the database level in Odoo.