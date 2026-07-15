# hr_employee_skill_report

## Source system
This table likely originates from an HR Information System (HRIS) or a Talent Management platform (e.g., Workday, BambooHR, or a custom internal HR module). The naming convention `hr_employee_skill_report` and the presence of granular IDs for employees, departments, and skills suggest it is a denormalized export or a reporting view generated from an operational HR database.

## Functional process 
This table supports the human capital management process, specifically tracking workforce competency and professional development. It maps employees to specific skill sets and quantifies their proficiency levels, enabling management to perform gap analysis, resource allocation, and training needs assessment across different departments.

## Description
Each row represents a single skill proficiency record for an individual employee within a specific department. This table serves as a staging entity, providing a flattened view of employee skill data intended for downstream reporting or analytics. It captures the current state of an employee's skill progress and level at the time of the data extraction.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | BIGINT | true | Surrogate primary key | Likely an auto-incrementing identifier from the source system. |
| employee_id | INTEGER | true | Unique identifier for the employee | Foreign key to the employee master table. |
| company_id | INTEGER | true | Unique identifier for the company/legal entity | Used for multi-tenant or multi-entity filtering. |
| department_id | INTEGER | true | Unique identifier for the department | Links the record to a specific organizational unit. |
| skill_id | INTEGER | true | Unique identifier for the skill | Links the record to the master skill catalog. |
| skill_type_id | INTEGER | true | Unique identifier for the skill category | Used to group skills (e.g., technical, soft skills, certifications). |
| level_progress | NUMERIC | true | Quantitative progress metric | Represents a percentage or score (e.g., 0.0 to 1.0 or 0 to 100). |
| skill_level | VARCHAR | true | Qualitative proficiency label | Human-readable level (e.g., "Beginner", "Intermediate", "Expert"). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `employee_id` → `employees.id` (Guess: standard HRIS relationship)
    - `department_id` → `departments.id` (Guess: standard organizational hierarchy)
    - `skill_id` → `skills.id` (Guess: standard competency catalog relationship)
- **Natural keys (inferred):** 
    - The combination of `employee_id` and `skill_id` likely forms the business-level unique identifier for a skill record.

## Caveats for downstream consumers

- **Data Quality:** The `id` column is marked as nullable, which is unusual for a primary key; verify if this table contains orphaned records or if the `id` is missing for certain historical entries.
- **Precision:** The `NUMERIC` type for `level_progress` lacks defined scale/precision; check source DDL to determine if it is `NUMERIC(5,2)` or similar to avoid rounding errors.
- **Sensitivity:** This table contains employee-linked performance data, which may be considered PII or sensitive HR data depending on regional privacy regulations (e.g., GDPR).
- **Soft Deletes:** It is unknown if this table supports soft deletes; assume this is a snapshot of current data unless an `is_deleted` or `updated_at` column is identified in future ingestion cycles.