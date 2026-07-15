# ir_cron

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_cron` (Internal Registry - Cron) is a standard Odoo pattern for managing scheduled background tasks and automated actions within the platform.

## Functional process 
This table supports the automated task scheduling and background job execution process. It tracks the configuration, execution frequency, and health status of system-level scheduled actions, ensuring that recurring business processes—such as email queue processing, report generation, or data synchronization—are triggered at the correct intervals.

## Description
One row in this table represents a single scheduled background task (cron job) configured within the system. It acts as a raw landing copy of the Odoo task registry, capturing the execution schedule, the associated server action, and the current status of the job.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_cron_id_seq`. |
| ir_actions_server_id | INTEGER | false | Foreign key to server actions | Links to the specific action to be executed. |
| user_id | INTEGER | false | User ID context | The system user context under which the job runs. |
| interval_number | INTEGER | false | Frequency multiplier | Numeric value for the interval (e.g., 5). |
| priority | INTEGER | true | Execution priority | Lower numbers typically indicate higher priority. |
| failure_count | INTEGER | true | Error counter | Tracks consecutive failures for the job. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the job. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the job. |
| cron_name | VARCHAR | true | Task display name | Human-readable name of the scheduled task. |
| interval_type | VARCHAR | false | Time unit | Unit for `interval_number` (e.g., 'days', 'hours'). |
| active | BOOLEAN | true | Status flag | Indicates if the scheduled task is currently enabled. |
| nextcall | TIMESTAMP | false | Next execution time | Scheduled timestamp for the next run. |
| lastcall | TIMESTAMP | true | Last execution time | Timestamp of the most recent successful run. |
| first_failure_date | TIMESTAMP | true | Initial failure timestamp | Timestamp of the first error in the current failure sequence. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time in the database. |
| write_date | TIMESTAMP | true | Last update timestamp | Record modification time in the database. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `ir_actions_server_id` → `ir_actions_server.id` (Likely links to the server action definition table).
    - `user_id` → `res_users.id` (Standard Odoo pattern for user association).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the system's configured timezone (typically UTC in Odoo, but verify against application settings).
- **Active Flag:** Queries should generally filter by `active = TRUE` to ignore disabled or deprecated scheduled tasks.
- **Data Sensitivity:** The `user_id` and `create_uid` columns link to user identity data, which may be considered PII depending on the organization's privacy policy.
- **Soft Deletes:** Odoo often uses the `active` column as a soft-delete mechanism; rows where `active = FALSE` are typically excluded from operational logic.