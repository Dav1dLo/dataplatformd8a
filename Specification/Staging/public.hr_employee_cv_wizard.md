# hr_employee_cv_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`hr_employee_cv_wizard`), the use of `create_uid`/`write_uid` audit columns, and the `nextval` sequence pattern typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the Human Resources module, specifically the "CV Wizard" or "Resume Builder" functionality. It stores user-defined configuration preferences for generating employee CV documents, such as color schemes and visibility toggles for specific sections like skills or contact information.

## Description
One row in this table represents a single configuration instance for an employee CV generation session. It acts as a raw landed staging table capturing the state of the wizard's UI settings at the time of creation or update.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_employee_cv_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users` table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users` table. |
| color_primary | VARCHAR | false | Primary color hex code or name | Used for document styling. |
| color_secondary | VARCHAR | false | Secondary color hex code or name | Used for document styling. |
| show_skills | BOOLEAN | true | Toggle to include skills section | |
| show_contact | BOOLEAN | true | Toggle to include contact details | |
| show_others | BOOLEAN | true | Toggle to include other sections | |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user-specific configuration preferences; while not PII, it is linked to user activity via `create_uid`.
- **Timestamps:** Timestamps are stored in the database's local time (typically UTC in Odoo environments).
- **Soft Deletes:** This table does not appear to implement soft deletes; it follows standard Odoo CRUD patterns.
- **Data Quality:** `show_*` boolean columns may contain `NULL` values if the wizard defaults were not explicitly saved; treat `NULL` as `FALSE` or default application logic.