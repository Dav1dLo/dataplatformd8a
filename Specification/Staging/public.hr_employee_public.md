# hr_employee_public

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, alongside the `_id` suffix pattern used for relational linking.

## Functional process 
This table supports the Human Resources management process, specifically the maintenance of employee master data. It tracks organizational assignments (department, job, company), contact information, and reporting structures (coach, parent) within the enterprise.

## Description
One row represents a single employee record within the organization. This table serves as a raw landed copy of the employee entity in the staging layer, capturing both personal contact details and internal system identifiers for organizational hierarchy and resource management.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| name | VARCHAR | true | Full name of the employee | - |
| active | BOOLEAN | true | Soft-delete flag | True if the employee is currently active |
| color | INTEGER | true | UI display color index | Used for calendar or dashboard grouping |
| department_id | INTEGER | true | Foreign key to department | Links to the organizational department |
| job_id | INTEGER | true | Foreign key to job position | Links to the job definition |
| job_title | VARCHAR | true | Descriptive job title | Denormalized title string |
| company_id | INTEGER | true | Foreign key to company | Links to the legal entity |
| address_id | INTEGER | true | Foreign key to partner address | Links to the physical address record |
| work_phone | VARCHAR | true | Work phone number | - |
| mobile_phone | VARCHAR | true | Mobile phone number | - |
| work_email | VARCHAR | true | Work email address | PII: Sensitive contact information |
| work_contact_id | INTEGER | true | Foreign key to contact | Links to the primary contact record |
| work_location_id | INTEGER | true | Foreign key to work location | Links to the office or site location |
| user_id | INTEGER | true | Foreign key to system user | Links to the internal application user |
| resource_id | INTEGER | true | Foreign key to resource | Links to the resource management entity |
| resource_calendar_id | INTEGER | true | Foreign key to calendar | Links to the working hours calendar |
| is_flexible | BOOLEAN | true | Flexible hours flag | Indicates if the employee has flexible hours |
| is_fully_flexible | BOOLEAN | true | Fully flexible hours flag | Indicates if the employee has full flexibility |
| parent_id | INTEGER | true | Foreign key to manager | Self-referencing ID for reporting line |
| coach_id | INTEGER | true | Foreign key to coach | Links to the assigned employee coach |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed |
| id | INTEGER | true | Primary key | Unique identifier for the employee |
| create_uid | INTEGER | true | Creator user ID | Links to the user who created the record |
| write_uid | INTEGER | true | Last modifier user ID | Links to the user who last updated the record |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `department_id` → `hr_department.id` (Inferred from Odoo standard naming)
    - `job_id` → `hr_job.id` (Inferred from Odoo standard naming)
    - `company_id` → `res_company.id` (Inferred from Odoo standard naming)
    - `parent_id` → `hr_employee_public.id` (Self-referencing manager relationship)
- **Natural keys (inferred):** 
    - `work_email` (Assuming unique business email per employee)

## Caveats for downstream consumers

- **PII:** The `work_email`, `work_phone`, and `mobile_phone` columns contain personal contact information and should be masked in non-production environments.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = TRUE` to retrieve current employees.
- **Data Quality:** As a staging table, this may contain duplicates or incomplete records depending on the extraction frequency from the source system.