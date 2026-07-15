# crm_merge_opportunity

## Source system
The table likely originates from an Odoo ERP or a similar Python-based CRM framework, evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo's ORM.

## Functional process 
This table supports the lead-to-cash or sales pipeline management process, specifically tracking the merging of duplicate or related opportunity records. It acts as a join or audit log for consolidating CRM opportunities, likely used to maintain data integrity when multiple entries for the same potential deal are identified.

## Description
One row in this table represents a single merge event involving CRM opportunities. It serves as a raw landed copy of the merge transaction history, capturing the user who performed the action and the associated team context.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_merge_opportunity_id_seq`. |
| user_id | INTEGER | true | ID of the user associated with the merge | Likely references a `res_users` or `users` table. |
| team_id | INTEGER | true | ID of the sales team involved | Likely references a `crm_team` or `sales_team` table. |
| create_uid | INTEGER | true | ID of the user who created the record | Audit field; references `res_users`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | Audit field; references `res_users`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Audit field; timezone unspecified, assume UTC. |
| write_date | TIMESTAMP | true | Timestamp of last update | Audit field; timezone unspecified, assume UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `users.id` (Guess: standard CRM user association).
    - `team_id` → `crm_team.id` (Guess: standard CRM team association).
    - `create_uid` → `users.id` (Evidence: standard Odoo audit pattern).
    - `write_uid` → `users.id` (Evidence: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are standard timestamps; assume UTC unless the source system configuration dictates otherwise.
- **Audit Fields:** `create_uid` and `write_uid` are system-generated audit columns; they should be used for tracking record lineage rather than business logic.
- **Data Integrity:** As this is a staging table, it may contain raw, unvalidated data; check for orphaned IDs in `user_id` or `team_id` if performing joins.
- **Soft Deletes:** There is no explicit `active` or `deleted_at` flag; assume all records are current unless otherwise specified by the source system's business logic.