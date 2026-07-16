# stock_quant

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions (`stock_quant`, `create_uid`, `write_uid`, `in_date`) and the use of PostgreSQL sequence-based primary keys typical of the Odoo framework.

## Functional process 
This table supports the inventory management and warehouse operations process. It tracks the current stock levels (quantities) of products across various locations, accounting for reservations, lot tracking, and inventory adjustments.

## Description
One row in this table represents a specific quantity of a product held in a particular location, potentially associated with a specific lot, package, or owner. It serves as a raw landed copy of the Odoo `stock.quant` model, providing the current state of inventory levels within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| product_id | INTEGER | false | Foreign key to product | Links to the product definition. |
| company_id | INTEGER | true | Foreign key to company | Multi-company context. |
| location_id | INTEGER | false | Foreign key to location | The physical or virtual warehouse location. |
| storage_category_id | INTEGER | true | Foreign key to storage category | Categorization of the storage space. |
| lot_id | INTEGER | true | Foreign key to lot/serial number | Tracks specific batches or serials. |
| package_id | INTEGER | true | Foreign key to package | Identifies the container/pallet. |
| owner_id | INTEGER | true | Foreign key to owner | Used for consignment stock. |
| user_id | INTEGER | true | Foreign key to user | Responsible user for this quant. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| inventory_date | DATE | true | Last inventory count date | Date of the last physical count. |
| quantity | NUMERIC | true | On-hand quantity | Current available stock. |
| reserved_quantity | NUMERIC | false | Reserved quantity | Stock allocated to pending orders. |
| inventory_quantity | NUMERIC | true | Inventory count quantity | Value recorded during physical count. |
| inventory_diff_quantity | NUMERIC | true | Inventory difference | Variance between system and physical. |
| inventory_quantity_set | BOOLEAN | true | Inventory set flag | Indicates if inventory was manually set. |
| in_date | TIMESTAMP | false | Arrival timestamp | Date/time the stock entered the location. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time. |
| write_date | TIMESTAMP | true | Last update timestamp | Record modification time. |
| accounting_date | DATE | true | Accounting date | Date for financial valuation. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Standard Odoo product link)
    - `location_id` → `stock_location.id` (Standard Odoo location link)
    - `lot_id` → `stock_lot.id` (Standard Odoo lot link)
    - `package_id` → `stock_quant_package.id` (Standard Odoo package link)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for unique identification of quant records.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with Odoo's internal storage.
- **Precision:** `NUMERIC` types do not have defined scale/precision in the metadata; assume standard Odoo inventory precision (usually 2 or 3 decimal places).
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically updated or removed by the application logic.
- **Sensitivity:** Contains no direct PII, but reflects operational inventory levels which may be commercially sensitive.