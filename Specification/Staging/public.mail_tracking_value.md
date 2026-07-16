# mail_tracking_value

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mail_message_id`, `create_uid`, `write_uid`) and the specific pattern of tracking field changes across multiple data types (integer, char, text, datetime, float) within a centralized audit log.

## Functional process 
This table supports the "Audit Logging" or "Change Tracking" process within the Odoo mail/chatter framework. It records historical state changes for fields on tracked business objects, allowing the system to display "chatter" history showing what values were modified, by whom, and when.

## Description
One row represents a single field-level value change associated with a specific mail message or audit event. It acts as a raw landing copy of the Odoo `mail.tracking.value` model, capturing the transition from an old value to a new value across various data types.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| field_id | INTEGER | true | Reference to the tracked field | Links to the field definition metadata. |
| old_value_integer | INTEGER | true | Previous integer value | Used for integer-type fields. |
| new_value_integer | INTEGER | true | New integer value | Used for integer-type fields. |
| currency_id | INTEGER | true | Currency reference | Used if the tracked value is monetary. |
| mail_message_id | INTEGER | false | Parent audit event ID | Links to the `mail.message` record. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this log entry. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified this log entry. |
| old_value_char | VARCHAR | true | Previous character value | Used for short string fields. |
| new_value_char | VARCHAR | true | New character value | Used for short string fields. |
| field_info | JSONB | true | Field metadata | Contains additional context about the field. |
| old_value_text | TEXT | true | Previous text value | Used for long text fields. |
| new_value_text | TEXT | true | New text value | Used for long text fields. |
| old_value_datetime | TIMESTAMP | true | Previous datetime value | Used for date/time fields. |
| new_value_datetime | TIMESTAMP | true | New datetime value | Used for date/time fields. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit timestamp. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit timestamp. |
| old_value_float | DOUBLE PRECISION | true | Previous float value | Used for numeric/decimal fields. |
| new_value_float | DOUBLE PRECISION | true | New float value | Used for numeric/decimal fields. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `mail_message_id` → `mail_message.id`: This column links the tracking value to the parent message record that triggered the audit.
    - `create_uid` → `res_users.id`: Guessed based on Odoo standard naming for user references.
    - `write_uid` → `res_users.id`: Guessed based on Odoo standard naming for user references.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** This table may contain PII or sensitive business data depending on which fields are being tracked (e.g., changes to customer contact info or financial amounts).
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sparsity:** This table is highly sparse; for any given row, only one pair of `old_value_*` / `new_value_*` columns will be populated based on the data type of the field being tracked.
- **Soft Deletes:** This table does not appear to implement soft deletes; it acts as an append-only audit log.