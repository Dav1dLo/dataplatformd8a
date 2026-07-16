# pos_order_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and the use of `nextval` sequences for primary keys, which are characteristic of the Odoo PostgreSQL schema.

## Functional process 
This table supports the Point of Sale (POS) transaction process, specifically tracking individual line items within a sales order. It captures product-level details, pricing, discounts, and quantities for items sold through a retail or service POS interface.

## Description
One row represents a single line item within a POS order, detailing the product sold, its associated pricing, and quantity. This is a raw staging table containing the direct landing of POS order line data from the Odoo database, intended for downstream transformation into sales fact tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `pos_order_line_id_seq`. |
| company_id | INTEGER | true | Identifier for the company entity | Multi-tenant support. |
| product_id | INTEGER | false | Reference to the product sold | Links to product master. |
| order_id | INTEGER | false | Reference to the parent POS order | Links to `pos_order` table. |
| refunded_orderline_id | INTEGER | true | Reference to original line if this is a refund | Used for tracking returns. |
| combo_parent_id | INTEGER | true | Reference to parent item in a combo | Used for meal deals/bundles. |
| combo_item_id | INTEGER | true | Reference to combo definition | Links to combo configuration. |
| create_uid | INTEGER | true | User ID who created the record | Links to `res_users`. |
| write_uid | INTEGER | true | User ID who last updated the record | Links to `res_users`. |
| name | VARCHAR | false | Line item description or label | Often contains product name/variant. |
| notice | VARCHAR | true | Internal notice or comment | |
| price_type | VARCHAR | true | Pricing strategy applied | e.g., 'fixed', 'percentage'. |
| full_product_name | VARCHAR | true | Complete product name | May include variants/attributes. |
| customer_note | VARCHAR | true | Note provided by the customer | |
| uuid | VARCHAR | true | Unique identifier for synchronization | Used for offline-to-online sync. |
| note | VARCHAR | true | General line item note | |
| price_unit | NUMERIC | true | Unit price of the product | |
| qty | NUMERIC | true | Quantity sold | |
| price_subtotal | NUMERIC | false | Subtotal excluding tax | |
| price_subtotal_incl | NUMERIC | false | Subtotal including tax | |
| total_cost | NUMERIC | true | Calculated cost of goods sold | |
| discount | NUMERIC | true | Discount percentage or amount | |
| skip_change | BOOLEAN | true | Flag to skip change calculation | |
| is_total_cost_computed | BOOLEAN | true | Status of cost calculation | |
| is_edited | BOOLEAN | true | Flag if line was manually edited | |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed. |
| price_extra | DOUBLE PRECISION | true | Additional price modifiers | |
| sale_order_origin_id | INTEGER | true | Link to original sales order | Used for click-and-collect. |
| sale_order_line_id | INTEGER | true | Link to original sales order line | |
| down_payment_details | TEXT | true | Details for down payments | |
| qty_delivered | DOUBLE PRECISION | true | Quantity actually delivered | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `order_id` → `pos_order.id` (Standard Odoo relationship for order lines).
    - `product_id` → `product_product.id` (Standard Odoo relationship for product reference).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):**
    - `uuid` (Used for cross-system synchronization).

## Caveats for downstream consumers

- **Sensitive Data:** `customer_note` may contain PII; ensure appropriate masking if exposed to non-authorized users.
- **Timestamps:** `create_date` and `write_date` are stored in the database timezone (typically UTC in Odoo).
- **Soft Deletes:** This table does not appear to implement soft deletes; records are typically permanent unless purged by the source system.
- **Precision:** `NUMERIC` types do not have defined scales in the metadata; assume standard currency precision (e.g., 2 or 4 decimal places) and verify against source DDL if performing exact financial reconciliations.