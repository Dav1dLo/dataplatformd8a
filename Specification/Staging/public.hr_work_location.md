# hr_work_location

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys.

## Functional process 
This table supports the Human Resources and Facilities management processes, specifically tracking the physical or logical work locations associated with a company. It links organizational entities to specific addresses, facilitating payroll tax jurisdiction tracking, office space management, and employee assignment.

## Description
One row represents a single work location or site associated with a company entity. It serves as a raw landed copy of the Odoo `hr.work.location` model, capturing the configuration and status of various work sites within the organization.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier. |
| company_id | INTEGER | false | Foreign key to company | Links to the parent organization. |
| address_id | INTEGER | false | Foreign key to address | Links to the physical address record. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Location name | Descriptive label for the work site. |
| location_type | VARCHAR | false | Type of location | Categorization of the site (e.g., office, remote, warehouse). |
| location_number | VARCHAR | true | Internal location code | Optional reference number for the site. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the location is currently in use. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo pattern for multi-company support).
    - `address_id` → `res_partner.id` (Guess: Odoo typically stores addresses as partners).
- **Natural keys (inferred):** 
    - `name` (within the scope of `company_id`).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless historical audit is required.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **PII:** While this table contains location names, it does not contain direct employee PII, though it may be linked to sensitive payroll or personnel data in downstream models.
- **Data Integrity:** `create_uid` and `write_uid` refer to internal system user IDs; ensure these are joined against the appropriate `res_users` table if human-readable names are required.