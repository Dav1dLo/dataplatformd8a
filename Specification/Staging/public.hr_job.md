# hr_job

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming conventions (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for multi-language fields, and the specific sequence-based primary key pattern (`nextval('"public".hr_job_id_seq'::regclass)`).

## Functional process 
This table supports the recruitment and human resources management process, specifically tracking job openings and vacancy requirements. It links job positions to departments and companies while maintaining metrics on headcount planning and recruitment targets.

## Description
One row in this table represents a single job position or vacancy definition within the organization. It serves as a raw landed copy of the Odoo `hr.job` model, capturing the configuration, requirements, and status of recruitment efforts at the grain of an individual job record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `hr_job_id_seq`. |
| sequence | INTEGER | true | Display order index | Used for UI sorting. |
| expected_employees | INTEGER | true | Target headcount | Number of employees planned for this role. |
| no_of_employee | INTEGER | true | Current headcount | Number of employees currently in this role. |
| no_of_recruitment | INTEGER | true | Open vacancies | Number of positions currently being recruited. |
| department_id | INTEGER | true | Foreign key to department | Links to the organizational unit. |
| company_id | INTEGER | true | Foreign key to company | Multi-tenant identifier. |
| contract_type_id | INTEGER | true | Foreign key to contract type | Defines the employment agreement category. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| name | JSONB | false | Job title | Multi-language string stored as JSON. |
| description | TEXT | true | Job description | Detailed role information. |
| requirements | TEXT | true | Job requirements | Skills or qualifications needed. |
| active | BOOLEAN | true | Soft-delete flag | If false, the job is archived. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `department_id` → `hr_department.id` (Inferred from Odoo standard schema).
    - `company_id` → `res_company.id` (Inferred from Odoo standard schema).
    - `contract_type_id` → `hr_contract_type.id` (Inferred from Odoo standard schema).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `name` field may contain sensitive internal role titles; ensure access controls are applied.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` unless historical/archived data is explicitly required.
- **JSONB:** The `name` column is a `JSONB` object; downstream consumers will need to use the `->>` operator (e.g., `name->>'en_US'`) to extract specific language values.