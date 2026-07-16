# pos_bill

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based defaults (`nextval('"public".pos_bill_id_seq'::regclass)`).

## Functional process 
This table supports the Point of Sale (POS) configuration and billing management process. It appears to store definitions for bill types or payment configurations used within the POS module, determining how transactions are processed or categorized at the register.

## Description
One row represents a single bill configuration or payment definition record within the Point of Sale system. This table serves as a raw landed staging entity, capturing the configuration state as it exists in the source database for downstream integration into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the record. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table in the source system. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res_users` table in the source system. |
| name | VARCHAR | true | Bill or configuration name | Descriptive label for the bill type. |
| value | NUMERIC | false | Monetary or configuration value | Represents the value associated with the bill; precision not specified in DDL. |
| for_all_config | BOOLEAN | true | Global configuration flag | Indicates if this bill configuration applies to all POS instances. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in the source system's local time. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in the source system's local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for record ownership).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure access controls are applied if user PII is exposed in the linked `res_users` table.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are stored in the source system's local time; verify the source timezone offset before performing cross-regional analysis.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are currently active unless otherwise specified by the source system's business logic.
- **Precision:** The `value` column uses `NUMERIC` without defined scale/precision; check for potential rounding variations if aggregating across different source instances.