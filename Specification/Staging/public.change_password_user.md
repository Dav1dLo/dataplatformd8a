# change_password_user

## Source system
This table originates from an Odoo ERP system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the naming convention `change_password_user` and the use of `nextval` sequences, is characteristic of Odoo's internal ORM-managed audit and relationship tracking.

## Functional process 
This table supports the user account security and password management process. It tracks requests or logs associated with password change operations initiated within the system, likely acting as a transient or audit record for password reset workflows.

## Description
One row in this table represents a single password change event or request associated with a specific user and a specific wizard session. It serves as a raw landed staging record, capturing the state of password change attempts or configurations before they are processed into core user identity tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `change_password_user_id_seq`. |
| wizard_id | INTEGER | false | Foreign key to the password reset wizard | Identifies the specific wizard session. |
| user_id | INTEGER | false | Foreign key to the user | The user account subject to the password change. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the record creation. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| user_login | VARCHAR | true | User login identifier | The username or email associated with the account. |
| new_passwd | VARCHAR | true | New password (hashed/plain) | Sensitive data; likely contains a hash or temporary token. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in server local time (usually UTC). |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time (usually UTC). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Inferred from Odoo standard naming conventions for user relations).
    - `wizard_id` → `change_password_wizard.id` (Inferred from the table name and common Odoo wizard patterns).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `new_passwd` column contains sensitive authentication information and should be masked or excluded from non-privileged reporting.
- **Timezone:** Timestamps are typically stored in UTC, but verify against the source system configuration as Odoo can be configured for local time offsets.
- **Data Retention:** This table acts as a staging/audit log; rows may be purged or archived by the source system's maintenance routines.
- **Nullability:** Many fields are nullable, suggesting that some password change attempts may be incomplete or partially logged.