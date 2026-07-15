# ir_model_access

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_model_access` is a standard internal Odoo table used to manage the Information Repository (IR) security rules.

## Functional process 
This table supports the Access Control List (ACL) management process within the application. It defines which user groups have specific CRUD (Create, Read, Update, Delete) permissions on individual data models, ensuring that security policies are enforced across the platform.

## Description
One row represents a specific access rule assigned to a user group for a particular data model. It acts as a raw landing copy of the Odoo security configuration, capturing the boolean permission flags and audit metadata for each access entry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_model_access_id_seq`. |
| model_id | INTEGER | false | Foreign key to the model definition | Links to `ir_model` table. |
| group_id | INTEGER | true | Foreign key to the user group | If null, the rule may apply globally or to a specific context. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users`. |
| name | VARCHAR | false | Descriptive name of the access rule | Often a human-readable label for the rule. |
| active | BOOLEAN | true | Soft-delete flag | If false, the rule is ignored by the system. |
| perm_read | BOOLEAN | true | Read permission flag | Grants access to view records. |
| perm_write | BOOLEAN | true | Write permission flag | Grants access to update records. |
| perm_create | BOOLEAN | true | Create permission flag | Grants access to insert new records. |
| perm_unlink | BOOLEAN | true | Delete permission flag | Grants access to remove records. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model_id` → `ir_model.id`: Links the rule to the specific data entity being governed.
    - `group_id` → `res_groups.id`: Links the rule to the security group receiving the permissions.
    - `create_uid` → `res_users.id`: Tracks the creator of the rule.
    - `write_uid` → `res_users.id`: Tracks the last modifier of the rule.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** While this table contains no PII, it defines the security posture of the entire application; access to this table should be restricted.
- **Timestamps:** Timestamps are stored in the application server's local time; verify the server timezone configuration if performing cross-system time analysis.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless auditing historical security configurations.
- **Nullability:** Many columns are nullable, reflecting Odoo's internal handling of optional security constraints.