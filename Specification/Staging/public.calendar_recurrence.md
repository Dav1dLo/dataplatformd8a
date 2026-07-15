# calendar_recurrence

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, and `write_date` audit columns, alongside the specific structure of recurrence rule fields (`rrule`, `rrule_type`, `byday`).

## Functional process 
This table supports the scheduling and calendar management module, specifically handling the logic for recurring events. It defines the frequency and duration patterns for events that repeat over time, allowing the system to calculate future occurrences based on the stored recurrence rules.

## Description
One row in this table represents a single recurrence rule definition linked to a base calendar event. It acts as a raw landed copy of the recurrence configuration, storing parameters like frequency, end dates, and specific days of the week to determine when an event should repeat.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| base_event_id | INTEGER | true | Reference to the parent event | Likely links to a `calendar_event` table. |
| interval | INTEGER | true | Frequency interval | e.g., "every 2 weeks". |
| count | INTEGER | true | Number of occurrences | Used if the recurrence is limited by count. |
| day | INTEGER | true | Specific day of the month | Used for monthly recurrence patterns. |
| trigger_id | INTEGER | true | Trigger reference | Internal Odoo reference for automation. |
| create_uid | INTEGER | true | Creator user ID | Links to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res_users`. |
| name | VARCHAR | true | Rule description | Human-readable name of the rule. |
| event_tz | VARCHAR | true | Timezone | IANA timezone string (e.g., 'UTC'). |
| rrule | VARCHAR | true | iCalendar RRULE string | Standard RFC 5545 recurrence rule. |
| rrule_type | VARCHAR | true | Recurrence frequency | e.g., 'daily', 'weekly', 'monthly'. |
| end_type | VARCHAR | true | Termination condition | e.g., 'count', 'until', 'forever'. |
| month_by | VARCHAR | true | Monthly recurrence logic | 'date' or 'day'. |
| weekday | VARCHAR | true | Day of week | Used for weekly/monthly rules. |
| byday | VARCHAR | true | Specific day pattern | e.g., '1MO' for first Monday. |
| until | DATE | true | End date | The date the recurrence stops. |
| mon | BOOLEAN | true | Monday flag | Weekly recurrence toggle. |
| tue | BOOLEAN | true | Tuesday flag | Weekly recurrence toggle. |
| wed | BOOLEAN | true | Wednesday flag | Weekly recurrence toggle. |
| thu | BOOLEAN | true | Thursday flag | Weekly recurrence toggle. |
| fri | BOOLEAN | true | Friday flag | Weekly recurrence toggle. |
| sat | BOOLEAN | true | Saturday flag | Weekly recurrence toggle. |
| sun | BOOLEAN | true | Sunday flag | Weekly recurrence toggle. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `base_event_id` → `calendar_event.id` (Inferred from standard Odoo naming patterns for event-linked tables).
    - `create_uid` → `res_users.id` (Standard Odoo audit column pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit column pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC, consistent with Odoo's internal handling.
- **Soft Deletes:** This table does not appear to implement a `deleted` or `active` flag; assume standard CRUD behavior.
- **Data Integrity:** The `rrule` column is the source of truth for the recurrence logic; downstream consumers should prioritize parsing this string over the individual boolean flags (`mon`, `tue`, etc.) if discrepancies arise.
- **PII:** No direct PII is present, but `create_uid` and `write_uid` link to user identities.