# ir_act_server_group_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_act_server_group_rel` is characteristic of Odoo's internal metadata tables, specifically those managing many-to-many relationships between server actions (`ir_act_server`) and user groups (`res_groups`).

## Functional process 
This table supports the security and access control module of the ERP. It defines which user groups are authorized to execute specific server-side actions, acting as a junction table to enforce permission-based access to automated workflows or server-side scripts.

## Description
Each row represents a single association between a server action and a user group, establishing that members of the specified group have permission to trigger the associated action. This is a raw landing of a join table, used to resolve many-to-many relationships in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| act_id | INTEGER | false | Foreign key to the server action | Links to the primary key of the server actions table. |
| gid | INTEGER | false | Foreign key to the user group | Links to the primary key of the groups table. |

## Keys

- **Primary key (inferred):** The composite key `(act_id, gid)` is the inferred primary key, as this is a standard junction table structure.
- **Foreign keys (inferred):** 
    - `act_id` → `ir_act_server.id`: This column references the unique identifier of a server action.
    - `gid` → `res_groups.id`: This column references the unique identifier of a user group.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no surrogate primary key; queries should join on the composite `(act_id, gid)` pair.
- As a junction table, it contains no business logic or timestamps; it is purely structural.
- Ensure that downstream joins account for the possibility of orphaned records if the source system does not enforce strict referential integrity at the database level.