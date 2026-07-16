# mail_message_schedule

## Source system
This table originates from an Odoo ERP environment, evidenced by the naming convention of the primary key sequence (`"public".mail_message_schedule_id_seq`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the specific table naming pattern common to Odoo's messaging/notification modules.

## Functional process 
This table supports the automated communication and notification pipeline. It manages the temporal scheduling of outgoing messages, ensuring that notifications or emails linked to specific system events are dispatched at the correct `scheduled_datetime` rather than being sent immediately upon trigger.

## Description
One row represents a single scheduled instance of a message or notification linked to a parent message entity. It acts as a staging queue entry that dictates when a specific communication should be processed by the system's background workers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| mail_message_id | INTEGER | false | Foreign key to the parent message | Links to the core message content. |
| create_uid | INTEGER | true | ID of the user who created the schedule | References the users table. |
| write_uid | INTEGER | true | ID of the user who last updated the schedule | References the users table. |
| notification_parameters | TEXT | true | JSON or serialized config for the notification | Likely contains delivery preferences or metadata. |
| scheduled_datetime | TIMESTAMP | false | Target execution time | The time the message is intended to be sent. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed based on Odoo standards. |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id`: This column links the schedule to the primary message record.
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `notification_parameters` column may contain PII or internal system configuration details; ensure this is masked if exposed to non-privileged users.
- **Timezones:** Timestamps are stored in the database server's local time (typically UTC in Odoo deployments); verify the application server configuration if converting to local timezones.
- **Soft Deletes:** This table does not appear to implement a `deleted` or `active` flag; assume records are removed physically if they disappear.
- **Data Format:** The `notification_parameters` column is stored as `TEXT` but likely contains structured JSON; downstream parsers should handle potential serialization errors.