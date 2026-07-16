# onboarding_progress

## Source system
The table likely originates from an Odoo ERP or a similar modular business application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns is a standard pattern for Odoo's ORM-managed tables, which track audit trails for record creation and modification.

## Functional process 
This table supports the customer onboarding lifecycle management process. It tracks the status and progression of specific onboarding workflows associated with a company, allowing the system to monitor whether an onboarding process is active, closed, or in a specific state.

## Description
One row in this table represents the current progress state of a specific onboarding workflow for a given company. It serves as a raw landed copy of the operational onboarding status, capturing audit timestamps and user identifiers for each record update.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.onboarding_progress_id_seq`. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the organization undergoing onboarding. |
| onboarding_id | INTEGER | false | Identifier for the onboarding workflow | Links to the specific onboarding process definition. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated the progress. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the status. |
| onboarding_state | VARCHAR | true | Current status of the onboarding | Categorical state (e.g., 'started', 'in_progress', 'completed'). |
| is_onboarding_closed | BOOLEAN | true | Completion flag | Indicates if the onboarding process is finalized. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (guess: standard Odoo naming convention for company links).
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC; verify against application server settings if precision is required for cross-timezone reporting.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume rows are hard-deleted if they disappear from the source.
- **PII:** No direct PII (emails, names) is present, but `create_uid` and `write_uid` link to user identities which may be considered sensitive.
- **Data Integrity:** `company_id` is nullable, which may indicate onboarding processes that are not yet associated with a specific company entity.