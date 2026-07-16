# vendor_delay_report

## Source system
The table likely originates from an ERP system such as Odoo or a similar modular business management suite. The naming convention (e.g., `partner_id`, `purchase_line_id`, `product_id`) and the focus on vendor performance metrics are characteristic of procurement and supply chain modules within integrated ERP environments.

## Functional process 
This table supports the vendor performance and supply chain reliability monitoring process. It tracks procurement fulfillment by comparing total quantities ordered against quantities delivered on time, allowing for the calculation of vendor lead-time adherence and service level agreement (SLA) compliance.

## Description
One row in this table represents a daily summary of procurement fulfillment performance for a specific product category and vendor. It serves as a staging-layer entity, providing a granular view of delivery delays aggregated by purchase line and partner.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely an auto-incrementing identifier from the source. |
| date | TIMESTAMP | true | Transaction or reporting date | Represents the timestamp of the performance record. |
| purchase_line_id | INTEGER | true | Foreign key to purchase order line | Links to the specific procurement line item. |
| product_id | INTEGER | true | Foreign key to product catalog | Identifies the item being procured. |
| category_id | INTEGER | true | Foreign key to product category | Used for grouping performance metrics. |
| partner_id | INTEGER | true | Foreign key to vendor/partner | Identifies the supplier associated with the delivery. |
| qty_total | DOUBLE PRECISION | true | Total quantity ordered | The aggregate volume expected for the period. |
| qty_on_time | NUMERIC | true | Quantity delivered on time | The portion of `qty_total` that met the delivery deadline. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `purchase_line_id` → `purchase_order_lines.id` (Inferred from naming convention).
    - `product_id` → `products.id` (Inferred from naming convention).
    - `category_id` → `product_categories.id` (Inferred from naming convention).
    - `partner_id` → `res_partner.id` (Inferred from common ERP naming patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps are assumed to be in UTC; verify against source system configuration if time-zone precision is critical.
- The table contains no explicit soft-delete flags; assume rows represent the current state of the staging extract.
- `qty_on_time` is defined as `NUMERIC` while `qty_total` is `DOUBLE PRECISION`; be mindful of potential floating-point precision issues when performing division or comparisons between these two columns.
- Null values are present across all columns; ensure appropriate handling (e.g., `COALESCE`) when calculating performance ratios.