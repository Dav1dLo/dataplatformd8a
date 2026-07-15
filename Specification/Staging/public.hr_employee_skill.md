# hr_employee_skill

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the primary key sequence (`hr_employee_skill_id_seq`), the presence of `create_uid`/`write_uid` audit columns, and the specific `hr_` prefix common to Odoo Human Resources modules.

## Functional process 
This table supports the Human Resources competency management process, specifically tracking the mapping of employees to their respective skill sets and proficiency levels. It acts as a junction table that links employees to specific skills and categorizes their expertise level within the organization.

## Description
Each row represents a single skill assignment for an employee, defining the specific skill, the proficiency level attained, and the skill category. This is a raw landed staging table representing a direct copy of the Odoo `hr.employee.skill` model, intended for use in building downstream employee competency profiles.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `hr_employee_skill_id_seq`. |
| employee_id | INTEGER | false | Foreign key to the employee | Links to the `hr_employee` table. |
| skill_id | INTEGER | false | Foreign key to the skill definition | Links to the `hr_skill` table. |
| skill_level_id | INTEGER | false | Foreign key to the proficiency level | Links to the `hr_skill_level` table. |
| skill_type_id | INTEGER | false | Foreign key to the skill category | Links to the `hr_skill_type` table. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table. |
| create_date | TIMESTAMP | true | Creation timestamp | Inferred UTC based on Odoo standards. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `employee_id` → `hr_employee.id` (Standard Odoo HR relationship)
    - `skill_id` → `hr_skill.id` (Standard Odoo HR relationship)
    - `skill_level_id` → `hr_skill_level.id` (Standard Odoo HR relationship)
    - `skill_type_id` → `hr_skill_type.id` (Standard Odoo HR relationship)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal system user IDs; these will require a join to the `res_users` table to resolve to human-readable names.
- **Data Integrity:** As a staging table, this contains the raw state of the record; ensure downstream transformations handle potential orphaned records if the source system does not enforce strict referential integrity.
- **Soft Deletes:** This table does not contain an explicit `active` flag; assume all rows are current unless otherwise specified by the source system's business logic.