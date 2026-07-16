# sale_order_line

## Source system
This table originates from Odoo ERP, evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `display_type`, and the use of `analytic_distribution` (JSONB) and `product_uom`. The schema and column patterns are standard for Odoo's sales management module.

## Functional process 
This table supports the "Order-to-Cash" business process, specifically managing the line-item details of sales orders. It tracks product quantities, pricing, invoicing status, and delivery progress for individual items within a customer order, facilitating downstream revenue recognition and inventory fulfillment tracking.

## Description
One row represents a single line item within a sales order, detailing the product, quantity, pricing, and current fulfillment or invoicing status. This table serves as a raw landed copy of the Odoo `sale.order.line` model, capturing the granular state of order components at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| order_id | INTEGER | false | Foreign key to parent order | Links to `sale_order`. |
| sequence | INTEGER | true | Display order index | Used for UI ordering. |
| company_id | INTEGER | true | Company identifier | Multi-company support. |
| currency_id | INTEGER | true | Currency identifier | Currency of the line item. |
| order_partner_id | INTEGER | true | Customer/Partner ID | The specific customer for this line. |
| salesman_id | INTEGER | true | Salesperson ID | Owner of the sale. |
| product_id | INTEGER | true | Product identifier | Links to `product_product`. |
| product_uom | INTEGER | true | Unit of Measure ID | e.g., units, kg, hours. |
| linked_line_id | INTEGER | true | Parent line reference | Used for BOM or kit structures. |
| combo_item_id | INTEGER | true | Combo item identifier | Used for product bundles. |
| product_packaging_id | INTEGER | true | Packaging identifier | Packaging type used. |
| create_uid | INTEGER | true | Creator user ID | Audit trail. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail. |
| state | VARCHAR | true | Line status | e.g., 'draft', 'sale', 'cancel'. |
| display_type | VARCHAR | true | Line type | e.g., 'line_section', 'line_note'. |
| virtual_id | VARCHAR | true | Virtual identifier | Used for temporary UI state. |
| linked_virtual_id | VARCHAR | true | Linked virtual identifier | Used for temporary UI state. |
| qty_delivered_method | VARCHAR | true | Delivery calculation method | e.g., 'manual', 'timesheet'. |
| invoice_status | VARCHAR | true | Invoicing status | e.g., 'to invoice', 'invoiced'. |
| analytic_distribution | JSONB | true | Analytic account mapping | JSON blob for cost center allocation. |
| name | TEXT | false | Line description | Product name or custom text. |
| product_uom_qty | NUMERIC | false | Ordered quantity | Base quantity. |
| price_unit | NUMERIC | false | Unit price | Price per unit. |
| discount | NUMERIC | true | Discount percentage | 0-100 range. |
| price_subtotal | NUMERIC | true | Subtotal (excl. tax) | Calculated amount. |
| price_total | NUMERIC | true | Total amount (incl. tax) | Calculated amount. |
| price_reduce_taxexcl | NUMERIC | true | Reduced price (excl. tax) | Post-discount price. |
| price_reduce_taxinc | NUMERIC | true | Reduced price (incl. tax) | Post-discount price. |
| qty_delivered | NUMERIC | true | Delivered quantity | Quantity fulfilled. |
| qty_invoiced | NUMERIC | true | Invoiced quantity | Quantity billed. |
| qty_to_invoice | NUMERIC | true | Remaining quantity to invoice | Calculated field. |
| untaxed_amount_invoiced | NUMERIC | true | Invoiced amount (excl. tax) | Financial tracking. |
| untaxed_amount_to_invoice | NUMERIC | true | Remaining amount to invoice | Financial tracking. |
| is_downpayment | BOOLEAN | true | Downpayment flag | Indicates if line is a deposit. |
| is_expense | BOOLEAN | true | Expense flag | Indicates if line is an expense. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| technical_price_unit | DOUBLE PRECISION | true | Technical unit price | Internal precision field. |
| price_tax | DOUBLE PRECISION | true | Tax amount | Calculated tax value. |
| product_packaging_qty | DOUBLE PRECISION | true | Packaging quantity | Quantity per package. |
| customer_lead | DOUBLE PRECISION | false | Lead time (days) | Expected delivery delay. |
| route_id | INTEGER | true | Logistics route ID | Inventory routing. |
| warehouse_id | INTEGER | true | Warehouse ID | Fulfillment location. |
| is_service | BOOLEAN | true | Service flag | True if product is a service. |
| project_id | INTEGER | true | Project ID | Links to project management. |
| task_id | INTEGER | true | Task ID | Links to specific task. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `order_id` → `sale_order.id` (Standard Odoo parent-child relationship).
    - `product_id` → `product_product.id` (Standard Odoo product reference).
    - `warehouse_id` → `stock_warehouse.id` (Standard Odoo inventory reference).
- **Natural keys (inferred):** None. Odoo relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but `analytic_distribution` may contain sensitive internal cost center data.
- **Timestamps:** Assumed to be in UTC as per standard Odoo database configurations.
- **Soft Deletes:** Odoo typically performs hard deletes on line items; however, verify if the source system uses a custom `active` flag if rows disappear unexpectedly.
- **Precision:** `NUMERIC` types are used for financial accuracy; ensure downstream systems maintain this precision to avoid rounding errors.
- **Calculated Fields:** Many fields (e.g., `price_subtotal`, `qty_to_invoice`) are calculated by the Odoo application layer; ensure these match your business logic if re-calculating.