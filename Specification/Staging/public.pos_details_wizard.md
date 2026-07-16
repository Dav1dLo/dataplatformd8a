# pos_details_wizard

## Source system
The table likely originates from an Odoo ERP system. The naming convention `_wizard` is a standard Odoo pattern for temporary UI-driven data entry objects, and the columns `create_uid`, `write_uid`, `create_date`, and `write_date` are characteristic of Odoo's internal audit tracking fields.

## Functional process 
This table supports the "Point of Sale (POS) Reporting" process. It acts as a transient data store for parameters used to generate POS session reports, specifically capturing the date range (`start_date`, `end_date`) required to filter transaction data for a specific reporting period.

## Description
One row in this table represents a single execution instance of a POS report generation wizard. It captures the temporal parameters provided by a user to define the scope of a report. As a staging table, it serves as a raw landing copy of the wizard's state, intended for auditing or re-running report generation processes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| start_date | TIMESTAMP | false | Report start boundary | Inclusive start of the reporting period. |
| end_date | TIMESTAMP | false | Report end boundary | Inclusive end of the reporting period. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against user master data; no direct PII is present in this table.
- **Lifecycle:** As a "wizard" table, rows may be transient or frequently purged depending on the Odoo instance's cleanup policies.
- **Data Integrity:** `start_date` and `end_date` are mandatory; ensure validation logic in downstream models handles cases where `start_date` > `end_date`.