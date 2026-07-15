# hr_employee_hr_employee_cv_wizard_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables between two entities, specifically linking employee records to CV wizard configuration sessions.

## Functional process 
This table supports the HR recruitment and talent management module. It maintains the association between employee profiles and specific "CV Wizard" instances, which are likely temporary sessions used to generate, export, or format employee curriculum vitae documents.

## Description
Each row represents a single link between an employee record and a CV wizard session. It acts as a join table to resolve a many-to-many relationship, ensuring that an employee can be associated with multiple CV generation tasks and vice versa. This is a raw landing of the association table from the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| hr_employee_cv_wizard_id | INTEGER | false | Foreign key to the CV wizard session | Links to the primary key of the wizard configuration table. |
| hr_employee_id | INTEGER | false | Foreign key to the employee record | Links to the primary key of the employee master table. |

## Keys

- **Primary key (inferred):** The combination of `(hr_employee_cv_wizard_id, hr_employee_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `hr_employee_cv_wizard_id` → `hr_employee_cv_wizard.id` (Guessed based on Odoo naming conventions for relationship tables).
    - `hr_employee_id` → `hr_employee.id` (Guessed based on standard Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the age of these associations or when they were created.
- Ensure that joins to the parent tables handle potential orphan records if referential integrity is not strictly enforced in the source system.