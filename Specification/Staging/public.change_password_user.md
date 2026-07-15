# change_password_user

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the user security and authentication management process, specifically tracking password change requests or history within the system. It links specific user accounts to password change events initiated through a wizard or administrative interface.

## Description
One row in this table represents a single password change event or request associated with a specific user. It serves as a raw landing record in the staging layer, capturing the audit trail of who initiated the change and when, along with the associated user login details.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `change_password_user_id_seq`. |
| wizard_id | INTEGER | false | Foreign key to the wizard process | Identifies the specific wizard session that triggered the change. |
| user_id | INTEGER | false | Foreign key to the user | References the user whose password is being changed. |
| create_uid | INTEGER | true | Creator user ID | The ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | The ID of the user who last updated this record. |
| user_login | VARCHAR | true | User login identifier | The username or email associated with the user at the time of the event. |
| new_passwd | VARCHAR | true | New password hash/value | Sensitive data; likely stored as a hash or encrypted string. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in server local time (usually UTC). |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time (usually UTC). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: Standard Odoo pattern for linking to the user table).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit field referencing the creator).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit field referencing the modifier).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `new_passwd` column contains sensitive authentication information and should be masked or excluded from non-privileged reporting.
- **Timezone:** Timestamps are typically stored in UTC; verify against the source Odoo configuration if precise offsets are required.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD behavior.
- **Data Integrity:** As a staging table, this may contain duplicate entries if the source system allows multiple password change attempts per wizard session.