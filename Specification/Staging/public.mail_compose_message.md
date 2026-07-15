# mail_compose_message

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `res_domain_user_id`, `mail_activity_type_id`, `xmlid`) and the structure of the message composition model are characteristic of the Odoo `mail` module, which handles internal and external communication workflows.

## Functional process 
This table supports the communication and notification engine within the ERP. It acts as a staging area for drafting, configuring, and triggering emails or internal messages linked to specific business records (e.g., sales orders, invoices, or CRM leads) before they are dispatched via the mail server.

## Description
One row represents a single message composition draft or a record of a message being prepared for dispatch. It captures the metadata, content, and configuration settings (such as auto-delete policies and sender identity) required to process a communication event. This is a raw landed copy of the Odoo `mail.compose.message` model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| template_id | INTEGER | true | Foreign key to email template | Links to the template used for the body. |
| parent_id | INTEGER | true | Parent message ID | Used for threading/replies. |
| author_id | INTEGER | true | Author user/partner ID | The sender of the message. |
| res_domain_user_id | INTEGER | true | Associated user ID | Contextual user for the domain. |
| record_alias_domain_id | INTEGER | true | Alias domain ID | Routing domain for the message. |
| record_company_id | INTEGER | true | Company ID | Multi-company context. |
| subtype_id | INTEGER | true | Message subtype ID | Categorizes the message type (e.g., comment, notification). |
| mail_activity_type_id | INTEGER | true | Activity type ID | Links to specific CRM/Project activities. |
| mail_server_id | INTEGER | true | Mail server ID | Outgoing SMTP server configuration. |
| create_uid | INTEGER | true | Creator user ID | User who initiated the draft. |
| write_uid | INTEGER | true | Last modifier user ID | User who last updated the draft. |
| lang | VARCHAR | true | Language code | ISO code for email localization. |
| subject | VARCHAR | true | Email subject line | The display subject of the message. |
| email_layout_xmlid | VARCHAR | true | Layout XML ID | Reference to the email template layout. |
| email_from | VARCHAR | true | Sender email address | The 'From' field value. |
| composition_mode | VARCHAR | true | Composition mode | e.g., 'comment', 'mass_mail'. |
| model | VARCHAR | true | Target model name | The Odoo model the message is linked to. |
| record_name | VARCHAR | true | Target record name | Display name of the linked record. |
| message_type | VARCHAR | false | Message type | e.g., 'email', 'comment', 'notification'. |
| reply_to | VARCHAR | true | Reply-to address | Override for reply-to headers. |
| scheduled_date | VARCHAR | true | Scheduled send date | Stored as string; likely ISO format. |
| template_name | VARCHAR | true | Template name | Denormalized name of the template. |
| body | TEXT | true | Message content | HTML or plain text body. |
| res_ids | TEXT | true | Target record IDs | List of IDs the message applies to. |
| res_domain | TEXT | true | Target domain | Domain filter for mass mailing. |
| email_add_signature | BOOLEAN | true | Append signature flag | Whether to include user signature. |
| reply_to_force_new | BOOLEAN | true | Force new thread flag | Whether to ignore existing threads. |
| auto_delete | BOOLEAN | true | Auto-delete flag | Whether to delete after sending. |
| auto_delete_keep_log | BOOLEAN | true | Keep log flag | Whether to retain log after auto-delete. |
| force_send | BOOLEAN | true | Force send flag | Whether to bypass queue and send immediately. |
| use_exclusion_list | BOOLEAN | true | Exclusion list flag | Whether to check against opt-out lists. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `template_id` → `mail_template.id` (Likely target for email templates)
    - `author_id` → `res_partner.id` (Likely target for message authors)
    - `mail_server_id` → `ir_mail_server.id` (Likely target for SMTP configurations)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` and `email_from` columns may contain PII or sensitive business communication.
- **Timestamps:** `create_date` and `write_date` are generally stored in UTC in Odoo.
- **Data Types:** `scheduled_date` is stored as a `VARCHAR` despite representing a temporal value; ensure casting to `TIMESTAMP` is handled in downstream transformations.
- **Soft Deletes:** This table represents a staging/drafting area; records may be purged by the Odoo `mail` cleanup cron jobs.