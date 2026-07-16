# mail_scheduled_message

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the naming convention of the primary key sequence (`mail_scheduled_message_id_seq`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the `res_id`/`model` pattern used to link records to arbitrary business objects.

## Functional process 
This table supports the automated communication and notification engine within the platform. It manages the queue of messages (emails or internal notes) that are scheduled to be sent at a future time, linking them to specific business entities (e.g., a sales order or a CRM lead) via the `model` and `res_id` columns.

## Description
One row in this table represents a single scheduled communication or notification record waiting to be processed by the system's mail scheduler. It serves as a raw staging entity, capturing the content, target business object, and intended delivery timing for outgoing messages before they are dispatched.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo. |
| res_id | INTEGER | false | Related record ID | The ID of the object in the source system being referenced. |
| author_id | INTEGER | false | Author user ID | The ID of the user who initiated the message. |
| create_uid | INTEGER | true | Creator user ID | The ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | The ID of the user who last updated the record. |
| subject | VARCHAR | true | Message subject | The email subject line. |
| model | VARCHAR | false | Related model name | The technical name of the Odoo model (e.g., 'sale.order'). |
| body | TEXT | true | Message content | The HTML or plain text body of the message. |
| notification_parameters | TEXT | true | Notification config | JSON or serialized parameters for the notification engine. |
| is_note | BOOLEAN | true | Note flag | If true, indicates this is an internal note rather than an email. |
| scheduled_date | TIMESTAMP | false | Scheduled execution time | The timestamp when the message is intended to be sent. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last record modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `author_id` → `res_users.id` (Guess: links to the system user table).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit link).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit link).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` and `subject` columns may contain PII or sensitive business communication; ensure appropriate masking in downstream reporting layers.
- **Timezones:** Timestamps are stored in the database's local time (typically UTC in Odoo deployments), but verify against the application server configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely removed physically upon processing or cancellation.
- **Data Grain:** The `model` and `res_id` columns form a polymorphic association; queries joining this table must filter by `model` to ensure correct joins to parent entities.