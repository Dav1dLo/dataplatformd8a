# phone_blacklist

## Source system
This table likely originates from an Odoo ERP system. The naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` combined with the use of `nextval` sequences for primary keys is highly characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the communication compliance and marketing preference process. It maintains a list of phone numbers that have opted out of communications or are otherwise restricted, ensuring that downstream marketing or notification services do not contact these numbers.

## Description
One row in this table represents a single phone number that has been added to a blacklist, including its current active status and audit metadata. It serves as a raw landed copy of the blacklist entity from the source system, used to filter outbound communications.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.phone_blacklist_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system's internal user table. |
| number | VARCHAR | false | The blacklisted phone number | Format varies; check for international prefixes. |
| active | BOOLEAN | true | Soft-delete flag | If false, the number is no longer blacklisted. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column).
- **Natural keys (inferred):** 
    - `number` (assuming the business logic enforces uniqueness on the phone number).

## Caveats for downstream consumers

- **Sensitive Data:** The `number` column contains PII; ensure appropriate masking or access controls are applied.
- **Timestamps:** Timestamps are assumed to be in UTC; verify against source system configuration if precision is required for audit trails.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless performing historical analysis on previously blacklisted numbers.
- **Data Quality:** As this is a staging table, the `number` field may contain inconsistent formatting (e.g., with or without country codes, spaces, or dashes). Normalization is recommended before use in production filters.