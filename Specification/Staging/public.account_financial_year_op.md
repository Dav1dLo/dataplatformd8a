# account_financial_year_op

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the financial accounting module, specifically tracking the definition and lifecycle of financial years for individual companies. It is used to scope financial reporting and ledger entries to specific fiscal periods.

## Description
Each row represents a record of a financial year configuration associated with a specific company. As a staging table, it serves as a raw, landed copy of the Odoo `account.financial.year.op` model, preserving the audit trail of who created or modified the record and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the record. |
| company_id | INTEGER | false | Foreign key to company | Links the financial year to a specific entity in the multi-company setup. |
| create_uid | INTEGER | true | Creator user ID | References the user who initially created this record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Inferred based on Odoo standard naming conventions for company associations).
    - `create_uid` → `res_users.id` (Inferred based on Odoo standard audit column patterns).
    - `write_uid` → `res_users.id` (Inferred based on Odoo standard audit column patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with standard Odoo deployment practices.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs; these will not resolve to meaningful names without joining against the `res_users` table.
- **Data Integrity:** As a staging table, this may contain historical versions or records that have been logically superseded; check for `write_date` patterns if identifying the "current" configuration.
- **PII:** No direct PII is present, though user IDs can be linked to employee identities via other system tables.