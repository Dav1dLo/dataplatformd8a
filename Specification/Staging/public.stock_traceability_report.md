# stock_traceability_report

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default for the `id` column are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports inventory management and audit tracking processes. It serves as a metadata container for tracking the lifecycle and modification history of stock-related records, ensuring traceability of who performed an action and when it occurred within the supply chain module.

## Description
One row in this table represents a single audit or traceability event associated with a stock record. As a staging table, it provides a raw, landed copy of system-generated metadata used to track the provenance and modification history of inventory data.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.stock_traceability_report_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Inferred UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess based on Odoo naming patterns).
    - `write_uid` → `res_users.id` (guess based on Odoo naming patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` identify internal system users; ensure these are handled according to internal access policies.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Lifecycle:** This table appears to be an audit log; check for potential high-volume growth if the source system logs every minor update.
- **Soft Deletes:** No explicit soft-delete flag is present; assume records are immutable once created or updated.