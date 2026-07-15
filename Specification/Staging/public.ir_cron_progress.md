# ir_cron_progress

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_cron_*` is characteristic of Odoo's "Internal Resource" (ir) module, which manages scheduled actions and background tasks.

## Functional process 
This table supports the background task management and job scheduling process. It tracks the execution progress, completion status, and timeout metrics for scheduled cron jobs, ensuring the system can monitor long-running background operations.

## Description
One row in this table represents the current execution state and progress metrics for a specific scheduled background task. It serves as a raw landing copy of the Odoo internal cron progress tracking table, used to monitor the health and completion status of automated system jobs.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `ir_cron_progress_id_seq`. |
| cron_id | INTEGER | false | Foreign key to the scheduled action | Links to the `ir_cron` definition table. |
| remaining | INTEGER | true | Count of items left to process | Represents work units pending completion. |
| done | INTEGER | true | Count of items completed | Represents work units finished. |
| timed_out_counter | INTEGER | true | Number of timeout occurrences | Tracks how many times the job has failed due to timeout. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| deactivate | BOOLEAN | true | Deactivation flag | Indicates if the progress tracking is disabled. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standards. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `cron_id` → `ir_cron.id`: This column links the progress record to the specific scheduled action definition.
    - `create_uid` → `res_users.id`: Standard Odoo audit field referencing the creator.
    - `write_uid` → `res_users.id`: Standard Odoo audit field referencing the last modifier.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Odoo stores timestamps in UTC; ensure downstream transformations account for this if local time conversion is required.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; however, the `deactivate` boolean may serve a similar functional purpose for the cron job logic.
- **Data Integrity:** As a staging table, this may contain transient states; ensure queries filter for the most recent `write_date` if looking for the current status of a job.
- **Sensitive Data:** Contains `create_uid` and `write_uid`, which link to user identity records; ensure access is restricted according to internal PII policies.