# project_task_recurrence

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based defaults for the primary key.

## Functional process 
This table supports the project management module's recurring task functionality. It defines the scheduling logic for tasks that repeat over time, such as daily, weekly, or monthly maintenance or reporting cycles, by storing the frequency, unit, and termination criteria.

## Description
One row in this table represents a single recurrence rule configuration for a project task. It serves as a raw landed staging entity, capturing the parameters required to calculate future task instances based on a defined interval and duration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `project_task_recurrence_id_seq`. |
| repeat_interval | INTEGER | true | Frequency multiplier | The numeric value for the interval (e.g., 2 for "every 2 weeks"). |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created the rule. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the rule. |
| repeat_unit | VARCHAR | true | Time unit of recurrence | Expected values: 'day', 'week', 'month', 'year'. |
| repeat_type | VARCHAR | true | Recurrence termination type | Defines if the rule ends after a date or count (e.g., 'forever', 'until'). |
| repeat_until | DATE | true | Recurrence end date | The date after which the task should no longer repeat. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC.
- **Data Integrity:** The `repeat_unit` and `repeat_type` columns are free-text `VARCHAR` fields; expect inconsistent casing or unexpected values if the source application logic is bypassed.
- **Soft Deletes:** This table does not appear to have a dedicated `active` or `deleted_at` flag; assume all rows are active unless filtered by business logic in the source system.
- **PII:** No direct PII is present, though `create_uid` and `write_uid` link to user identity tables.