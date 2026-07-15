# change_password_wizard

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the user account management and security process, specifically tracking the execution of password reset or change workflows. It acts as a transient state container for the "Change Password" wizard interface within the application.

## Description
One row in this table represents a single instance of a password change request initiated by a user or administrator. It serves as a raw landing record in the staging layer, capturing the audit trail of when a password change wizard was created and last modified.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the wizard session. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who initiated the password change. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for user-linked audit fields).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for user-linked audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** While this table does not contain the password itself, it tracks security-sensitive administrative actions; ensure access is restricted to authorized personnel.
- **Timestamps:** All timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Data Retention:** This table likely contains transient data; verify if the source system performs periodic cleanup or archiving of these wizard records.
- **Audit Columns:** `create_uid` and `write_uid` may be null if the record was created by a system process rather than an interactive user.