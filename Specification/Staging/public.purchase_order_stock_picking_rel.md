# purchase_order_stock_picking_rel

## Source system
This table likely originates from an ERP system such as Odoo, given the naming convention `_rel` (common for many-to-many join tables) and the specific pairing of `purchase_order` and `stock_picking` entities.

## Functional process 
This table supports the procurement and logistics process by mapping purchase orders to their corresponding stock picking (inbound delivery) records. It facilitates the tracking of which goods receipts are associated with which procurement requests.

## Description
One row in this table represents a single association between a purchase order and a stock picking event. It serves as a raw landing junction table to resolve the many-to-many relationship between procurement documents and warehouse inventory movements.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| purchase_order_id | INTEGER | false | Foreign key to the purchase order | Links to the primary key of the purchase order table. |
| stock_picking_id | INTEGER | false | Foreign key to the stock picking record | Links to the primary key of the stock picking table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`purchase_order_id`, `stock_picking_id`).
- **Foreign keys (inferred):** 
    - `purchase_order_id` → `purchase_order.id` (Inferred from naming convention).
    - `stock_picking_id` → `stock_picking.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; expect multiple rows per `purchase_order_id` if an order is fulfilled via multiple shipments.
- No audit timestamps (e.g., `created_at`) are present; rely on the source system's master tables for temporal lineage.
- Ensure joins are handled carefully to avoid fan-outs if joining to other tables without filtering by the specific picking ID.