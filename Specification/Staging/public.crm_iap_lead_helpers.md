# crm_iap_lead_helpers

## Source system
This table originates from an Odoo ERP or a similar Python-based framework using the Odoo ORM pattern. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of `nextval` on a sequence for the `id` column, is a signature pattern for Odoo's base model architecture.

## Functional process 
This table supports the internal audit and tracking of "Lead Helper" records within a CRM lead-to-cash pipeline. It likely acts as a join or configuration table that tracks which system users created or modified specific lead-related helper entities, facilitating user accountability and record lifecycle management.

## Description
Each row represents an audit trail entry for a specific helper record associated with a CRM lead. It serves as a raw landed copy of the system's internal tracking metadata, capturing the identity of the creator and the last modifier, along with their respective timestamps.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator; unique identifier for the record. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the system's internal user table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC; format is standard PostgreSQL timestamp. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC; updates automatically on record change. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking record ownership.
    - `write_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking the last user to edit the record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** While this table contains no direct PII, the `create_uid` and `write_uid` link to user identities which may be considered sensitive in some compliance contexts.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployment practices.
- **Soft Deletes:** This table does not appear to have an `active` or `deleted_at` flag; assume all records are currently active unless otherwise specified by the source system's business logic.
- **Data Integrity:** As a staging table, this data is expected to be a direct reflection of the source; verify if `create_uid` or `write_uid` can be null for system-generated records.