# sms_account_sender

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system. The naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` is a signature pattern for Odoo's ORM-based audit tracking, and the use of `nextval` sequences for primary keys is standard for PostgreSQL-backed Odoo installations.

## Functional process 
This table supports the configuration and management of SMS communication channels within the platform. It maps specific sender identities (e.g., short codes, alphanumeric sender IDs) to internal account entities, facilitating the tracking of which accounts are authorized to use specific SMS sender names for outbound messaging.

## Description
One row represents a unique association between an account and a specific SMS sender identity. It serves as a raw landing copy of the configuration record, capturing the audit trail of who created or modified the sender association and when those actions occurred.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sms_account_sender_id_seq`. |
| account_id | INTEGER | false | Foreign key to the owning account | Links to the account entity using this sender. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the internal user table. |
| sender_name | VARCHAR | true | Alphanumeric sender ID | The name displayed as the SMS originator. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account.id` (Guess: standard Odoo naming convention for account-related entities).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `sender_name` may contain business-specific identifiers; ensure compliance with internal data masking policies.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard PostgreSQL/Odoo deployments.
- **Soft Deletes:** This table does not explicitly show a `deleted` or `active` flag; verify if the source system uses hard deletes or if an `active` column is missing from this staging view.
- **Audit Columns:** `create_uid` and `write_uid` are likely internal system IDs and may not be human-readable without joining to the user metadata table.