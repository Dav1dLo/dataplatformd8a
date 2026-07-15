# ir_module_module_exclusion

## Source system
This table originates from an Odoo ERP system, as indicated by the `ir_module_` prefix, which is the standard naming convention for Odoo's internal registry (Information Registry) tables.

## Functional process 
This table supports the module management and dependency resolution process within the Odoo framework. It tracks exclusion rules between different software modules, ensuring that conflicting modules are not installed simultaneously in the environment.

## Description
One row in this table represents a specific exclusion rule defined between two modules or a module and a specific feature set. It acts as a raw landing copy of the Odoo `ir.module.module.exclusion` model, capturing the configuration state of module compatibility constraints.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence ID. |
| module_id | INTEGER | true | Foreign key to the module | References the primary module involved in the exclusion. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this exclusion record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| name | VARCHAR | true | Exclusion name or description | Often contains the technical name of the conflicting module. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM upon record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM upon record modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `public.ir_module_module.id`: This column links to the module registry table.
    - `create_uid` → `public.res_users.id`: Standard Odoo pattern for tracking record ownership.
    - `write_uid` → `public.res_users.id`: Standard Odoo pattern for tracking record modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are typically stored in UTC by Odoo, but verify against the application server configuration.
- **Soft Deletes:** Odoo generally performs hard deletes on records; however, check for existence of `active` columns if filtering for historical data.
- **Data Integrity:** As a staging table, this may contain orphaned records if the source system's referential integrity was not strictly enforced during the extraction process.
- **PII:** Contains user IDs (`create_uid`, `write_uid`) which may link to sensitive user information in other tables.