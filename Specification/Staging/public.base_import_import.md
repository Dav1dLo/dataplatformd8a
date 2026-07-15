# base_import_import

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `base_import_import` and the presence of `res_model`, `create_uid`, and `write_uid` are characteristic of Odoo's internal data import management framework.

## Functional process 
This table supports the data import process within the ERP, tracking the history and metadata of files uploaded by users to perform bulk data imports into specific system models. It acts as a staging log for tracking which files were processed, by whom, and for which business entities.

## Description
One row in this table represents a single file upload event initiated by a user to import data into the system. It serves as a raw landing record for the import process, capturing the file content, the target model, and audit timestamps.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_import_import_id_seq`. |
| create_uid | INTEGER | true | User ID who initiated the import | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| res_model | VARCHAR | true | Target Odoo model name | e.g., 'res.partner', 'sale.order'. |
| file_name | VARCHAR | true | Original name of the uploaded file | |
| file_type | VARCHAR | true | MIME type or file extension | |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |
| file | BYTEA | true | Binary content of the uploaded file | Contains the raw import data. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming conventions for user tracking).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming conventions for user tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- The `file` column contains binary data (`BYTEA`); ensure your query tools can handle large binary objects before selecting this column.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table tracks the *metadata* and *binary blob* of the import; it does not contain the parsed rows of the imported data itself.
- No explicit soft-delete flag is present; records are typically permanent unless purged by system maintenance.