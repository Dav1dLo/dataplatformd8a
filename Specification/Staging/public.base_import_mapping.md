# base_import_mapping

## Source system
This table originates from an Odoo ERP system. The naming convention (`base_import_mapping`, `res_model`, `create_uid`, `write_uid`) is characteristic of the Odoo framework's internal metadata tables used to track data import configurations.

## Functional process 
This table supports the data import management process. It stores the mapping configurations that define how external data columns (from CSV or Excel files) are mapped to specific fields within Odoo's internal data models (`res_model`).

## Description
One row in this table represents a single field-to-column mapping rule used during a data import operation. It acts as a staging record that persists the relationship between a source file column and a destination model field, allowing the system to repeat or audit import mappings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_import_mapping_id_seq`. |
| create_uid | INTEGER | true | User ID who created the mapping | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the mapping | References `res_users.id`. |
| res_model | VARCHAR | true | Target Odoo model name | e.g., 'res.partner', 'product.product'. |
| column_name | VARCHAR | true | Name of the column in the source file | The header name from the imported file. |
| field_name | VARCHAR | true | Target field name in the Odoo model | The technical field name in the database. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed based on Odoo standards. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo naming convention for audit fields).
    - `write_uid` → `res_users.id` (Inferred from Odoo naming convention for audit fields).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` identify internal users; ensure these are handled according to internal access policies.
- **Timezones:** Timestamps are stored in UTC; verify against the Odoo server configuration if local time conversion is required.
- **Data Integrity:** This is a staging table; records may be transient or subject to cleanup by the Odoo `base_import` module.
- **Model Names:** The `res_model` column contains string identifiers for Odoo models; these are case-sensitive and should be treated as unique identifiers for the target entity.