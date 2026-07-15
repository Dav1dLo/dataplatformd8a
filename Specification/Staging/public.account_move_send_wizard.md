# account_move_send_wizard

## Source system
This table originates from Odoo ERP. The naming convention `account_move_send_wizard` and the presence of `create_uid`, `write_uid`, and `JSONB` fields for widget configurations are characteristic of Odoo's transient model (wizard) architecture used for handling document workflows.

## Functional process 
This table supports the "Invoice/Journal Entry Sending" process. It acts as a temporary state container for the wizard interface that allows users to configure how an accounting move (invoice or credit note) is dispatched, including email templates, PDF report generation, and electronic data interchange (EDI) settings.

## Description
One row represents a single execution instance of the "Send & Print" wizard for a specific accounting move. It captures the user's configuration choices, such as email content, selected sending methods, and attachment metadata, before the final dispatch action is triggered. This is a raw landing table representing the transient state of the wizard session.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| move_id | INTEGER | false | Foreign key to the accounting move | The target document being processed. |
| pdf_report_id | INTEGER | true | Foreign key to report definition | The specific PDF template selected for printing. |
| mail_template_id | INTEGER | true | Foreign key to email template | The template used to construct the email body. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the wizard state. |
| mail_subject | VARCHAR | true | Email subject line | The subject text configured for the outgoing email. |
| sending_method_checkboxes | JSONB | true | Sending method configuration | Stores boolean flags for methods like 'email', 'print', or 'edi'. |
| extra_edi_checkboxes | JSONB | true | EDI configuration | Stores specific EDI format toggles. |
| mail_attachments_widget | JSONB | true | Attachment metadata | Stores state for files attached to the email. |
| mail_body | TEXT | true | Email body content | The HTML or plain text content of the email. |
| create_date | TIMESTAMP | true | Creation timestamp | When the wizard session was initialized. |
| write_date | TIMESTAMP | true | Last update timestamp | When the wizard configuration was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `move_id` → `account_move.id` (Inferred from Odoo naming convention for accounting entries).
    - `pdf_report_id` → `ir_actions_report.id` (Inferred from standard Odoo report linkage).
    - `mail_template_id` → `mail_template.id` (Inferred from standard Odoo email template linkage).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable. This is a transient wizard table and may not have a unique business key outside of the surrogate `id`.

## Caveats for downstream consumers

- **Transient Data:** As a wizard table, rows may be ephemeral or cleared periodically by the source system; do not rely on this for long-term audit trails of sent emails.
- **JSONB Complexity:** The `sending_method_checkboxes`, `extra_edi_checkboxes`, and `mail_attachments_widget` columns contain nested JSON structures; ensure your downstream pipeline has a strategy for flattening these if needed.
- **Timestamps:** Timestamps are assumed to be in the system's local time (typically UTC in Odoo deployments, but verify against `ir.config_parameter` if possible).
- **Sensitive Data:** `mail_body` and `mail_subject` may contain PII or sensitive business communication; apply appropriate masking if exposing to non-authorized users.