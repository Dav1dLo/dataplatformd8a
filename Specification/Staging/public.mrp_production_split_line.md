# mrp_production_split_line

## Source system
This table originates from Odoo ERP, indicated by the naming convention `mrp_production_split_line` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the manufacturing execution process, specifically tracking the splitting of production orders. It records the breakdown of quantities for a production split event, likely used to manage partial completions or batching within the manufacturing lifecycle.

## Description
One row in this table represents a single line item within a production split operation, detailing the quantity assigned to that specific split. It serves as a raw landed copy of the Odoo `mrp.production.split.line` model, capturing the granular distribution of production quantities at the time of the split.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| mrp_production_split_id | INTEGER | false | Foreign key to parent split | Links to the header record of the production split. |
| user_id | INTEGER | true | Responsible user ID | The user associated with this specific split line. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| quantity | NUMERIC | false | Split quantity | The amount of product allocated to this split line. |
| date | TIMESTAMP | true | Transaction date | The effective date of the split line. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created in the source. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mrp_production_split_id` → `mrp_production_split.id` (Inferred from standard Odoo naming conventions for parent-child relationships).
    - `user_id`, `create_uid`, `write_uid` → `res_users.id` (Standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`user_id`, `create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by Odoo's internal logic.
- **Precision:** The `quantity` column is `NUMERIC` without defined scale/precision; verify if downstream calculations require explicit casting to avoid rounding errors.