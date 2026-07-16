# mail_resend_partner

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`resend_partner`, `resend_wizard_id`), the use of `create_uid`/`write_uid` audit columns, and the standard sequence-based primary key pattern (`nextval` on `_id_seq`).

## Functional process 
This table supports the email communication and notification retry process. It tracks which specific partners (recipients) are associated with a failed email notification that is being processed for a retry via a "resend wizard," allowing the system to manage individual delivery statuses during bulk communication recovery.

## Description
One row represents a single recipient's association with a specific email notification retry event. This is a raw landing table in the Staging layer, capturing the state of the `mail.resend.partner` model from the source ERP to facilitate audit trails and retry logic tracking.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| notification_id | INTEGER | false | Foreign key to the notification | Links to the parent email notification record. |
| resend_wizard_id | INTEGER | true | Foreign key to the resend wizard | Links to the specific wizard session managing the retry. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| message | VARCHAR | true | Error or status message | Contains details regarding the delivery failure or retry status. |
| resend | BOOLEAN | true | Resend flag | Indicates if this specific partner is marked for retry. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp of when the record was inserted. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `notification_id` → `mail_notification.id` (Guess: standard Odoo naming for notification links).
    - `resend_wizard_id` → `mail_resend_wizard.id` (Guess: standard Odoo naming for wizard links).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Sensitivity:** The `message` column may contain PII or specific error details related to email delivery failures; ensure appropriate masking if exposed to non-admin users.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.
- **Data Quality:** `resend_wizard_id` is nullable, implying some records may exist outside of an active wizard session or represent historical data where the wizard context was lost.