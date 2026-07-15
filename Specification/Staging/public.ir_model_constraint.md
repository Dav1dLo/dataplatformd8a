# ir_model_constraint

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_model_constraint` (Internal Registry model constraint) is a standard pattern used by the Odoo framework to track database-level constraints (like unique indexes or check constraints) associated with its ORM models.

## Functional process 
This table supports the Odoo metadata management and schema synchronization process. It tracks the constraints defined within the application's modules, ensuring that the underlying database schema remains consistent with the ORM model definitions during module installation and upgrades.

## Description
One row in this table represents a single database constraint (such as a unique constraint or check constraint) associated with a specific Odoo model. This is a raw landing table in the staging layer, capturing the metadata state of the application's schema constraints as defined in the source system's internal registry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_model_constraint_id_seq`. |
| model | INTEGER | false | Foreign key to `ir_model` | Links to the model definition this constraint belongs to. |
| module | INTEGER | false | Foreign key to `ir_module_module` | Identifies the Odoo module that introduced this constraint. |
| create_uid | INTEGER | true | Creator user ID | Links to `res_users` for the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res_users` for the user who last updated this record. |
| name | VARCHAR | false | Constraint name | The identifier of the constraint in the database. |
| definition | VARCHAR | true | SQL definition | The raw SQL expression or definition of the constraint. |
| type | VARCHAR(1) | false | Constraint type | Likely 'u' for unique, 'c' for check, etc. |
| message | JSONB | true | Error message | Localized error messages associated with the constraint. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server time (usually UTC). |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server time (usually UTC). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model` → `ir_model.id`: Links the constraint to the specific ORM model.
    - `module` → `ir_module_module.id`: Links the constraint to the defining module.
    - `create_uid` → `res_users.id`: References the user who created the record.
    - `write_uid` → `res_users.id`: References the user who last modified the record.
- **Natural keys (inferred):** 
    - `name`: In Odoo, constraint names are typically unique within the database schema.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Data Sensitivity:** Contains no PII, but exposes internal database schema structure and module names.
- **Soft Deletes:** This table does not implement soft deletes; records are typically removed when the corresponding module is uninstalled or the model is dropped.
- **JSONB:** The `message` column contains structured data; ensure your downstream processing layer can handle JSONB parsing.
- **Type Column:** The `type` column is a single character; verify the mapping of these codes (e.g., 'u', 'c', 'f') against Odoo documentation for accurate filtering.