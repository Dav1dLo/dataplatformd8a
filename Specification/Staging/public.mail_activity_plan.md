# mail_activity_plan

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `res_model`, `create_uid`, `write_uid`, `mail_activity_plan`) and the use of PostgreSQL sequences for primary keys are characteristic of the Odoo framework's internal data structure.

## Functional process 
This table supports the "Activity Planning" module within the CRM or communication suite. It defines templates or plans for automated follow-up activities (such as calls, meetings, or emails) that are triggered against specific business objects (defined by `res_model`).

## Description
One row represents a single activity plan template that dictates a series of tasks to be performed for a specific business model. It serves as a raw landing copy of the Odoo configuration table, capturing the definition of activity workflows used to automate user interactions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_activity_plan_id_seq`. |
| company_id | INTEGER | true | Foreign key to the owning company | Multi-company environment identifier. |
| res_model_id | INTEGER | false | Foreign key to the model registry | Links to the specific business object type. |
| create_uid | INTEGER | true | User ID who created the record | References the `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res.users` table. |
| name | VARCHAR | false | Display name of the activity plan | Human-readable label for the plan. |
| res_model | VARCHAR | false | Technical name of the business model | e.g., 'crm.lead' or 'sale.order'. |
| active | BOOLEAN | true | Soft-delete flag | If false, the plan is hidden from UI. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| department_id | INTEGER | true | Foreign key to the department | Links to the organizational unit. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id → res_company.id` (Standard Odoo multi-company pattern)
    - `res_model_id → ir_model.id` (Standard Odoo model registry pattern)
    - `create_uid → res_users.id` (Standard Odoo audit trail pattern)
    - `write_uid → res_users.id` (Standard Odoo audit trail pattern)
    - `department_id → hr_department.id` (Standard Odoo HR integration pattern)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may be linked to PII in the `res_users` table.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = TRUE` unless historical analysis is required.
- **Data Precision:** `VARCHAR` columns do not have explicit lengths defined in the metadata; downstream systems should handle variable-length strings appropriately.