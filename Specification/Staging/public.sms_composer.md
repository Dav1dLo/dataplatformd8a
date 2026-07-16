# sms_composer

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the characteristic naming conventions such as `res_id`, `res_model`, `create_uid`, `write_uid`, and the use of `nextval` sequences for primary keys.

## Functional process 
This table supports the SMS marketing and communication module, specifically the "SMS Composer" wizard process. It manages the state of SMS drafts, template selection, and recipient targeting before messages are dispatched to the SMS gateway.

## Description
One row represents a single SMS composition session or draft created by a user within the Odoo interface. It captures the message body, the target record context (model and IDs), and configuration flags for mass mailing operations. This is a raw staging table representing the transient state of the composer before final message generation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sms_composer_id_seq`. |
| res_id | INTEGER | true | Target record ID | The specific ID of the record being messaged. |
| template_id | INTEGER | true | SMS template reference | Foreign key to the SMS template definition. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who initiated the composition. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| composition_mode | VARCHAR | false | Mode of operation | e.g., 'comment', 'mass'. |
| res_model | VARCHAR | true | Target model name | The Odoo technical name of the model (e.g., 'res.partner'). |
| res_ids | VARCHAR | true | Target record IDs | A string representation of multiple record IDs. |
| recipient_single_number_itf | VARCHAR | true | Single recipient number | Interface field for a direct phone number input. |
| number_field_name | VARCHAR | true | Target field name | The field on the target model containing the phone number. |
| numbers | VARCHAR | true | Recipient list | A string list of phone numbers for mass messaging. |
| body | TEXT | false | SMS content | The actual text message body. |
| mass_keep_log | BOOLEAN | true | Log flag | Whether to keep a log of the mass SMS operation. |
| mass_force_send | BOOLEAN | true | Force send flag | Whether to bypass queueing and send immediately. |
| mass_use_blacklist | BOOLEAN | true | Blacklist flag | Whether to check against the SMS blacklist. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `template_id` → `sms_template.id` (Inferred from Odoo naming conventions).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` column may contain PII or sensitive customer information; ensure appropriate masking if exposed to non-authorized users.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** `res_ids` and `numbers` are stored as `VARCHAR` but likely contain serialized data (e.g., comma-separated strings or JSON); parsing will be required for analysis.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are physically deleted if removed from the source.