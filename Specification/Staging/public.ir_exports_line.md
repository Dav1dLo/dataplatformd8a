# ir_exports_line

## Source system
This table originates from an Odoo ERP system. The naming convention (`ir_exports_line`, `create_uid`, `write_uid`, `create_date`) is characteristic of Odoo's internal registry (IR) models, specifically those managing export configurations or data export templates.

## Functional process 
This table supports the configuration of data export templates within the ERP. It tracks the individual lines or fields included in a specific export definition, allowing users to map system fields to custom export files.

## Description
One row represents a single field or column definition associated with a specific data export template. This is a raw landing table in the staging layer, capturing the structural configuration of exports as defined in the source application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.ir_exports_line_id_seq`. |
| export_id | INTEGER | true | Foreign key to the parent export template | Links to the header record defining the export. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users` table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users` table. |
| name | VARCHAR | true | Name or field path of the exported item | Likely contains the technical field name or label. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `export_id` → `ir_exports.id`: This column represents the parent-child relationship between an export definition and its constituent lines.
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record ownership.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **PII:** This table contains metadata about system configurations and does not inherently contain PII, though `name` could potentially reveal internal field structures.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; standard Odoo behavior is hard deletion unless otherwise specified.
- **Data Integrity:** As a staging table, ensure that `export_id` is validated against the parent `ir_exports` table before performing joins, as orphaned records may exist during ingestion windows.