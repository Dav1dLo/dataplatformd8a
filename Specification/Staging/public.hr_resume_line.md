# hr_resume_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`hr_resume_line`), the use of `create_uid`/`write_uid` audit columns, and the `JSONB` data types commonly used in Odoo's PostgreSQL backend for localized or structured content.

## Functional process 
This table supports the Human Resources "Employee Profile" or "Resume" management process. It tracks individual career history entries, such as previous job titles, education, or certifications, linked to specific employee records.

## Description
One row represents a single entry in an employee's resume or professional profile, such as a specific work experience or educational qualification. This is a raw staging table containing the direct, un-transformed data from the Odoo HR module, serving as the foundation for downstream employee history reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_resume_line_id_seq`. |
| employee_id | INTEGER | false | Foreign key to the employee | Links to the primary employee record. |
| line_type_id | INTEGER | true | Resume line category | References a lookup table for line types (e.g., Education, Experience). |
| create_uid | INTEGER | true | Creator user ID | References the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the system user who last updated the record. |
| display_type | VARCHAR | true | UI rendering hint | Used by the application to determine how to display the line. |
| date_start | DATE | false | Start date of the entry | The beginning of the period covered by this line. |
| date_end | DATE | true | End date of the entry | The end of the period; null implies the entry is ongoing. |
| name | JSONB | false | Entry title/header | Stores the name or title of the resume line, often localized. |
| description | JSONB | true | Detailed entry content | Stores additional descriptive text or metadata in JSON format. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded by the system at ingestion. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the system at update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `employee_id` → `hr_employee.id` (Inferred from standard Odoo naming patterns).
    - `line_type_id` → `hr_resume_line_type.id` (Inferred from standard Odoo naming patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `name` and `description` columns are `JSONB` and may contain sensitive personal career history or contact information.
- **Timestamps:** `create_date` and `write_date` are stored as `TIMESTAMP` (without timezone). Assume UTC unless the Odoo instance configuration specifies otherwise.
- **Data Structure:** The `name` and `description` columns are `JSONB`. Downstream queries will require extraction (e.g., `name->>'en_US'`) to access specific values.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all records are active unless filtered by application logic.