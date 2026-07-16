# mail_notification

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `res_partner_id`, `mail_message_id`, `mail_mail_id`) and the specific sequence-based primary key pattern are characteristic of the Odoo framework's messaging and notification module.

## Functional process 
This table supports the communication and notification tracking process. It records the delivery status and interaction state of messages sent to partners, including email, SMS, and physical letter notifications, linking them back to the core messaging system.

## Description
One row in this table represents a single notification event sent to a specific recipient regarding a mail message. It serves as a raw landing copy of the notification state, tracking whether a message was delivered, read, or failed, and providing context for the communication channel used.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mail_notification_id_seq`. |
| author_id | INTEGER | true | ID of the user who triggered the notification | References `res_users`. |
| mail_message_id | INTEGER | false | ID of the parent message | References `mail_message`. |
| mail_mail_id | INTEGER | true | ID of the email record | References `mail_mail`. |
| res_partner_id | INTEGER | true | ID of the recipient | References `res_partner`. |
| notification_type | VARCHAR | false | Channel type (e.g., email, sms, inbox) | |
| notification_status | VARCHAR | true | Current delivery state | |
| failure_type | VARCHAR | true | Categorized reason for delivery failure | |
| failure_reason | TEXT | true | Detailed error message | |
| is_read | BOOLEAN | true | Read receipt flag | |
| read_date | TIMESTAMP | true | Timestamp when the notification was read | |
| sms_id_int | INTEGER | true | ID of the associated SMS record | References `sms_sms`. |
| sms_number | VARCHAR | true | Phone number used for SMS delivery | |
| letter_id | INTEGER | true | ID of the associated physical letter | References `mail_mass_mailing_letter`. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `author_id` → `res_users.id` (Inferred from Odoo naming conventions for user-linked fields).
    - `mail_message_id` → `mail_message.id` (Inferred from Odoo messaging architecture).
    - `res_partner_id` → `res_partner.id` (Inferred from Odoo standard partner linkage).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `sms_number` column contains PII (phone numbers) and should be masked or restricted based on data governance policies.
- **Timezone:** Timestamps are typically stored in UTC in Odoo, but verify against the application server configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are removed if deleted in the source.
- **Data Integrity:** `mail_mail_id`, `sms_id_int`, and `letter_id` are mutually exclusive depending on the `notification_type`. Expect high sparsity in these columns.