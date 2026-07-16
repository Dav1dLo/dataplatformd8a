# report_pos_order

## Source system
This table originates from an Odoo ERP system, specifically the Point of Sale (POS) module. The naming convention (e.g., `pos_categ_id`, `product_tmpl_id`, `journal_id`) and the structure of the reporting fields are characteristic of Odoo's internal reporting models used for sales analytics.

## Functional process 
This table supports the sales reporting and analytics pipeline for retail operations. It aggregates transactional data from the Point of Sale, allowing for the calculation of sales performance, product category trends, and margin analysis across different sessions, employees, and payment methods.

## Description
One row in this table represents a single line item or an aggregated summary record within a Point of Sale order. It serves as a staging entity, providing a denormalized view of POS transactions to facilitate downstream reporting on revenue, discounts, and product performance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Internal identifier for the report record. |
| nbr_lines | INTEGER | true | Number of lines | Count of order lines associated with this record. |
| date | TIMESTAMP | true | Transaction timestamp | Date and time of the POS order. |
| price_subtotal_excl | NUMERIC | true | Subtotal excluding tax | Revenue amount before tax application. |
| product_qty | NUMERIC | true | Quantity | Number of units sold. |
| price_sub_total | NUMERIC | true | Subtotal | Revenue amount including tax. |
| price_total | NUMERIC | true | Total price | Final transaction amount. |
| total_discount | NUMERIC | true | Total discount | Monetary value of discounts applied. |
| average_price | NUMERIC | true | Average unit price | Calculated average price per unit. |
| delay_validation | INTEGER | true | Validation delay | Time elapsed between order creation and validation. |
| order_id | INTEGER | true | Order reference | Foreign key to the parent POS order. |
| partner_id | INTEGER | true | Customer reference | Foreign key to the customer/partner. |
| state | VARCHAR | true | Order status | Current lifecycle state of the order (e.g., 'paid', 'done'). |
| user_id | INTEGER | true | User reference | Foreign key to the system user who processed the order. |
| company_id | INTEGER | true | Company reference | Foreign key to the organizational entity. |
| journal_id | INTEGER | true | Journal reference | Foreign key to the accounting journal. |
| product_id | INTEGER | true | Product reference | Foreign key to the specific product variant. |
| product_categ_id | INTEGER | true | Product category | Foreign key to the product category. |
| product_tmpl_id | INTEGER | true | Product template | Foreign key to the base product template. |
| config_id | INTEGER | true | POS config reference | Foreign key to the POS configuration settings. |
| pricelist_id | INTEGER | true | Pricelist reference | Foreign key to the applied pricelist. |
| session_id | INTEGER | true | Session reference | Foreign key to the POS session. |
| invoiced | BOOLEAN | true | Invoiced status | Flag indicating if the order has been invoiced. |
| margin | NUMERIC | true | Margin | Calculated profit margin for the transaction. |
| payment_method_id | INTEGER | true | Payment method | Foreign key to the payment method used. |
| pos_categ_id | INTEGER | true | POS category | Foreign key to the POS-specific product category. |
| employee_id | INTEGER | true | Employee reference | Foreign key to the employee who handled the sale. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `order_id` → `pos_order.id` (Likely links to the main POS order header)
    - `product_id` → `product_product.id` (Links to the specific product sold)
    - `partner_id` → `res_partner.id` (Links to the customer record)
    - `session_id` → `pos_session.id` (Links to the specific POS session)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `partner_id` which may link to PII in the `res_partner` table.
- **Timestamps:** Assumed to be in UTC; verify against Odoo system configuration.
- **Data Integrity:** The `id` column is nullable, which is unusual for a primary key; verify if this table contains aggregated rows where `id` might be null.
- **Soft Deletes:** This table appears to be a reporting view or materialized staging table; it is unclear if it tracks deleted records or only active transactions.