# privacy_log

## Source system
This table likely originates from an Odoo ERP or a similar modular business application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of `nextval` sequences for primary keys, is a signature pattern for Odoo's ORM-based audit and logging framework.

## Functional process 
This table supports the data privacy and compliance process, specifically tracking requests or actions related to user data anonymization (e.g., GDPR "Right to be Forgotten" requests). It logs which user's data was processed, who performed the action, and the specific details of the records affected.

## Description
One row in this table represents a single privacy-related event or anonymization request performed within the system. It serves as a raw, append-only audit log in the staging layer, capturing the state of anonymized identifiers and the metadata surrounding the execution of privacy-related tasks.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.privacy_log_id_seq`. |
| user_id | INTEGER | false | Target user identifier | Foreign key to the system's user table. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the log entry. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this log entry. |
| anonymized_name | VARCHAR | false | Anonymized name string | The masked or hashed version of the user's name. |
| anonymized_email | VARCHAR | false | Anonymized email string | The masked or hashed version of the user's email. |
| execution_details | TEXT | true | Technical execution log | Details regarding the anonymization process. |
| records_description | TEXT | true | Affected records summary | Description of which records were anonymized. |
| additional_note | TEXT | true | Supplemental information | Free-text field for manual notes. |
| date | TIMESTAMP | false | Event timestamp | The date/time the privacy event occurred. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp when this log row was inserted. |
| write_date | TIMESTAMP | true | Record modification timestamp | Timestamp when this log row was last updated. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: Standard Odoo pattern for user-linked logs).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo pattern for audit trails).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo pattern for audit trails).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains `anonymized_name` and `anonymized_email`. While these are intended to be anonymized, they should be treated as PII-adjacent and access-controlled.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments, but should be verified against the source system configuration.
- **Data Integrity:** The `anonymized_name` and `anonymized_email` columns are `VARCHAR` without defined lengths; downstream systems should be prepared for varying string lengths.
- **Audit Pattern:** This is an append-only audit log; there is no evidence of soft-delete flags, as the table itself represents a historical record of actions.