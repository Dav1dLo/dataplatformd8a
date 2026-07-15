# ir_act_window_group_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_act_window_group_rel` is characteristic of Odoo's internal registry (IR) tables, specifically representing a many-to-many relationship between window actions and user groups.

## Functional process 
This table supports the security and access control configuration process. It defines which user groups have permission to access or view specific window actions within the application interface, effectively mapping UI elements to authorization roles.

## Description
One row in this table represents a single association between a window action and a user group. It acts as a join table in the staging layer, providing a raw, un-transformed link between the `ir_act_window` and `res_groups` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| act_id | INTEGER | false | Foreign key to the window action | Links to the action definition. |
| gid | INTEGER | false | Foreign key to the user group | Links to the security group definition. |

## Keys

- **Primary key (inferred):** The combination of `(act_id, gid)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `act_id` → `ir_act_window.id`: This column references the primary key of the window actions table.
    - `gid` → `res_groups.id`: This column references the primary key of the user groups table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when an association was created or modified from this table alone.
- As a staging table, it should be joined with the corresponding master tables (`ir_act_window` and `res_groups`) to derive meaningful business context.