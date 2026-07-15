# discuss_channel_res_groups_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `<table>_<related_table>_rel` is the standard pattern used by the Odoo ORM to manage many-to-many relationship tables in the underlying PostgreSQL database.

## Functional process 
This table supports the access control and security model for communication channels. It maps specific discussion channels to the user groups authorized to access or interact with them, facilitating the "Access Control List" (ACL) logic within the messaging module.

## Description
Each row represents a single association between a discussion channel and a security group. It is a junction table used to resolve a many-to-many relationship, serving as a raw landed copy of the Odoo relational mapping.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| discuss_channel_id | INTEGER | false | Foreign key to the discussion channel | References the primary key of the channel definition table. |
| res_groups_id | INTEGER | false | Foreign key to the security group | References the primary key of the Odoo `res_groups` table. |

## Keys

- **Primary key (inferred):** The composite key `(discuss_channel_id, res_groups_id)`.
- **Foreign keys (inferred):** 
    - `discuss_channel_id → discuss_channel.id`: This column links to the channel entity definition.
    - `res_groups_id → res_groups.id`: This column links to the Odoo security group definition.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns; incremental loading based on this table alone is not possible without a change-tracking mechanism or full-table comparison.
- Ensure that joins to `res_groups` account for the fact that Odoo group IDs are often system-specific and may vary across different instances or environments.