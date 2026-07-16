# stock_scrap

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `product_uom_id`, `picking_id`, `create_uid`, `write_uid`) and the presence of specific manufacturing-related columns like `bom_id` and `workorder_id` are characteristic of the Odoo Inventory and Manufacturing modules.

## Functional process 
This table supports the inventory management and quality control process, specifically the "Scrap" workflow. It tracks items removed from inventory due to damage, obsolescence, or manufacturing defects, linking these events to specific locations, production orders, and bills of materials.

## Description
One row represents a single scrap event where a specific quantity of a product is removed from inventory. This is a raw landed copy of the Odoo `stock.scrap` model, capturing the state of the scrap request, the source and destination locations, and the associated production context.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | false | Company identifier | Links to the multi-company structure. |
| product_id | INTEGER | false | Product identifier | The item being scrapped. |
| product_uom_id | INTEGER | false | Unit of measure identifier | The unit in which the quantity is measured. |
| lot_id | INTEGER | true | Lot/Serial number identifier | Specific batch or serial number scrapped. |
| package_id | INTEGER | true | Package identifier | The physical container the product was in. |
| owner_id | INTEGER | true | Owner identifier | Used if the stock is owned by a third party. |
| picking_id | INTEGER | true | Picking identifier | Link to the original stock move/picking. |
| location_id | INTEGER | false | Source location identifier | Where the product was taken from. |
| scrap_location_id | INTEGER | false | Scrap location identifier | Where the product was moved to. |
| create_uid | INTEGER | true | Creator user identifier | User who initiated the scrap. |
| write_uid | INTEGER | true | Last updater user identifier | User who last modified the record. |
| name | VARCHAR | false | Scrap reference number | Human-readable document number (e.g., SCR/0001). |
| origin | VARCHAR | true | Source document | Reference to the document that triggered the scrap. |
| state | VARCHAR | true | Status | Current lifecycle state of the scrap record. |
| scrap_qty | NUMERIC | false | Quantity scrapped | The amount of product removed. |
| should_replenish | BOOLEAN | true | Replenishment flag | Indicates if the system should trigger a reorder. |
| date_done | TIMESTAMP | true | Completion timestamp | When the scrap was finalized. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time. |
| write_date | TIMESTAMP | true | Last update timestamp | Record modification time. |
| production_id | INTEGER | true | Manufacturing order identifier | Link to the production order if scrapped during manufacturing. |
| workorder_id | INTEGER | true | Work order identifier | Link to the specific work order. |
| bom_id | INTEGER | true | Bill of Materials identifier | Link to the BoM associated with the scrap. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `product_id` → `product_product.id` (Standard Odoo product link)
    - `location_id` → `stock_location.id` (Standard Odoo location link)
    - `production_id` → `mrp_production.id` (Standard Odoo manufacturing link)
- **Natural keys (inferred):** `name` (The document reference number is typically unique within the Odoo instance).

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, as is standard for Odoo PostgreSQL databases.
- **Soft Deletes:** Odoo typically does not use soft deletes; records are usually hard-deleted or remain in the table indefinitely.
- **Precision:** `scrap_qty` is `NUMERIC` to support fractional quantities; ensure downstream systems handle decimal precision accordingly.
- **PII:** No direct PII is present, though `create_uid` and `write_uid` link to user tables which may contain sensitive employee information.