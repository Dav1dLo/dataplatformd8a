# res_users_log

## Source system
This table originates from an Odoo ERP system. The naming convention `res_users_log` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) alongside a sequence-based primary key are characteristic of the Odoo `res.users.log` model, which tracks user authentication or activity logs.

## Functional process 
This table supports the user activity monitoring and audit trail process. It captures metadata regarding when user records were created or modified within the system, facilitating security auditing and tracking administrative changes to user accounts.

## Description
One row in this table represents a single audit log entry for a user-related event or record modification. As a staging table, it serves as a raw, landed copy of the Odoo database table, preserving the original system's audit timestamps and user references for downstream integration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `res_users_log_id_seq` sequence. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Inferred UTC; confirm against Odoo server config. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Inferred UTC; confirm against Odoo server config. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking the last user to update a record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with `res_users` to identify specific individuals.
- **Timestamps:** Assumed to be in UTC, as is standard for Odoo deployments, but verify against the source system's `timezone` setting.
- **Soft Deletes:** This table does not appear to implement soft deletes (no `active` or `deleted_at` column); assume all records are current unless otherwise specified by the source system logic.
- **Audit Columns:** `create_date` and `write_date` are system-generated; they may be identical for newly created records.