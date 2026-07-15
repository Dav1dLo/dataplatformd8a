# ir_exports

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of sequence-based default values for the `id` column, is characteristic of the Odoo ORM framework.

## Functional process 
This table supports the data export management process within the ERP. It tracks the configuration or history of data exports performed by users, likely storing metadata about which resources were exported and by whom, facilitating audit trails for data extraction activities.

## Description
One row in this table represents a single export configuration or historical record of an export event. It serves as a raw landed copy of the export metadata from the source ERP, capturing the identity of the user who created or modified the export record and the associated resource being exported.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.ir_exports_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the users table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the users table. |
| name | VARCHAR | true | Name or label of the export | Length inferred from samples — confirm against source DDL. |
| resource | VARCHAR | true | The resource or model being exported | Likely an Odoo model name (e.g., 'res.partner'). |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid`, which link to internal user identities; ensure these are handled according to internal PII policies.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are hard-deleted if removed from the source.
- **Data Precision:** The `VARCHAR` columns do not have defined lengths in the metadata; downstream consumers should implement robust handling for potentially long strings.