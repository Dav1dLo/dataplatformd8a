# mail_canned_response_res_groups_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_res_groups_rel` is a standard pattern used by the Odoo ORM to manage many-to-many relationship tables between a primary business object (in this case, canned email responses) and the security/access groups defined in the `res_groups` table.

## Functional process 
This table supports the access control and permission management process for canned email responses. It defines which user security groups are authorized to view or utilize specific canned responses, ensuring that sensitive or role-specific communication templates are restricted to the appropriate personnel.

## Description
Each row represents a single association between a canned response and a security group, effectively granting the group access to that response. This is a raw landing of a join table, serving as the bridge to enforce row-level security or visibility constraints on email templates within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_canned_response_id | INTEGER | false | Foreign key to the canned response definition | Links to the primary entity in `mail_canned_response`. |
| res_groups_id | INTEGER | false | Foreign key to the security group definition | Links to the security group in `res_groups`. |

## Keys

- **Primary key (inferred):** The combination of (`mail_canned_response_id`, `res_groups_id`) forms the composite primary key.
- **Foreign keys (inferred):** 
    - `mail_canned_response_id` → `mail_canned_response.id`: Establishes the relationship to the specific email template.
    - `res_groups_id` → `res_groups.id`: Establishes the relationship to the authorized security group.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags; updates to permissions are typically handled via `INSERT` and `DELETE` operations on this table by the source application.
- Ensure that joins to this table are filtered by the specific `res_groups_id` relevant to the current user's session to enforce visibility.