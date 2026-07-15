# base_language_import

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the specific structure of language import tracking are characteristic of Odoo's internal ORM metadata and localization management modules.

## Functional process 
This table supports the localization and translation management process. It tracks the ingestion of language files (e.g., PO or CSV files) used to update or extend the system's multi-language interface, allowing administrators to import custom translations for modules.

## Description
One row represents a single language file import event, containing the metadata and the raw binary content of the translation file. This is a raw staging table that captures the initial state of an import request before the translation data is parsed and applied to the system's translation registry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_language_import_id_seq`. |
| create_uid | INTEGER | true | User ID who initiated the import | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| name | VARCHAR | false | Descriptive name of the import | Human-readable label for the import task. |
| code | VARCHAR | false | Language code | ISO-639 language code (e.g., 'en_US'). |
| filename | VARCHAR | false | Original source filename | The name of the file uploaded by the user. |
| overwrite | BOOLEAN | true | Overwrite existing translations flag | If true, replaces existing terms with imported ones. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |
| data | BYTEA | false | Binary file content | The raw content of the uploaded translation file. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit field for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `data` column contains raw file content which may contain proprietary or sensitive translation strings.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Handling:** The `data` column is stored as `BYTEA` (binary); ensure your downstream processing pipeline is equipped to handle binary stream decoding if you intend to inspect the file contents.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if they disappear from the source.