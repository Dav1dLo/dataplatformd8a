# crm_iap_lead_mining_request

## Source system
This table originates from an Odoo ERP or CRM system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys are characteristic of the Odoo framework's database schema.

## Functional process 
This table supports the lead generation and prospecting pipeline. It tracks automated or manual requests to "mine" or identify potential sales leads based on specific firmographic criteria such as company size, contact seniority, and role preferences.

## Description
One row represents a single lead mining request submitted by a user or automated process. It captures the parameters of the search (e.g., company size ranges, seniority levels) and the current processing state of the request. As a staging table, it serves as a raw, landed copy of the operational request records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `crm_iap_lead_mining_request_id_seq`. |
| lead_number | INTEGER | false | Business-level lead identifier | Likely a sequential counter for leads. |
| team_id | INTEGER | true | Foreign key to sales team | Links request to a specific CRM team. |
| user_id | INTEGER | true | Foreign key to user | The owner or requester of the mining task. |
| company_size_min | INTEGER | true | Minimum company size filter | Lower bound for firmographic filtering. |
| company_size_max | INTEGER | true | Maximum company size filter | Upper bound for firmographic filtering. |
| contact_number | INTEGER | true | Requested volume of contacts | The number of leads requested in this batch. |
| preferred_role_id | INTEGER | true | Foreign key to role lookup | Filter for specific job functions. |
| seniority_id | INTEGER | true | Foreign key to seniority level | Filter for job seniority (e.g., C-level, Manager). |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| name | VARCHAR | false | Request description/label | Human-readable name for the mining request. |
| state | VARCHAR | false | Lifecycle status | Current status (e.g., 'draft', 'done', 'error'). |
| search_type | VARCHAR | false | Mining methodology | Defines the search strategy used. |
| error_type | VARCHAR | true | Error classification | Populated if the request failed. |
| lead_type | VARCHAR | false | Lead category | Defines the nature of the leads being mined. |
| contact_filter_type | VARCHAR | true | Contact filtering logic | Specific criteria used to refine contact results. |
| filter_on_size | BOOLEAN | true | Size filter toggle | Flag indicating if company size constraints apply. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `team_id` → `crm_team.id` (Guess: standard Odoo naming for sales teams)
    - `user_id` → `res_users.id` (Guess: standard Odoo naming for system users)
    - `preferred_role_id` → `crm_iap_lead_role.id` (Guess: lookup table for roles)
    - `seniority_id` → `crm_iap_lead_seniority.id` (Guess: lookup table for seniority)
- **Natural keys (inferred):** 
    - `lead_number` (Likely unique within the source system context)

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless the `state` column indicates otherwise.
- **Sensitive Data:** Contains `user_id` and potentially identifiable search parameters; ensure access is restricted according to internal data governance policies.
- **Data Quality:** `company_size_min` and `company_size_max` may be null if `filter_on_size` is false.