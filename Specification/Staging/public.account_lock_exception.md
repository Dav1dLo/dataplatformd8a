# account_lock_exception

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` is a standard pattern for Odoo's ORM audit tracking, and the structure suggests it manages accounting period lock overrides.

## Functional process 
This table supports the financial accounting process by managing exceptions to period-based data locks. It allows specific users or companies to bypass standard accounting lock dates (e.g., closing a fiscal year or month) for specific entries or timeframes, ensuring audit compliance while maintaining operational flexibility.

## Description
One row represents a single configured exception that permits modifications to accounting records that would otherwise be restricted by a system-wide lock date. This is a raw landed staging table containing the configuration state for these lock overrides, used to track who authorized the exception and the specific date parameters involved.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_lock_exception_id_seq`. |
| company_id | INTEGER | false | Foreign key to the company | Identifies which company the lock exception applies to. |
| user_id | INTEGER | true | Foreign key to the user | The specific user granted the exception, if applicable. |
| create_uid | INTEGER | true | Creator user ID | Audit field: ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field: ID of the user who last updated this record. |
| reason | VARCHAR | true | Justification for exception | Textual explanation for why the lock was bypassed. |
| lock_date_field | VARCHAR | false | Target field name | The specific date field being overridden. |
| lock_date | DATE | true | Lock date value | The specific date threshold being applied. |
| company_lock_date | DATE | true | Company-wide lock date | The broader company lock date context. |
| active | BOOLEAN | true | Soft-delete flag | If false, the exception is no longer in effect. |
| end_datetime | TIMESTAMP | true | Expiration timestamp | The point in time when this exception expires. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit field: UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit field: UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo naming convention for company links).
    - `user_id` → `res_users.id` (Guess: standard Odoo naming convention for user links).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs and potentially sensitive business reasons for financial overrides; ensure access is restricted.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` to retrieve current exceptions.
- **Data Quality:** `lock_date_field` is a string; ensure downstream logic handles potential variations in field naming conventions.