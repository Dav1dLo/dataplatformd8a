# calendar_alarm

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for multi-language fields (`name`), and the sequence-based primary key pattern.

## Functional process 
This table supports the calendar notification and reminder configuration process. It defines the parameters for how and when users are alerted regarding calendar events, including email and SMS notification templates, timing intervals, and alarm types.

## Description
One row in this table represents a single configured alarm or reminder definition used within the calendar module. It acts as a raw landed copy of the configuration settings, storing the timing logic and associated communication templates for event notifications.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| duration | INTEGER | false | Alarm duration value | Unit depends on the `interval` column. |
| duration_minutes | INTEGER | true | Duration normalized to minutes | Calculated field for easier filtering. |
| mail_template_id | INTEGER | true | Foreign key to email template | Links to the email notification definition. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| alarm_type | VARCHAR | false | Type of alarm | e.g., 'email', 'sms', 'notification'. |
| interval | VARCHAR | false | Time unit for duration | e.g., 'minutes', 'hours', 'days'. |
| name | JSONB | false | Alarm display name | Multi-language string storage. |
| body | TEXT | true | Alarm description or content | Optional text body for the alarm. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| sms_template_id | INTEGER | true | Foreign key to SMS template | Links to the SMS notification definition. |
| sms_notify_responsible | BOOLEAN | true | SMS notification flag | Indicates if the responsible party is notified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_template_id` → `mail_template.id` (Guess: standard Odoo naming for email templates).
    - `sms_template_id` → `sms_template.id` (Guess: standard Odoo naming for SMS templates).
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user-related IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Assumed to be in UTC; verify against Odoo system configuration if local time offsets are observed.
- **Data Integrity:** The `name` column is `JSONB`; ensure your downstream processing handles JSON extraction (e.g., `name->>'en_US'`).
- **Soft Deletes:** This table does not appear to have an `active` or `deleted` flag; assume all rows are current unless otherwise specified by the source system's business logic.