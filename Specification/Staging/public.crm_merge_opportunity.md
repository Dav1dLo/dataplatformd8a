# crm_merge_opportunity

## Source system
This table likely originates from an Odoo ERP or a similar Python-based CRM framework. The naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences for the `id` column, is highly characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the lead-to-cash or sales pipeline management process, specifically tracking the merging of duplicate or redundant opportunity records. It acts as an audit or tracking log for when multiple CRM opportunities are consolidated into a single master record.

## Description
One row in this table represents a single merge event involving CRM opportunities. It records the association between the user performing the action, the team involved, and the audit timestamps for the record's creation and modification. This is a raw landed staging table representing the initial capture of merge activity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `crm_merge_opportunity_id_seq`. |
| user_id | INTEGER | true | ID of the user associated with the merge | Likely references a `res_users` table. |
| team_id | INTEGER | true | ID of the sales team involved | Likely references a `crm_team` table. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user who performed the merge. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user who last modified the merge entry. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `public.res_users.id` (Guess: standard Odoo naming pattern for user associations).
    - `team_id` → `public.crm_team.id` (Guess: standard Odoo naming pattern for sales team associations).
    - `create_uid` → `public.res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `public.res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs which may link to PII in the `res_users` table; ensure appropriate access controls.
- **Timestamps:** Assumed to be in UTC; verify against source system configuration if precision is required for cross-timezone reporting.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all records are active unless otherwise specified by the source system's business logic.
- **Data Quality:** As a staging table, expect potential nulls in `user_id` or `team_id` if the merge was performed by a system process rather than a specific user.