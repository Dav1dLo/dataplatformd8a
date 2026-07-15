# calendar_recurrence

## Source system
This table originates from an Odoo ERP or similar modular business management system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the specific structure of recurrence fields (`rrule`, `rrule_type`, `byday`) are characteristic of Odoo's calendar and scheduling modules.

## Functional process 
This table supports the scheduling and recurring event management process. It defines the logic for repeating calendar events, such as meetings or tasks, by storing the recurrence rules (RRULE) and specific day-of-week flags that determine when an event should trigger in the future.

## Description
One row in this table represents a single recurrence configuration for a calendar event. It acts as a raw landed copy of the recurrence definition, capturing the frequency, duration, and specific day constraints required to calculate event occurrences. Its purpose in the staging layer is to provide the source data for downstream transformation into a usable calendar dimension or event fact table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `calendar_recurrence_id_seq`. |
| base_event_id | INTEGER | true | Reference to the parent event | Likely links to a master event definition. |
| interval | INTEGER | true | Recurrence interval | The frequency multiplier (e.g., every 2 weeks). |
| count | INTEGER | true | Number of occurrences | Total count of repetitions if defined. |
| day | INTEGER | true | Specific day of month | Used for monthly recurrence patterns. |
| trigger_id | INTEGER | true | Trigger reference | Identifier for the associated automation trigger. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | true | Recurrence name | Descriptive label for the recurrence rule. |
| event_tz | VARCHAR | true | Timezone | IANA timezone string for the event. |
| rrule | VARCHAR | true | RFC 5545 RRULE string | The full iCalendar recurrence rule string. |
| rrule_type | VARCHAR | true | Recurrence frequency | e.g., 'daily', 'weekly', 'monthly'. |
| end_type | VARCHAR | true | Termination condition | e.g., 'count', 'until', or 'forever'. |
| month_by | VARCHAR | true | Monthly recurrence logic | e.g., 'date' or 'day'. |
| weekday | VARCHAR | true | Weekday identifier | Used for specific weekly recurrence logic. |
| byday | VARCHAR | true | By-day rule component | iCalendar standard by-day string. |
| until | DATE | true | End date | The date after which the recurrence stops. |
| mon | BOOLEAN | true | Monday flag | Recurrence occurs on Mondays. |
| tue | BOOLEAN | true | Tuesday flag | Recurrence occurs on Tuesdays. |
| wed | BOOLEAN | true | Wednesday flag | Recurrence occurs on Wednesdays. |
| thu | BOOLEAN | true | Thursday flag | Recurrence occurs on Thursdays. |
| fri | BOOLEAN | true | Friday flag | Recurrence occurs on Fridays. |
| sat | BOOLEAN | true | Saturday flag | Recurrence occurs on Saturdays. |
| sun | BOOLEAN | true | Sunday flag | Recurrence occurs on Sundays. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `base_event_id` → `calendar_event.id` (Guess: links to the primary event record).
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not explicitly show a `deleted` or `active` flag; assume all rows are active unless filtered by business logic.
- **RRULE Complexity:** The `rrule` column contains complex string data that may require a parser library to expand into individual event instances.
- **Boolean Flags:** The day-of-week flags (`mon` through `sun`) are denormalized; ensure they are consistent with the `rrule` string if both are present.