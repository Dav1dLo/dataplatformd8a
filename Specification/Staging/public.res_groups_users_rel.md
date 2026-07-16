# res_groups_users_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_groups_users_rel` is the standard PostgreSQL table name used by Odoo to manage the many-to-many relationship between security groups (`res.groups`) and users (`res.users`).

## Functional process 
This table supports the Identity and Access Management (IAM) process within the ERP. It maps individual system users to the security groups that define their permissions, roles, and access rights across the application modules.

## Description
One row in this table represents a single association between a user and a security group, effectively granting the user the permissions associated with that group. As a staging table, it provides a raw, landed copy of the link table used by the source system to enforce access control.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| gid | INTEGER | false | Foreign key to the security group | References the primary key of the groups table. |
| uid | INTEGER | false | Foreign key to the user | References the primary key of the users table. |

## Keys

- **Primary key (inferred):** The composite key `(gid, uid)` is the primary key, as it represents the unique link between a specific group and a specific user.
- **Foreign keys (inferred):** 
    - `gid` → `res_groups.id`: This column links to the security group definition table.
    - `uid` → `res_users.id`: This column links to the system user account table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `created_at` or `updated_at`) present in this table; changes to user permissions are not tracked historically here.
- This table does not implement soft deletes; if a row is absent, the relationship does not exist in the source system.
- Ensure joins to `res_groups` and `res_users` are performed using inner joins if you only require active, valid associations.