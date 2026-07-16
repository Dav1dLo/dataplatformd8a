# resource_calendar

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `nextval` sequences for primary keys.

## Functional process 
This table supports the Human Resources and Project Management modules by defining working time schedules. It is used to calculate resource availability, capacity planning, and project scheduling by defining standard working hours, time zones, and flexibility settings for employees or equipment.

## Description
One row in this table represents a single working time definition or calendar profile. It acts as a raw landed copy of the Odoo `resource.calendar` model, capturing the configuration parameters that dictate how time is tracked against resources within the organization.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `resource_calendar_id_seq`. |
| company_id | INTEGER | true | Foreign key to the owning company | Links to the company record. |
| create_uid | INTEGER | true | User ID who created the record | References the `res.users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res.users` table. |
| name | VARCHAR | false | Name of the calendar | Descriptive label for the schedule. |
| tz | VARCHAR | false | Timezone identifier | IANA timezone string (e.g., 'UTC'). |
| hours_per_day | NUMERIC | true | Standard working hours per day | Used for capacity calculations. |
| active | BOOLEAN | true | Soft-delete flag | If false, the calendar is archived. |
| two_weeks_calendar | BOOLEAN | true | Bi-weekly schedule flag | Indicates if the calendar spans two weeks. |
| flexible_hours | BOOLEAN | true | Flexible hours enabled | Indicates if the resource has flexible start/end times. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| full_time_required_hours | DOUBLE PRECISION | true | Full-time equivalent hours | Total hours required for a full-time status. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Inferred from Odoo standard naming).
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may be linked to employee identities.
- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = TRUE` unless historical/archived data is explicitly required.
- **Precision:** `VARCHAR` columns do not have defined lengths in the metadata; downstream consumers should account for variable-length strings.