# mrp_consumption_warning_line

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`mrp_consumption_warning_line`), the use of `create_uid`/`write_uid` audit columns, and the standard sequence-based primary key pattern typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the Manufacturing (MRP) module's consumption tracking process. It logs discrepancies between expected and actual material consumption during production orders, specifically flagging lines where the consumed quantity deviates from the planned quantity for a given product.

## Description
One row represents a single line item within an MRP consumption warning, detailing the expected versus actual quantity consumed for a specific product in a production order. As a staging table, it serves as a raw, direct reflection of the Odoo database record, intended for downstream transformation into analytical consumption variance models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| mrp_consumption_warning_id | INTEGER | false | Parent warning ID | Foreign key to the header record. |
| mrp_production_id | INTEGER | false | Production order ID | Links to the specific manufacturing order. |
| product_id | INTEGER | false | Product ID | The item being consumed. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time. |
| product_consumed_qty_uom | DOUBLE PRECISION | true | Actual quantity consumed | Measured in the product's unit of measure. |
| product_expected_qty_uom | DOUBLE PRECISION | true | Expected quantity | The planned consumption amount. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mrp_consumption_warning_id` → `mrp_consumption_warning.id` (Inferred from Odoo naming convention).
    - `mrp_production_id` → `mrp_production.id` (Inferred from Odoo naming convention).
    - `product_id` → `product_product.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in the Odoo server's local time; verify if the server is configured for UTC.
- **Data Precision:** `DOUBLE PRECISION` is used for quantities; ensure rounding logic is applied consistently in downstream models to avoid floating-point errors.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs and will require a join to `res_users` to resolve to human-readable names.