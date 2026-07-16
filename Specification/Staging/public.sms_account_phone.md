# sms_account_phone

## Source system
The table likely originates from an Odoo ERP or a similar modular business application, evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo framework.

## Functional process 
This table supports the communication management process, specifically mapping phone numbers to specific accounts within an SMS messaging or notification module. It facilitates the association of contact points with organizational entities to enable targeted messaging workflows.

## Description
One row in this table represents a single phone number associated with a specific account. It serves as a raw landed copy of the source system's phone number registry, maintaining the link between account entities and their registered communication channels.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.sms_account_phone_id_seq`. |
| account_id | INTEGER | false | Foreign key to the account | Links to the parent account entity. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who performed the initial insertion. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who performed the last modification. |
| phone_number | VARCHAR | false | Phone number string | Expected to be in E.164 or local format; no length constraint provided. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC; audit field for ingestion tracking. |
| write_date | TIMESTAMP | true | Record last update timestamp | Assumed UTC; audit field for ingestion tracking. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account.id` (Guess: standard Odoo-style naming convention for account association).
    - `create_uid` → `res_users.id` (Guess: standard Odoo-style naming convention for user audit).
    - `write_uid` → `res_users.id` (Guess: standard Odoo-style naming convention for user audit).
- **Natural keys (inferred):** 
    - `account_id`, `phone_number` (Likely unique combination for a specific account).

## Caveats for downstream consumers

- **Sensitive Data:** The `phone_number` column contains PII and should be masked or restricted according to data privacy policies.
- **Timestamps:** Timestamps are assumed to be in UTC. Verify against source system configuration if local time offsets are required.
- **Soft Deletes:** This table does not explicitly show a `deleted_at` or `active` flag; assume all rows are currently active unless otherwise specified by the source system's business logic.
- **Data Quality:** The `phone_number` column is a `VARCHAR` without a defined length; downstream systems should implement validation to handle unexpected string formats or lengths.