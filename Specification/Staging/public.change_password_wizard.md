# change_password_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (`_wizard`), the presence of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of Postgres sequences for primary keys are characteristic of Odoo's ORM-generated tables.

## Functional process 
This table supports the user account security management process, specifically the "Change Password" workflow. It tracks the state of temporary wizard sessions used when a user initiates a password reset or update request within the application.

## Description
One row in this table represents a single instance of a password change request session initiated by a user. It serves as a raw landing copy of the wizard's state, capturing the audit trail of when the session was created and last modified.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `change_password_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Sensitivity:** While this table tracks the wizard session, it does not contain the actual passwords; however, it links to user IDs which may be considered PII in some contexts.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely removed via standard application logic.
- **Audit Columns:** `create_uid` and `write_uid` are system-level identifiers; ensure joins to `res_users` are handled via outer joins if user records have been purged.