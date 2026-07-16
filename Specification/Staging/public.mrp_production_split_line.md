# mrp_production_split_line

## Source system
This table originates from an Odoo ERP environment, indicated by the naming convention `mrp_production_split_line` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the manufacturing execution process, specifically tracking the splitting of production orders. It records the granular distribution of quantities across split production lines, allowing for the management of partial production batches or sub-assemblies within the broader manufacturing workflow.

## Description
One row in this table represents a single line item within a production split event, detailing the quantity allocated to that specific split. As a staging table, it serves as a raw, landed copy of the Odoo `mrp.production.split.line` model, capturing the state of production splits as they exist in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| mrp_production_split_id | INTEGER | false | Foreign key to parent split | Links to the header record in `mrp_production_split`. |
| user_id | INTEGER | true | Responsible user ID | The user associated with this specific split line. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| quantity | NUMERIC | false | Split quantity | The amount of product allocated to this split line. |
| date | TIMESTAMP | true | Transaction date | The effective date of the split operation. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp of record insertion in UTC. |
| write_date | TIMESTAMP | true | Record modification timestamp | Timestamp of last update in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mrp_production_split_id` → `mrp_production_split.id`: This column links the line item to its parent production split header.
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creation.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** `user_id`, `create_uid`, and `write_uid` link to internal system users; ensure these are handled according to internal access policies.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are active unless otherwise specified by the source system's business logic.
- **Precision:** The `quantity` column is `NUMERIC` without defined scale/precision; verify if downstream systems require explicit rounding or casting to avoid precision loss.