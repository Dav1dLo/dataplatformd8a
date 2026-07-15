# ir_embedded_actions_res_groups_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_embedded_actions_res_groups_rel` follows the standard Odoo pattern for a many-to-many join table, where `ir_embedded_actions` represents the base model and `res_groups` represents the security groups associated with those actions.

## Functional process 
This table supports the access control and security configuration process. It defines which user groups (roles) have permission to access or view specific embedded actions within the Odoo interface, ensuring that UI components are only rendered for authorized users.

## Description
One row in this table represents a single association between an embedded action and a security group. It acts as a link table in the staging layer, maintaining the many-to-many relationship required to map security permissions to specific system actions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| ir_embedded_actions_id | INTEGER | false | Foreign key to the embedded action definition | Links to the primary key of the action table. |
| res_groups_id | INTEGER | false | Foreign key to the security group definition | Links to the primary key of the groups table. |

## Keys

- **Primary key (inferred):** The combination of `(ir_embedded_actions_id, res_groups_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `ir_embedded_actions_id` → `ir_embedded_actions.id`: This column references the unique identifier of the action being configured.
    - `res_groups_id` → `res_groups.id`: This column references the unique identifier of the security group being granted access.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only relationship identifiers.
- There is no audit timestamp or soft-delete flag; this table reflects the current state of security mappings as captured during the last ingestion.
- Ensure that joins to the parent tables (`ir_embedded_actions` and `res_groups`) handle the potential for missing records if the source system has referential integrity gaps.