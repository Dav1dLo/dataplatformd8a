# stock_return_picking_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`stock_return_picking_line`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of sequence-based primary keys (`nextval` on `id`).

## Functional process 
This table supports the inventory return process, specifically tracking individual line items included in a return picking wizard. It links products being returned to their original stock moves and determines whether the return should trigger a financial refund.

## Description
One row represents a single line item within a stock return operation, detailing the quantity of a specific product being returned. As a staging table, it serves as a raw, landed copy of the Odoo `stock.return.picking.line` model, capturing the state of return lines before they are processed into inventory movements.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `stock_return_picking_line_id_seq`. |
| product_id | INTEGER | false | Foreign key to the product being returned | References `product.product`. |
| wizard_id | INTEGER | true | Foreign key to the return wizard | Links to the parent `stock.return.picking` wizard instance. |
| move_id | INTEGER | true | Foreign key to the original stock move | References `stock.move` being returned. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res.users`. |
| quantity | NUMERIC | false | Quantity of the product to return | Unit depends on the product's UoM. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| to_refund | BOOLEAN | true | Refund flag | Indicates if this return line should trigger a credit note. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product.id` (Inferred from Odoo naming convention)
    - `wizard_id` → `stock_return_picking.id` (Inferred from Odoo naming convention)
    - `move_id` → `stock_move.id` (Inferred from Odoo naming convention)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to implement soft deletes; it reflects the state of the return wizard lines.
- **Data Integrity:** `wizard_id` and `move_id` are nullable, which may occur if the return line is orphaned or in a draft state.
- **Precision:** `quantity` is `NUMERIC` without defined scale; check source DDL if high-precision decimal math is required for downstream aggregation.