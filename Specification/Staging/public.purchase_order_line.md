# purchase_order_line

## Source system
This table originates from an Odoo ERP system. The naming conventions (e.g., `product_uom`, `create_uid`, `write_date`, `analytic_distribution`) and the specific structure of fields like `qty_received_method` and `display_type` are characteristic of the Odoo purchase module's data schema.

## Functional process 
This table supports the procurement and "Procure-to-Pay" process. It tracks individual line items within a purchase order, managing the lifecycle of requested quantities, received goods, and invoiced amounts. It integrates with inventory management via `product_id` and `location_final_id`, and financial tracking via `analytic_distribution` and `currency_id`.

## Description
One row represents a single line item within a purchase order, detailing the product, quantity, pricing, and fulfillment status. This table serves as a raw landed copy of the Odoo `purchase.order.line` model, capturing the state of procurement lines at the grain of one row per line per order.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order of the line | Used for UI sorting. |
| product_uom | INTEGER | true | Unit of measure ID | Foreign key to UoM table. |
| product_id | INTEGER | true | Product ID | Foreign key to product master. |
| order_id | INTEGER | false | Parent purchase order ID | Foreign key to purchase_order. |
| company_id | INTEGER | true | Company ID | Multi-company context. |
| partner_id | INTEGER | true | Vendor/Partner ID | Foreign key to res_partner. |
| currency_id | INTEGER | true | Currency ID | Foreign key to currency table. |
| product_packaging_id | INTEGER | true | Packaging type ID | Reference to packaging configuration. |
| create_uid | INTEGER | true | Creator user ID | Audit field. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field. |
| state | VARCHAR | true | Line status | e.g., draft, purchase, done, cancel. |
| qty_received_method | VARCHAR | true | Method for receiving goods | e.g., manual, stock_move. |
| display_type | VARCHAR | true | Line display type | Used for section headers or notes. |
| analytic_distribution | JSONB | true | Analytic accounting mapping | JSON structure for cost center allocation. |
| name | TEXT | false | Line description | Product name or custom description. |
| product_qty | NUMERIC | false | Ordered quantity | Base quantity. |
| discount | NUMERIC | true | Discount percentage | Applied to unit price. |
| price_unit | NUMERIC | false | Unit price | Price per UoM. |
| price_subtotal | NUMERIC | true | Subtotal amount | Pre-tax total. |
| price_total | NUMERIC | true | Total amount | Post-tax total. |
| qty_invoiced | NUMERIC | true | Quantity already invoiced | Progress tracking. |
| qty_received | NUMERIC | true | Quantity received | Progress tracking. |
| qty_received_manual | NUMERIC | true | Manually adjusted received qty | Override value. |
| qty_to_invoice | NUMERIC | true | Remaining quantity to invoice | Calculated field. |
| is_downpayment | BOOLEAN | true | Downpayment flag | Indicates if line is a deposit. |
| date_planned | TIMESTAMP | true | Expected delivery date | Scheduled arrival. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC. |
| product_uom_qty | DOUBLE PRECISION | true | UoM converted quantity | Often matches product_qty. |
| price_tax | DOUBLE PRECISION | true | Tax amount | Calculated tax. |
| product_packaging_qty | DOUBLE PRECISION | true | Packaging quantity | Multiplier for packaging. |
| orderpoint_id | INTEGER | true | Reordering rule ID | Link to replenishment logic. |
| location_final_id | INTEGER | true | Destination location ID | Inventory warehouse location. |
| group_id | INTEGER | true | Procurement group ID | Links to stock moves. |
| product_description_variants | VARCHAR | true | Product variant details | Textual variant info. |
| propagate_cancel | BOOLEAN | true | Propagate cancel flag | Whether to cancel downstream moves. |
| sale_order_id | INTEGER | true | Linked sale order ID | For dropshipping or back-to-back. |
| sale_line_id | INTEGER | true | Linked sale order line ID | For dropshipping or back-to-back. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `order_id` → `purchase_order.id` (Required link to parent order)
    - `product_id` → `product_product.id` (Links to the item being purchased)
    - `partner_id` → `res_partner.id` (Links to the vendor)
- **Natural keys (inferred):**
    - None. Odoo relies on the surrogate `id` for uniqueness within the database.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` fields are stored in UTC.
- **Soft Deletes:** This table does not typically implement soft deletes; records are usually hard-deleted or marked as `state = 'cancel'`.
- **Precision:** `NUMERIC` fields are used for financial accuracy; ensure downstream systems maintain the same scale/precision to avoid rounding errors.
- **Analytic Distribution:** The `analytic_distribution` column is a `JSONB` field; queries requiring specific cost center data will need to use PostgreSQL JSON operators (e.g., `->>`).
- **Calculated Fields:** Several fields (e.g., `price_subtotal`, `qty_to_invoice`) are often computed by the Odoo ORM; verify if these are populated in the staging layer or if they require recalculation.