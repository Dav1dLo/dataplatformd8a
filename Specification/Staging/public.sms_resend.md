# sms_resend

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of standard Odoo sequence objects for primary key generation.

## Functional process 
This table supports the communication and notification module, specifically tracking the retry logic for SMS messages that failed to deliver. It links specific email-based messages to the SMS resend mechanism, ensuring that failed communications can be re-attempted via SMS.

## Description
One row represents a single request or event to resend an email-based message as an SMS. This is a raw landing table in the staging layer, capturing the audit trail and linkage between the original message and the resend action.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.sms_resend_id_seq`. |
| mail_message_id | INTEGER | false | Foreign key to the source email message | Links to the original message being resent. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who triggered the resend. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id` (Inferred based on Odoo naming conventions for message linkage).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are stored in the server's local time; verify the Odoo instance timezone configuration before performing time-series analysis.
- This table does not implement soft deletes; records are typically permanent unless purged by system maintenance.
- The `create_uid` and `write_uid` columns refer to internal system user IDs and will require a join to the `res_users` table to resolve to human-readable names.