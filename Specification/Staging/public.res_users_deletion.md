# res_users_deletion

## Source system
This table originates from an Odoo ERP system. The naming convention `res_users_deletion` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and sequence-based primary keys are characteristic of the Odoo `res` (resource) module architecture.

## Functional process 
This table supports the user lifecycle management and data privacy compliance process, specifically tracking requests or automated triggers for user account deletion. It captures the state of deletion requests, likely used to manage the anonymization or removal of user records in accordance with GDPR or similar data retention policies.

## Description
One row in this table represents a single user deletion request or event. It acts as a raw landing record within the staging layer, tracking the status of a user's removal process from the system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `res_users_deletion_id_seq`. |
| user_id | INTEGER | true | Reference to the user being deleted | Likely links to `res_users.id`. |
| user_id_int | INTEGER | true | Internal user identifier | Purpose overlaps with `user_id`; verify if this is a legacy or secondary ID. |
| create_uid | INTEGER | true | ID of the user who created the record | Links to `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | Links to `res_users.id`. |
| state | VARCHAR | false | Current status of the deletion request | e.g., 'draft', 'pending', 'done'. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `user_id` → `res_users.id` (Likely target for the user account subject to deletion).
    - `create_uid` → `res_users.id` (Audit trail for record creation).
    - `write_uid` → `res_users.id` (Audit trail for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** This table tracks user deletion requests; ensure access is restricted as it may contain PII-related metadata.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table appears to be an audit/process log; it does not explicitly implement a soft-delete flag for its own rows.
- **Data Quality:** `user_id` and `user_id_int` are both present; check for data consistency between these two columns before joining to `res_users`.