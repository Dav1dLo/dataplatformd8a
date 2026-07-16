# sms_tracker

## Source system
This table originates from an Odoo ERP environment. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the SMS notification tracking process, likely acting as a bridge between email-based notifications and SMS delivery logs. It tracks the lifecycle of SMS messages triggered by system events, linking them to specific mail notifications and auditing the users responsible for their creation and modification.

## Description
One row in this table represents a single SMS tracking event or delivery attempt. It serves as a raw landing record in the staging layer, capturing the unique identifier for an SMS message and its association with a parent mail notification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| mail_notification_id | INTEGER | true | Foreign key to mail notification | Links the SMS to a specific email notification event. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the SMS record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| sms_uuid | VARCHAR | false | Unique SMS identifier | The business-level unique identifier for the SMS message. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp of when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_notification_id` → `mail_notification.id` (Guess: links to the primary notification record).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** 
    - `sms_uuid` (This appears to be the unique business key for the SMS message).

## Caveats for downstream consumers

- **Sensitive Data:** The `create_uid` and `write_uid` columns link to internal user IDs; ensure these are mapped to human-readable names via the appropriate user dimension table.
- **Timezone:** Timestamps are assumed to be in UTC, as is standard for Odoo PostgreSQL deployments, but verify against the application server configuration.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Data Precision:** The `sms_uuid` column is defined as `VARCHAR` without a specified length; downstream systems should be prepared for varying string lengths.