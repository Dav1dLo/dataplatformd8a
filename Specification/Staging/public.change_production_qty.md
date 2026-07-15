# change_production_qty

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mo_id`, `create_uid`, `write_uid`, `write_date`) and the use of standard Odoo sequence-based primary keys.

## Functional process 
This table supports the Manufacturing Order (MO) lifecycle, specifically tracking adjustments made to the planned production quantities. It logs the history of quantity changes for manufacturing orders, allowing for auditability of production plan modifications.

## Description
Each row represents a single adjustment event where the production quantity of a manufacturing order was modified. This is a staging layer table providing a raw, append-only or update-tracked record of quantity changes linked to specific manufacturing orders.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.change_production_qty_id_seq`. |
| mo_id | INTEGER | false | Manufacturing Order ID | Foreign key reference to the parent manufacturing order. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the quantity change record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| product_qty | NUMERIC | false | Adjusted quantity | The new quantity value set for the production order. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the change record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mo_id` → `mrp_production.id` (Inferred based on standard Odoo naming conventions for manufacturing orders).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against an employee or user directory to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not explicitly show a `deleted_at` or `active` flag; assume all records are active unless otherwise specified by the source system's logic.
- **Precision:** `product_qty` is `NUMERIC` without defined scale/precision; verify if downstream systems require rounding to specific decimal places (e.g., 2 or 4) based on the product unit of measure.