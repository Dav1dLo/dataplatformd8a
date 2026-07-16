# res_company_users_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_company_users_rel` is a standard pattern used by Odoo to manage many-to-many relationship tables (often referred to as "relation" tables) between the `res_company` and `res_users` entities.

## Functional process 
This table supports multi-company access control and user management. It defines the mapping of which users are authorized to access or operate within which specific company entities in the ERP environment.

## Description
One row in this table represents a single association between a user and a company, granting the user access to that company's data. This is a raw landing of a join table, serving as the base for downstream security and organizational hierarchy models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| cid | INTEGER | false | Company ID | Foreign key referencing the `res_company` table. |
| user_id | INTEGER | false | User ID | Foreign key referencing the `res_users` table. |

## Keys

- **Primary key (inferred):** The combination of `(cid, user_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `cid` → `res_company.id`: This column links to the company entity definition.
    - `user_id` → `res_users.id`: This column links to the user account definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure that joins to this table are performed on both `cid` and `user_id` to avoid Cartesian products.
- As a raw staging table, it may contain orphaned records if the source system does not enforce strict referential integrity at the database level.