# stock_move

## Source system
This table originates from Odoo ERP, indicated by the characteristic naming conventions such as `picking_id`, `product_uom`, `procure_method`, and the presence of `create_uid`/`write_uid` audit columns. The schema reflects a standard Odoo inventory management module.

## Functional process 
This table supports the Inventory and Warehouse management process, specifically tracking the movement of stock between locations. It records the lifecycle of stock transfers, including receipts, internal transfers, and customer deliveries, while linking to production orders (`production_id`), sales orders (`sale_line_id`), and purchase orders (`purchase_line_id`).

## Description
One row in this table represents a single stock movement event, defining the transfer of a specific quantity of a product from a source location to a destination location. It serves as a raw landed copy of the Odoo `stock.move` model, capturing the state, quantity, and timing of inventory changes at the grain of an individual move line.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Sorting priority | Used for UI ordering. |
| company_id | INTEGER | false | Company identifier | Links to the multi-company entity. |
| product_id | INTEGER | false | Product identifier | Reference to the product master. |
| product_uom | INTEGER | false | Unit of measure ID | Defines the unit for the quantity. |
| location_id | INTEGER | false | Source location ID | Where the stock is coming from. |
| location_dest_id | INTEGER | false | Destination location ID | Where the stock is going. |
| location_final_id | INTEGER | true | Final destination ID | Used for complex routing. |
| partner_id | INTEGER | true | Partner identifier | Customer or vendor associated with the move. |
| picking_id | INTEGER | true | Picking identifier | Links to the parent picking document. |
| scrap_id | INTEGER | true | Scrap identifier | Links to a scrap record if applicable. |
| group_id | INTEGER | true | Procurement group ID | Groups moves for replenishment. |
| rule_id | INTEGER | true | Procurement rule ID | The rule that triggered this move. |
| picking_type_id | INTEGER | true | Picking type ID | Defines the operation type (e.g., Receipt, Delivery). |
| origin_returned_move_id | INTEGER | true | Original move ID | Links to the move being returned. |
| restrict_partner_id | INTEGER | true | Restricted partner ID | Limits stock to a specific partner. |
| warehouse_id | INTEGER | true | Warehouse identifier | The warehouse owning this move. |
| package_level_id | INTEGER | true | Package level ID | Links to the container/package. |
| next_serial_count | INTEGER | true | Serial count | Used for serial number tracking. |
| orderpoint_id | INTEGER | true | Reordering rule ID | Links to the automated replenishment rule. |
| product_packaging_id | INTEGER | true | Packaging ID | The type of packaging used. |
| create_uid | INTEGER | true | Creator user ID | Audit: user who created the record. |
| write_uid | INTEGER | true | Modifier user ID | Audit: user who last updated the record. |
| name | VARCHAR | false | Move description | Human-readable description of the move. |
| priority | VARCHAR | true | Priority level | e.g., '0' (normal), '1' (urgent). |
| state | VARCHAR | true | Move status | e.g., 'draft', 'confirmed', 'assigned', 'done'. |
| origin | VARCHAR | true | Source document | Reference string (e.g., SO123). |
| procure_method | VARCHAR | false | Procurement method | 'make_to_stock' or 'make_to_order'. |
| reference | VARCHAR | true | Internal reference | Unique identifier for the move. |
| next_serial | VARCHAR | true | Next serial number | Serial number to be assigned. |
| reservation_date | DATE | true | Reservation date | Date when stock was reserved. |
| description_picking | TEXT | true | Picking description | Detailed notes for the warehouse team. |
| product_qty | NUMERIC | true | Product quantity | Quantity in base units. |
| product_uom_qty | NUMERIC | false | Initial demand | The quantity requested. |
| quantity | NUMERIC | true | Done quantity | The actual quantity moved. |
| picked | BOOLEAN | true | Picked status | Whether the item has been picked. |
| scrapped | BOOLEAN | true | Scrapped flag | True if the item was scrapped. |
| propagate_cancel | BOOLEAN | true | Propagate cancel | Whether to cancel linked moves. |
| is_inventory | BOOLEAN | true | Inventory move | True if this is an inventory adjustment. |
| additional | BOOLEAN | true | Additional move | True if added manually to a picking. |
| date | TIMESTAMP | false | Scheduled date | Expected date of the move. |
| date_deadline | TIMESTAMP | true | Deadline date | The latest date for the move. |
| delay_alert_date | TIMESTAMP | true | Delay alert date | Date when a delay alert was triggered. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time. |
| write_date | TIMESTAMP | true | Modification timestamp | Record update time. |
| price_unit | DOUBLE PRECISION | true | Unit price | Cost or value per unit. |
| is_done | BOOLEAN | true | Done status | Indicates if the move is completed. |
| unit_factor | DOUBLE PRECISION | true | Unit factor | Conversion factor for units. |
| manual_consumption | BOOLEAN | true | Manual consumption | Flag for manual material consumption. |
| created_production_id | INTEGER | true | Created production ID | Links to production created by this move. |
| production_id | INTEGER | true | Production ID | Links to the production order. |
| raw_material_production_id | INTEGER | true | Raw material prod ID | Links to the raw material consumption. |
| unbuild_id | INTEGER | true | Unbuild ID | Links to an unbuild order. |
| consume_unbuild_id | INTEGER | true | Consume unbuild ID | Links to unbuild consumption. |
| operation_id | INTEGER | true | Operation ID | Links to a manufacturing operation. |
| workorder_id | INTEGER | true | Workorder ID | Links to a manufacturing workorder. |
| bom_line_id | INTEGER | true | BOM line ID | Links to the Bill of Materials line. |
| byproduct_id | INTEGER | true | Byproduct ID | Links to a manufacturing byproduct. |
| order_finished_lot_id | INTEGER | true | Finished lot ID | Links to the produced lot. |
| cost_share | NUMERIC | true | Cost share | Allocation of cost for byproducts. |
| to_refund | BOOLEAN | true | Refund flag | Indicates if the move is for a refund. |
| purchase_line_id | INTEGER | true | Purchase line ID | Links to the purchase order line. |
| sale_line_id | INTEGER | true | Sale line ID | Links to the sales order line. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Guess: Standard Odoo product link)
    - `picking_id` → `stock_picking.id` (Guess: Links to the parent picking document)
    - `location_id` → `stock_location.id` (Guess: Links to the source warehouse location)
    - `sale_line_id` → `sale_order_line.id` (Guess: Links to the originating sales order line)
- **Natural keys (inferred):** 
    - `reference` (The business-level identifier for the move)

## Caveats for downstream consumers

- **Timestamps:** All timestamps (`date`, `create_date`, etc.) are stored in UTC as per Odoo standard behavior.
- **Soft Deletes:** Odoo typically uses hard deletes for records; however, the `state` column should be used to filter for active or completed moves (e.g., `state = 'done'`).
- **Quantity:** Use `quantity` for the actual moved amount and `product_uom_qty` for the planned amount.
- **Sensitive Data:** No direct PII is present, though `partner_id` links to customer/vendor names in other tables.