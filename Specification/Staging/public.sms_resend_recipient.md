# sms_resend_recipient

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, alongside the use of `nextval` sequences, is characteristic of Odoo's ORM-generated audit and tracking fields.

## Functional process 
This table supports the notification and communication management process, specifically tracking the recipients of SMS resend operations. It links individual notification events to specific recipients and tracks whether a resend action is required for a given contact.

## Description
One row in this table represents a single recipient associated with a specific SMS resend event. It serves as a staging record that captures the recipient's contact details and the status of the resend request, acting as a raw landing copy of the operational communication log.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `sms_resend_recipient_id_seq`. |
| sms_resend_id | INTEGER | false | Foreign key to the parent SMS resend batch | Links to the main resend operation. |
| notification_id | INTEGER | false | Foreign key to the notification system | Identifies the original notification event. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user table. |
| partner_name | VARCHAR | true | Name of the recipient | Denormalized contact name. |
| sms_number | VARCHAR | true | Recipient phone number | Target number for the SMS. |
| resend | BOOLEAN | true | Resend status flag | Indicates if the SMS should be resent. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sms_resend_id` → `sms_resend.id` (Guess: links to the parent resend batch header).
    - `notification_id` → `mail_notification.id` (Guess: links to the core notification entity).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `sms_number` column contains PII (phone numbers) and should be masked in non-production environments.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, but verify against the source system's timezone configuration.
- **Data Integrity:** As a staging table, this may contain duplicates or incomplete records if the source system performs partial updates or retries.
- **Soft Deletes:** There is no explicit `active` or `deleted` flag; assume all records are current unless otherwise specified by the source system logic.