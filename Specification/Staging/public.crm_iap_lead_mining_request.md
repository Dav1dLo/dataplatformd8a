# crm_iap_lead_mining_request

## Source system
This table originates from an Odoo ERP or CRM system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys are characteristic of the Odoo framework's database schema.

## Functional process 
This table supports the lead generation and prospecting pipeline, specifically tracking automated "lead mining" requests. It captures the parameters used to filter and generate potential sales leads, such as company size ranges, seniority levels, and specific roles, and tracks the execution state of these mining jobs.

## Description
Each row represents a single lead mining request submitted by a user to identify potential sales prospects. It acts as a raw landing record in the staging layer, capturing both the configuration parameters for the search and the current processing status of the request.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_iap_lead_mining_request_id_seq`. |
| lead_number | INTEGER | false | Business-level lead count or identifier | Likely a sequence or reference number for the mining batch. |
| team_id | INTEGER | true | Foreign key to sales team | Links the request to a specific internal sales team. |
| user_id | INTEGER | true | Foreign key to user | The user who initiated the mining request. |
| company_size_min | INTEGER | true | Minimum company size filter | Lower bound for prospect company employee count. |
| company_size_max | INTEGER | true | Maximum company size filter | Upper bound for prospect company employee count. |
| contact_number | INTEGER | true | Requested volume of leads | Number of contacts requested in this mining operation. |
| preferred_role_id | INTEGER | true | Foreign key to role definition | Filter for specific job functions. |
| seniority_id | INTEGER | true | Foreign key to seniority level | Filter for job seniority (e.g., Manager, Director). |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record modification. |
| name | VARCHAR | false | Request name or description | Descriptive label for the mining request. |
| state | VARCHAR | false | Lifecycle status | Current status of the request (e.g., 'draft', 'done', 'error'). |
| search_type | VARCHAR | false | Mining strategy type | Defines the algorithm or source used for lead generation. |
| error_type | VARCHAR | true | Error classification | Populated if the mining request failed. |
| lead_type | VARCHAR | false | Category of lead | Defines the nature of the leads being mined. |
| contact_filter_type | VARCHAR | true | Filter logic applied | Specific logic used for contact filtering. |
| filter_on_size | BOOLEAN | true | Size filter toggle | Flag indicating if company size constraints are active. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `team_id` → `crm_team.id` (Guess: standard Odoo naming for sales teams)
    - `user_id` → `res_users.id` (Guess: standard Odoo naming for system users)
    - `preferred_role_id` → `crm_iap_lead_role.id` (Guess: likely lookup table for roles)
    - `seniority_id` → `crm_iap_lead_seniority.id` (Guess: likely lookup table for seniority)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC.
- **Sensitive Data:** The `user_id` and `create_uid` columns link to internal user identities; ensure these are handled according to internal PII/access policies.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless the `state` column indicates otherwise.
- **Data Quality:** The `error_type` column will be null for successful requests; filter by `state` to identify completed vs. failed jobs.