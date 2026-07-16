# sale_order_cancel

## Source system
The table originates from an Odoo ERP system, as evidenced by the naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys (`nextval('"public".sale_order_cancel_id_seq'::regclass)`).

## Functional process 
This table supports the sales order cancellation workflow, specifically tracking the communication or template-based notifications sent when an order is cancelled. It captures the context of the cancellation, including the user who initiated the action, the language used, and the content of the notification message.

## Description
One row in this table represents a single cancellation event or notification record associated with a sales order. It serves as a raw landed staging entity, preserving the audit trail and communication details generated during the order cancellation process in the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| template_id | INTEGER | true | Foreign key to email/message template | References the template used for the cancellation notice. |
| author_id | INTEGER | true | Foreign key to user/partner | The entity or user who authored the cancellation message. |
| order_id | INTEGER | false | Foreign key to sale_order | The specific sales order being cancelled. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| lang | VARCHAR | true | Language code | ISO language code (e.g., 'en_US') used for the message. |
| subject | VARCHAR | true | Message subject | The subject line of the cancellation notification. |
| body | TEXT | true | Message content | The full text body of the cancellation notification. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `order_id` → `sale_order.id`: Links the cancellation record to the parent sales order.
    - `author_id` → `res_partner.id` (guess): Likely references the user or partner who authored the message.
    - `template_id` → `mail_template.id` (guess): Likely references the email template used for the notification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` column may contain PII or internal communication details; ensure appropriate masking if exposing to non-authorized users.
- **Timezones:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments, but should be verified against source system configuration.
- **Data Integrity:** As a staging table, this may contain multiple versions of the same event if the source system performs updates; check `write_date` to identify the most recent state.
- **Nullability:** Many fields (e.g., `template_id`, `author_id`) are nullable, suggesting that not all cancellations are triggered via the standard template-based notification system.