# theme_ir_asset

## Source system
This table originates from an Odoo ERP system. The naming convention (`ir_asset`), the presence of `create_uid`/`write_uid` audit columns, and the use of `nextval` sequences for primary keys are characteristic patterns of the Odoo "ir" (Internal Resource) module architecture.

## Functional process 
This table supports the management of web assets (CSS, JS, or other static resources) within the Odoo web framework. It tracks the registration and ordering of assets that are bundled and served to the frontend, ensuring that directives and file paths are correctly associated with specific asset bundles.

## Description
One row represents a single static asset file or directive registered within the system's asset management framework. It captures the file path, its associated bundle, and the sequence in which it should be loaded. This table serves as a raw landing copy of the system's internal asset registry, used to track which files constitute the frontend theme and their current active status.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `theme_ir_asset_id_seq`. |
| sequence | INTEGER | false | Display or load order | Determines the priority of the asset in the bundle. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the record. |
| key | VARCHAR | true | Unique identifier key | Often used for programmatic lookups of the asset. |
| name | VARCHAR | false | Asset display name | Human-readable name of the asset. |
| bundle | VARCHAR | false | Asset bundle name | The group (e.g., 'web.assets_common') the asset belongs to. |
| directive | VARCHAR | true | Asset directive | Specific instruction for the asset loader. |
| path | VARCHAR | false | File system path | The location of the asset file. |
| target | VARCHAR | true | Target environment | Defines where the asset is applied. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the asset is currently enabled. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the system upon insertion. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the system upon modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern for user references).
- **Natural keys (inferred):** 
    - `path` (Assuming the file path is unique within the asset registry).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the database server's local time; verify if the Odoo instance is configured for UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless auditing historical asset configurations.
- **Data Types:** `VARCHAR` columns do not have explicit length constraints defined in the metadata; assume variable length and handle potential truncation if loading into fixed-width staging areas.
- **Audit Columns:** `create_uid` and `write_uid` are integers referencing the internal user table; they will not resolve to names without a join to the `res_users` table.