# base_language_export

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the presence of `model_id` and `BYTEA` data fields are characteristic of Odoo's internal ORM-based data storage for language translation exports.

## Functional process 
This table supports the localization and translation management process. It tracks the generation of language files (e.g., PO or CSV files) for specific system models, allowing users to export translation domains for external editing or system migration.

## Description
One row in this table represents a single language export request or generated file record. It serves as a staging entity that captures the metadata and binary content of translation exports triggered within the ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_language_export_id_seq`. |
| model_id | INTEGER | true | Foreign key to the target model | References the system model being exported. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the export. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| name | VARCHAR | true | Export file name | Descriptive name for the exported file. |
| lang | VARCHAR | false | Language code | ISO language code (e.g., 'en_US'). |
| format | VARCHAR | false | File format | Format of the export (e.g., 'po', 'csv'). |
| export_type | VARCHAR | false | Export category | Defines the scope of the export. |
| domain | VARCHAR | true | Filter criteria | The domain filter applied to the export. |
| state | VARCHAR | true | Lifecycle status | Current status of the export process. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC. |
| data | BYTEA | true | Binary file content | The actual exported file data. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `model_id` → `ir_model.id` (Guess: standard Odoo reference to system models).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Binary Data:** The `data` column contains `BYTEA` (binary) content; ensure your ETL pipeline handles binary extraction correctly.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** `create_uid` and `write_uid` link to user records; ensure access controls are applied if exposing user identity.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.