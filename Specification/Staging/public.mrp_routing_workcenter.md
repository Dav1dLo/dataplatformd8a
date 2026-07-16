# mrp_routing_workcenter

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`mrp_routing_workcenter`), the use of `create_uid`/`write_uid` audit columns, and the `nextval` sequence pattern typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the Manufacturing (MRP) module, specifically the definition of routing operations. It maps specific work centers to Bill of Materials (BOM) steps, defining the sequence of operations and time requirements for manufacturing processes.

## Description
One row represents a single work center assignment within a manufacturing routing step for a specific Bill of Materials. It acts as a raw landed copy of the Odoo `mrp.routing.workcenter` model, capturing the configuration of how a product is processed at a specific station.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mrp_routing_workcenter_id_seq`. |
| workcenter_id | INTEGER | false | Foreign key to work center | Links to the specific machine or station. |
| sequence | INTEGER | true | Display order | Determines the order of operations in the routing. |
| bom_id | INTEGER | false | Foreign key to BOM | Links to the parent Bill of Materials. |
| time_mode_batch | INTEGER | true | Batch size for time calculation | Used when calculating cycle times for multiple units. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| name | VARCHAR | false | Operation name | Descriptive label for the routing step. |
| worksheet_type | VARCHAR | true | Type of instruction | Defines the format of the work instructions. |
| worksheet_google_slide | VARCHAR | true | URL/ID for instructions | Link to external Google Slides documentation. |
| time_mode | VARCHAR | true | Time calculation mode | Strategy for calculating cycle time (e.g., 'manual', 'auto'). |
| note | TEXT | true | Operational notes | Additional instructions for the operator. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the routing step is currently enabled. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| time_cycle_manual | DOUBLE PRECISION | true | Manual cycle time | Time in minutes/seconds for the operation. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id` (Inferred from Odoo naming convention).
    - `bom_id` → `mrp_bom.id` (Inferred from Odoo naming convention).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column is a soft-delete flag; ensure queries filter by `active = TRUE` unless historical analysis is required.
- **Timestamps:** Timestamps are stored in UTC as per standard Odoo configuration.
- **PII:** No direct PII is present, though `create_uid` and `write_uid` link to user identities in the `res_users` table.
- **Data Precision:** `time_cycle_manual` units should be verified against Odoo system settings (typically minutes).