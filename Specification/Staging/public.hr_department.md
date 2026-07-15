# hr_department

## Source system
The table originates from an Odoo ERP system, evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `parent_path` (used for Odoo's materialized path hierarchy), and the use of `JSONB` for multi-language field storage (`name`).

## Functional process 
This table supports the organizational structure management process within the HR module. It defines the hierarchy of departments, linking them to managers and parent departments to facilitate reporting lines, cost center allocation, and organizational charting.

## Description
One row represents a single department or organizational unit within the company. It maintains the hierarchical structure of the organization, including references to parent departments and assigned managers. This is a raw landed staging table, serving as the primary source for organizational dimension modeling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_department_id_seq`. |
| company_id | INTEGER | true | Foreign key to the company | Links department to a specific legal entity. |
| parent_id | INTEGER | true | Parent department ID | Used for recursive hierarchy. |
| manager_id | INTEGER | true | Manager employee ID | References the head of the department. |
| color | INTEGER | true | UI color index | Used for visual grouping in the Odoo interface. |
| master_department_id | INTEGER | true | Master department reference | Used for grouping sub-departments under a master unit. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| complete_name | VARCHAR | true | Full hierarchical name | Denormalized path (e.g., "Parent / Child"). |
| parent_path | VARCHAR | true | Materialized path | Used for efficient tree traversal in Odoo. |
| name | JSONB | false | Department name | Multi-language support; contains key-value pairs for locales. |
| note | TEXT | true | Internal notes | Free-text description of the department. |
| active | BOOLEAN | true | Soft-delete flag | If false, the department is archived. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link)
    - `parent_id` → `hr_department.id` (Self-referencing hierarchy)
    - `manager_id` → `hr_employee.id` (Guess: standard Odoo HR link)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitivity:** The `name` field may contain sensitive organizational data; `note` fields should be scanned for unstructured PII.
- **Timezones:** Timestamps are stored in the server's local time; verify the Odoo instance timezone configuration before performing time-series analysis.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless performing historical audits.
- **JSONB:** The `name` column requires specific PostgreSQL JSONB operators (e.g., `name->>'en_US'`) to extract human-readable strings.
- **Hierarchy:** Use the `parent_path` column for efficient recursive queries rather than standard recursive CTEs if performance is a concern.