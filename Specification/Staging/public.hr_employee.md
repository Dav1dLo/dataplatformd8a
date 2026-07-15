# hr_employee

## Source system
This table originates from Odoo ERP, indicated by the characteristic naming conventions such as `resource_id`, `create_uid`, `write_uid`, and the use of `JSONB` for `employee_properties`. The schema structure is typical of Odoo's Human Resources module.

## Functional process 
This table supports the core Human Resources management process, specifically employee lifecycle management. It tracks personnel data ranging from professional details (department, job title, work location) to sensitive personal information (SSN, birthdate, private contact details) and employment status (departure dates, employee type).

## Description
One row represents a single employee record within the organization. It serves as the primary staging entity for employee master data, capturing both professional attributes and personal details required for payroll, compliance, and internal directory management.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| resource_id | INTEGER | false | Link to resource master | Odoo internal resource reference. |
| company_id | INTEGER | false | Company identifier | Multi-company support. |
| resource_calendar_id | INTEGER | true | Working schedule ID | Links to calendar definitions. |
| message_main_attachment_id | INTEGER | true | Main attachment ID | Reference to profile photo or document. |
| color | INTEGER | true | UI color index | Used for calendar/view coloring. |
| department_id | INTEGER | true | Department identifier | Foreign key to department table. |
| job_id | INTEGER | true | Job position identifier | Foreign key to job positions. |
| address_id | INTEGER | true | Work address identifier | Links to partner/address table. |
| work_contact_id | INTEGER | true | Work contact identifier | Links to partner table. |
| work_location_id | INTEGER | true | Work location identifier | Physical office location. |
| user_id | INTEGER | true | System user identifier | Links to the internal user account. |
| parent_id | INTEGER | true | Manager identifier | Self-referencing FK for hierarchy. |
| coach_id | INTEGER | true | Coach identifier | Mentor/Coach reference. |
| private_state_id | INTEGER | true | Private state/province ID | Geographic reference. |
| private_country_id | INTEGER | true | Private country ID | Geographic reference. |
| country_id | INTEGER | true | Nationality ID | Country of citizenship. |
| children | INTEGER | true | Number of children | Used for tax/benefit calculations. |
| country_of_birth | INTEGER | true | Country of birth ID | Geographic reference. |
| bank_account_id | INTEGER | true | Bank account identifier | Payroll disbursement reference. |
| distance_home_work | INTEGER | true | Commute distance | Numeric value. |
| km_home_work | INTEGER | true | Commute distance in KM | Redundant/specific unit field. |
| departure_reason_id | INTEGER | true | Departure reason ID | Used for offboarding analytics. |
| create_uid | INTEGER | true | Creator user ID | Audit trail. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail. |
| name | VARCHAR | true | Employee full name | Display name. |
| job_title | VARCHAR | true | Job title | Professional designation. |
| work_phone | VARCHAR | true | Work phone number | Contact info. |
| mobile_phone | VARCHAR | true | Mobile phone number | Contact info. |
| work_email | VARCHAR | true | Work email address | Contact info. |
| private_street | VARCHAR | true | Private address line 1 | PII. |
| private_street2 | VARCHAR | true | Private address line 2 | PII. |
| private_city | VARCHAR | true | Private city | PII. |
| private_zip | VARCHAR | true | Private zip code | PII. |
| private_phone | VARCHAR | true | Private phone number | PII. |
| private_email | VARCHAR | true | Private email address | PII. |
| lang | VARCHAR | true | Language code | ISO code (e.g., 'en_US'). |
| gender | VARCHAR | true | Gender | Demographic data. |
| marital | VARCHAR | false | Marital status | Required field. |
| spouse_complete_name | VARCHAR | true | Spouse name | PII. |
| place_of_birth | VARCHAR | true | City of birth | PII. |
| ssnid | VARCHAR | true | Social Security Number | PII. |
| sinid | VARCHAR | true | Social Insurance Number | PII. |
| identification_id | VARCHAR | true | National ID | PII. |
| passport_id | VARCHAR | true | Passport number | PII. |
| permit_no | VARCHAR | true | Work permit number | Compliance data. |
| visa_no | VARCHAR | true | Visa number | Compliance data. |
| certificate | VARCHAR | true | Education level | Qualification data. |
| study_field | VARCHAR | true | Field of study | Qualification data. |
| study_school | VARCHAR | true | School name | Qualification data. |
| emergency_contact | VARCHAR | true | Emergency contact name | PII. |
| emergency_phone | VARCHAR | true | Emergency contact phone | PII. |
| distance_home_work_unit | VARCHAR | false | Distance unit | e.g., 'km', 'mi'. |
| employee_type | VARCHAR | false | Employment type | e.g., 'employee', 'student'. |
| barcode | VARCHAR | true | Badge barcode | Access control. |
| pin | VARCHAR | true | PIN code | Access control. |
| private_car_plate | VARCHAR | true | Car license plate | PII. |
| spouse_birthdate | DATE | true | Spouse birthdate | PII. |
| birthday | DATE | true | Employee birthdate | PII. |
| visa_expire | DATE | true | Visa expiry date | Compliance. |
| work_permit_expiration_date | DATE | true | Permit expiry date | Compliance. |
| departure_date | DATE | true | Departure date | Offboarding date. |
| employee_properties | JSONB | true | Custom attributes | Flexible schema storage. |
| additional_note | TEXT | true | Additional notes | Free text. |
| notes | TEXT | true | General notes | Free text. |
| departure_description | TEXT | true | Departure reason details | Free text. |
| active | BOOLEAN | true | Active status | Soft-delete flag. |
| is_flexible | BOOLEAN | true | Flexible work flag | Work policy. |
| is_fully_flexible | BOOLEAN | true | Fully flexible flag | Work policy. |
| work_permit_scheduled_activity | BOOLEAN | true | Permit activity flag | Compliance. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `department_id` → `hr_department.id` (Likely links to department master)
    - `job_id` → `hr_job.id` (Likely links to job position master)
    - `parent_id` → `hr_employee.id` (Self-referencing hierarchy)
- **Natural keys (inferred):**
    - `work_email` (Assuming unique corporate email)
    - `ssnid` / `identification_id` (Depending on local compliance, these are often unique business keys)

## Caveats for downstream consumers

- **PII Sensitivity:** This table contains significant PII (SSN, home address, private phone, birthdates). Ensure strict masking policies are applied in downstream reporting layers.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should filter by `WHERE active = TRUE` unless performing historical analysis.
- **Timestamps:** `create_date` and `write_date` are stored in the database server's timezone (typically UTC in Odoo environments).
- **JSONB:** The `employee_properties` column contains unstructured data; parsing this requires `jsonb_extract_path_text` or similar functions, which may impact query performance.