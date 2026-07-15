# base_import_module

## Source system
This table originates from an Odoo ERP system. The naming convention (`base_import_module`), the presence of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of Odoo-specific sequence generators for the primary key are characteristic of the Odoo framework's internal module management and data import infrastructure.

## Functional process 
This table supports the module installation and data import pipeline. It tracks the state of module imports, including dependency resolution, configuration flags (demo data, force installation), and the storage of the actual module binary files being processed by the system.

## Description
One row in this table represents a single module import or installation request submitted to the system. It serves as a raw staging record containing the binary module file and the metadata required to execute the installation process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `base_import_module_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users.id`. |
| state | VARCHAR | true | Current status of the import process | Likely values include 'init', 'done', 'error'. |
| import_message | TEXT | true | Log or error message from the import | Contains diagnostic info if the import fails. |
| modules_dependencies | TEXT | true | List of required module dependencies | Often stored as a JSON or comma-separated string. |
| force | BOOLEAN | true | Flag to force installation | Overrides standard dependency checks. |
| with_demo | BOOLEAN | true | Flag to include demo data | If true, demo data is loaded during import. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| module_file | BYTEA | false | Binary content of the module file | The actual .zip or .tar.gz module package. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming for creator references).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming for modifier references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `module_file` column contains binary data that may include proprietary code or sensitive configuration files; ensure appropriate access controls.
- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Retention:** This table acts as a staging area for imports; rows may be purged or archived by the application after the import process completes.
- **Binary Handling:** The `module_file` column is `BYTEA` (PostgreSQL binary); ensure your query tools are configured to handle large binary objects to avoid memory issues.