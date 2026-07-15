# hr_employee_skill_log

## Source system
This table originates from an Odoo ERP system, evidenced by the characteristic naming conventions (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys (`nextval` on a `_seq` object).

## Functional process 
This table supports the Human Resources skill management and competency tracking process. It logs historical changes or current states of employee skill proficiency, linking specific employees to skill definitions, proficiency levels, and departmental context.

## Description
One row in this table represents a single record of an employee's skill proficiency or a historical update to their skill level. It serves as a raw landed staging entity, capturing the state of skill-related data as it exists in the source ERP system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| employee_id | INTEGER | false | Foreign key to employee | Identifier for the employee associated with the skill. |
| department_id | INTEGER | true | Foreign key to department | The department context for the skill entry. |
| skill_id | INTEGER | false | Foreign key to skill definition | Identifier for the specific skill being tracked. |
| skill_level_id | INTEGER | false | Foreign key to skill level | The proficiency level achieved. |
| skill_type_id | INTEGER | false | Foreign key to skill type | Categorization of the skill. |
| level_progress | INTEGER | true | Progress metric | Numerical progress within the current skill level. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| date | DATE | true | Effective date | The business date associated with the skill log entry. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created in the source. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `employee_id` → `hr_employee.id` (Standard Odoo naming convention for employee linkage).
    - `department_id` → `hr_department.id` (Standard Odoo naming convention for department linkage).
    - `skill_id` → `hr_skill.id` (Likely target for skill definitions).
    - `skill_level_id` → `hr_skill_level.id` (Likely target for proficiency levels).
    - `skill_type_id` → `hr_skill_type.id` (Likely target for skill categories).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in the source system's timezone (typically UTC in Odoo, but verify against server configuration).
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by business logic.
- **Data Integrity:** `department_id` is nullable, suggesting that some skill logs may be recorded without an explicit departmental association.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal system user IDs and do not contain PII directly, but should be joined against a user table to resolve names.