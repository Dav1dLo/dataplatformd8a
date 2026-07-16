# mail_resend_message

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming convention (`mail_resend_message`), the use of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the sequence-based default value for the primary key.

## Functional process 
This table supports the email communication and notification module, specifically tracking the retry logic for failed outgoing messages. It acts as a staging record for messages that require a secondary attempt to be delivered to the recipient.

## Description
One row in this table represents a single retry event or configuration for a specific email message that failed to send. It serves as a raw landing copy of the Odoo `mail.resend.message` model, capturing the audit trail and the association to the original message.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.mail_resend_message_id_seq`. |
| mail_message_id | INTEGER | true | Foreign key to the original mail message | Links to the `mail_message` table. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users` table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users` table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id` (Likely target based on naming convention).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit columns).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit columns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains no PII directly, but `mail_message_id` may link to tables containing sensitive email content.
- The table tracks metadata for resend attempts; it does not necessarily contain the email body or recipient address directly.
- No soft-delete flag is present; assume records are hard-deleted if they disappear from the source.