# hr_employee_category

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the Human Resources management process by defining categories or tags used to classify employees. These categories are typically used for filtering, reporting, or grouping employees within the HR module.

## Description
One row in this table represents a single employee category or tag definition. This is a raw landed copy of the Odoo `hr.employee.category` model, serving as the staging entity for downstream HR dimension modeling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_employee_category_id_seq`. |
| color | INTEGER | true | UI color index | Represents a color code used in the Odoo interface. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| name | VARCHAR | false | Category name | The human-readable label for the employee category. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creation).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modification).
- **Natural keys (inferred):** 
    - `name` (Assuming category names are unique within the HR module).

## Caveats for downstream consumers

- **Sensitive Data:** This table contains no PII, but `create_uid` and `write_uid` link to internal system user IDs.
- **Timestamps:** Timestamps are assumed to be in UTC as per standard Odoo/PostgreSQL configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are currently active unless otherwise specified by the source system logic.
- **Data Precision:** The `VARCHAR` type for `name` does not specify a length; downstream consumers should account for potential long strings if the source schema is altered.