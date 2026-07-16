# res_groups_report_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `res_groups_report_rel` follows the standard Odoo pattern for many-to-many relationship tables, where `res_groups` represents security groups and `report` represents report definitions, linked via a join table.

## Functional process 
This table supports the Access Control List (ACL) management process. It defines the mapping between user groups and the specific reports they are authorized to access or generate within the application.

## Description
One row in this table represents a single association between a security group and a report definition. It serves as a raw, normalized join table in the staging layer, capturing the many-to-many relationship required to enforce report-level permissions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| uid | INTEGER | false | Foreign key to the security group identifier | Maps to the primary key of the groups table. |
| gid | INTEGER | false | Foreign key to the report identifier | Maps to the primary key of the reports table. |

## Keys

- **Primary key (inferred):** Composite key of (`uid`, `gid`).
- **Foreign keys (inferred):** 
    - `uid` → `res_groups.id`: This column represents the security group entity.
    - `gid` → `ir_actions_report.id`: This column represents the report action entity (inferred from Odoo schema patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- Ensure joins to parent tables handle potential orphans if referential integrity is not strictly enforced at the source.
- As a staging table, this reflects the raw state of the source system; verify if the source system performs soft deletes on these relationships or if rows are physically removed upon permission revocation.