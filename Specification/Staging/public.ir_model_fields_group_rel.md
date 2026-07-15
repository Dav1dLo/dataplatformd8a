# ir_model_fields_group_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_model_fields_group_rel` is a standard pattern used by Odoo to manage many-to-many relationship tables (often referred to as "relation tables") between model fields and security groups.

## Functional process 
This table supports the access control and security configuration process. It defines which user groups have visibility or access permissions to specific fields within the Odoo data model, ensuring that sensitive or role-specific data is restricted according to the defined security groups.

## Description
One row in this table represents a single association between a specific field and a security group, effectively granting the group access to that field. This is a raw landing of a join table, serving as the base for mapping field-level security permissions across the platform.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| field_id | INTEGER | false | Foreign key to the field definition | References the primary key of the fields table. |
| group_id | INTEGER | false | Foreign key to the security group definition | References the primary key of the groups table. |

## Keys

- **Primary key (inferred):** The combination of `(field_id, group_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `field_id` → `ir_model_fields.id`: This column links to the field definition table.
    - `group_id` → `res_groups.id`: This column links to the security group definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a high volume of rows and should be joined against the parent `ir_model_fields` and `res_groups` tables to be meaningful.
- There are no timestamps or audit columns present; it is impossible to determine when these relationships were created or modified from this table alone.
- This table does not contain soft-delete flags; assume that the absence of a record indicates no relationship exists.