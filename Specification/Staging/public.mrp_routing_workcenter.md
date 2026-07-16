# mrp_routing_workcenter

## Source system
This table originates from Odoo ERP, indicated by the naming convention `mrp_routing_workcenter` (Manufacturing Resource Planning), the use of `create_uid`/`write_uid` audit columns, and the sequence-based primary key pattern typical of the Odoo framework.

## Functional process 
This table supports the manufacturing routing process, specifically defining the sequence of operations or work centers required to produce a Bill of Materials (BOM). It links specific work centers to a BOM, determining the order of production steps and the associated time metrics for manual operations.

## Description
One row represents a single step or work center assignment within a manufacturing routing for a specific Bill of Materials. This is a raw landed staging table containing the configuration and metadata for production routing steps, including references to external documentation like Google Slides and manual cycle time estimates.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mrp_routing_workcenter_id_seq`. |
| workcenter_id | INTEGER | false | Foreign key to work center | References the resource performing the work. |
| sequence | INTEGER | true | Operation order | Determines the sequence of steps in the routing. |
| bom_id | INTEGER | false | Foreign key to BOM | Links this step to a specific Bill of Materials. |
| time_mode_batch | INTEGER | true | Batch size for time calculation | Used to calculate cycle time per unit. |
| create_uid | INTEGER | true | Creator user ID | References the system user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | References the system user who last modified the record. |
| name | VARCHAR | false | Operation name | Descriptive name of the routing step. |
| worksheet_type | VARCHAR | true | Type of instruction | Defines the format of the work instructions. |
| worksheet_google_slide | VARCHAR | true | Google Slide URL | Link to external work instruction documentation. |
| time_mode | VARCHAR | true | Time calculation method | Strategy for calculating operation duration. |
| note | TEXT | true | Operational notes | Free-text instructions or comments for the operator. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the routing step is currently enabled. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time. |
| time_cycle_manual | DOUBLE PRECISION | true | Manual cycle time | Estimated duration for the operation in minutes. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id` (Inferred from Odoo naming convention).
    - `bom_id` → `mrp_bom.id` (Inferred from Odoo naming convention).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = TRUE` unless historical analysis is required.
- **Timestamps:** `create_date` and `write_date` are stored in the application server's local time; verify the server timezone configuration to normalize to UTC.
- **Data Precision:** `VARCHAR` columns do not have defined lengths in the source metadata; downstream systems should handle variable-length strings appropriately.
- **PII/Sensitive Data:** The `note` field may contain unstructured text; audit for potential sensitive information before exposing to end-user reporting layers.