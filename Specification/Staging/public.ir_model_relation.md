# ir_model_relation

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_model_...` is characteristic of Odoo's internal registry (Information Registry) tables, which manage the metadata and structural relationships of the application's data models and modules.

## Functional process 
This table supports the Odoo framework's internal dependency and relationship management. It tracks the associations between data models (`model`) and the software modules (`module`) that define or extend them, ensuring the system correctly loads and initializes database structures during module installation or upgrades.

## Description
One row in this table represents a specific relationship or dependency link between a data model and a module within the Odoo ecosystem. It serves as a raw landed copy of the system's internal registry, capturing the structural metadata required for the application to map business objects to their originating code modules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `ir_model_relation_id_seq`. |
| model | INTEGER | false | Foreign key to the model | References `ir_model.id`. |
| module | INTEGER | false | Foreign key to the module | References `ir_module_module.id`. |
| create_uid | INTEGER | true | Creator user ID | References `res_users.id`. |
| write_uid | INTEGER | true | Last modifier user ID | References `res_users.id`. |
| name | VARCHAR | false | Relationship identifier | Usually a descriptive string of the relation. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in server local time. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model` → `ir_model.id`: Links the relation to the specific data model definition.
    - `module` → `ir_module_module.id`: Links the relation to the specific Odoo module.
    - `create_uid` → `res_users.id`: Identifies the user who created the record.
    - `write_uid` → `res_users.id`: Identifies the user who last updated the record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are stored in the Odoo server's local time; verify the server timezone configuration before performing time-series analysis.
- This is a system-level metadata table; it is generally not intended for end-user reporting but rather for understanding the structural dependencies of the ERP instance.
- No explicit soft-delete flag is present; standard Odoo practice is to physically delete records, though some modules may implement custom archival logic.