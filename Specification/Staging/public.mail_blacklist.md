# mail_blacklist

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default for the primary key.

## Functional process 
This table supports the email communication management process, specifically the "Email Opt-out" or "Blacklist" functionality. It tracks email addresses that have requested to be unsubscribed or blocked from receiving further automated communications, ensuring compliance with anti-spam regulations.

## Description
One row in this table represents a single email address that has been explicitly blacklisted from the system's mailing services. It serves as a raw landed copy of the Odoo `mail.blacklist` model, used to filter recipient lists before dispatching marketing or transactional emails.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.mail_blacklist_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res.users`. |
| email | VARCHAR | false | The blacklisted email address | Natural key; likely requires normalization (lowercase). |
| active | BOOLEAN | true | Soft-delete flag | If false, the email is no longer blacklisted. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `email`

## Caveats for downstream consumers

- **PII:** The `email` column contains Personally Identifiable Information and should be masked or handled according to data privacy policies.
- **Soft Deletes:** Use the `active` column to filter for currently blacklisted addresses; rows with `active = false` are historically blacklisted but currently ignored.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Quality:** The `email` column is not constrained by a unique index in the provided metadata, though it functions as a business key; check for duplicates if necessary.