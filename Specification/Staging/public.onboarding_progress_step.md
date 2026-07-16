# onboarding_progress_step

## Source system
The table likely originates from an Odoo ERP or a similar modular business application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of `nextval` sequences for primary keys, is a hallmark of the Odoo ORM framework.

## Functional process 
This table supports the customer onboarding or implementation pipeline. It tracks the status of specific configuration or setup tasks (`step_id`) associated with a specific client entity (`company_id`) as they progress through an initial system setup or activation workflow.

## Description
One row represents the current state of a single onboarding task for a specific company. This is a staging-layer table, serving as a raw, direct copy of the operational database's progress tracking entity, intended for use in downstream reporting on implementation velocity and completion rates.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.onboarding_progress_step_id_seq`. |
| step_id | INTEGER | false | Identifier for the specific onboarding task | Foreign key to a master list of onboarding steps. |
| company_id | INTEGER | true | Identifier for the company undergoing onboarding | Links the progress step to a specific client. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated this step. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the state. |
| step_state | VARCHAR | true | Current status of the step | Likely values include 'pending', 'in_progress', 'completed'. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id → company.id` (Guess: links to the primary company/tenant table).
    - `create_uid → res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid → res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** 
    - `(company_id, step_id)`: The combination of company and step likely represents the unique business-level identifier for a progress record.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid`, which may map to internal employee names or emails in the `res_users` table; ensure appropriate access controls.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all records are active unless otherwise specified by the source system's business logic.
- **Data Quality:** `company_id` is nullable; records with a null `company_id` may represent system-wide steps or orphaned data.