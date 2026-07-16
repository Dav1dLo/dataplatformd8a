# mrp_unbuild

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`mrp_unbuild`, `product_uom_id`, `mo_id`) and the standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the Manufacturing (MRP) process, specifically the "unbuild" operation where a finished product is disassembled back into its component parts. It tracks the reversal of production orders, allowing inventory to be returned to stock from finished goods.

## Description
One row in this table represents a single unbuild order, documenting the disassembly of a specific quantity of a product. It serves as a raw landed copy of the unbuild records from the Odoo manufacturing module, capturing the state of the disassembly process and the associated inventory locations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mrp_unbuild_id_seq`. |
| product_id | INTEGER | false | Foreign key to product | References the product being unbuilt. |
| company_id | INTEGER | false | Foreign key to company | Multi-company context identifier. |
| product_uom_id | INTEGER | false | Foreign key to unit of measure | The unit of measure for the unbuilt quantity. |
| bom_id | INTEGER | true | Foreign key to Bill of Materials | The BOM used to define the disassembly structure. |
| mo_id | INTEGER | true | Foreign key to Manufacturing Order | The original production order being reversed. |
| lot_id | INTEGER | true | Foreign key to lot/serial number | The specific lot/serial being disassembled. |
| location_id | INTEGER | false | Foreign key to source location | The location where the finished product is taken from. |
| location_dest_id | INTEGER | false | Foreign key to destination location | The location where components are returned. |
| create_uid | INTEGER | true | Creator user ID | User who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | User who last updated the record. |
| name | VARCHAR | true | Unbuild order reference | Human-readable document number (e.g., "UB/0001"). |
| state | VARCHAR | true | Lifecycle status | Current status of the unbuild (e.g., 'draft', 'done'). |
| product_qty | NUMERIC | false | Quantity unbuilt | The amount of product disassembled. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC timestamp of last update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Standard Odoo product reference)
    - `company_id` → `res_company.id` (Standard Odoo company reference)
    - `product_uom_id` → `uom_uom.id` (Standard Odoo unit of measure reference)
    - `bom_id` → `mrp_bom.id` (References the Bill of Materials)
    - `mo_id` → `mrp_production.id` (References the Manufacturing Order)
    - `lot_id` → `stock_production_lot.id` (References the specific lot/serial)
    - `location_id` / `location_dest_id` → `stock_location.id` (References inventory locations)
- **Natural keys (inferred):** `name` (The document reference number is typically unique within an Odoo instance).

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be mapped to a user dimension table to avoid exposing internal system IDs.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** Odoo typically does not use soft deletes; records are usually permanent unless explicitly removed by the application logic.
- **Precision:** `product_qty` is `NUMERIC` without defined scale/precision in the metadata; check source DDL for exact decimal constraints to avoid rounding errors in downstream aggregations.