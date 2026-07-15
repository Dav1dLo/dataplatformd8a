# ir_cron_trigger

## Source system
This table originates from an Odoo ERP system, as indicated by the `ir_cron_trigger` naming convention, which is a standard internal registry table (`ir` prefix) used by the Odoo framework to manage scheduled action triggers.

## Functional process 
This table supports the background task scheduling and automation engine. It tracks specific trigger events for scheduled actions (cron jobs), determining when a task is queued to run and maintaining audit trails for the creation and modification of these trigger records.

## Description
One row represents a single scheduled execution event for a background task within the Odoo system. It serves as a raw landing record in the staging layer, capturing the timestamp for the intended execution and the user context associated with the trigger's lifecycle.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_cron_trigger_id_seq`. |
| cron_id | INTEGER | true | Foreign key to the scheduled action definition | Links to the `ir_cron` table. |
| create_uid | INTEGER | true | User ID who created the trigger | Links to `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the trigger | Links to `res_users` table. |
| call_at | TIMESTAMP | true | Scheduled execution time | The timestamp when the task is intended to run. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC based on Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `cron_id` → `ir_cron.id`: This column references the definition of the scheduled task being triggered.
    - `create_uid` → `res_users.id`: This column references the user who initiated the trigger record.
    - `write_uid` → `res_users.id`: This column references the user who last updated the trigger record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`call_at`, `create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's internal storage practices.
- This table is a high-churn operational log; expect frequent inserts and deletions as tasks are queued and subsequently processed.
- No PII is explicitly contained in this table, though `create_uid` and `write_uid` link to user identity records.
- The `cron_id` may be null if the underlying scheduled action definition has been deleted or if the trigger is orphaned.