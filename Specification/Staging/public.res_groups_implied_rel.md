# res_groups_implied_rel

## Source system
Odoo ERP. The naming convention `res_groups_implied_rel` is characteristic of Odoo's internal ORM, which uses `res_` prefixes for core resource tables and `_rel` suffixes for many-to-many relationship tables.

## Functional process 
Access control management. This table supports the hierarchical grouping of security roles, where adding a user to one group automatically implies membership in another, facilitating complex permission inheritance within the Odoo security model.

## Description
This table represents a many-to-many relationship mapping between two security groups. One row defines a single "implied" relationship where the group identified by `gid` automatically inherits the permissions of the group identified by `hid`. It serves as a raw landing copy of the Odoo database's internal relationship table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| gid | INTEGER | false | ID of the parent group | References `res_groups.id`. |
| hid | INTEGER | false | ID of the implied (child) group | References `res_groups.id`. |

## Keys

- **Primary key (inferred):** Composite key of (`gid`, `hid`).
- **Foreign keys (inferred):** 
    - `gid` → `res_groups.id`: This column represents the group that gains the implied permissions.
    - `hid` → `res_groups.id`: This column represents the group whose permissions are being inherited.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no descriptive metadata, only integer identifiers; joins to `res_groups` are required to resolve group names.
- The relationship is directional: `gid` implies `hid`.
- As a raw staging table, it reflects the state of the source system at the time of extraction; it does not contain audit timestamps or soft-delete flags.