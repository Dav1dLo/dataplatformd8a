# mrp_production

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention (`mrp_production`, `bom_id`, `product_uom_id`) and the specific sequence-based primary key pattern are characteristic of Odoo's PostgreSQL schema.

## Functional process 
This table supports the manufacturing execution process, tracking the lifecycle of production orders from planning through completion. It manages the conversion of raw materials into finished goods, linking production requirements to Bills of Materials (BOMs), inventory locations, and procurement groups.

## Description
One row represents a single manufacturing order (MO) within the production pipeline. It captures the production schedule, quantities, status, and the specific product being manufactured. This table serves as the raw staging entity for all manufacturing activity, providing the base data for production reporting and inventory consumption analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| backorder_sequence | INTEGER | true | Sequence number for backorders | Used when a production order is split. |
| product_id | INTEGER | false | Product identifier | Foreign key to product master. |
| product_uom_id | INTEGER | false | Unit of measure identifier | Defines the unit for the production quantity. |
| lot_producing_id | INTEGER | true | Lot/Serial number identifier | The specific lot being produced. |
| picking_type_id | INTEGER | false | Picking type identifier | Defines the warehouse operation type. |
| location_src_id | INTEGER | false | Source location identifier | Where raw materials are consumed from. |
| location_dest_id | INTEGER | false | Destination location identifier | Where finished goods are moved to. |
| location_final_id | INTEGER | true | Final destination location | Optional override for final storage. |
| bom_id | INTEGER | true | Bill of Materials identifier | The recipe used for production. |
| user_id | INTEGER | true | Responsible user identifier | The person managing this order. |
| company_id | INTEGER | false | Company identifier | Multi-company context. |
| procurement_group_id | INTEGER | true | Procurement group identifier | Links to supply chain replenishment. |
| orderpoint_id | INTEGER | true | Reordering rule identifier | Links to automated replenishment. |
| production_location_id | INTEGER | true | Production location identifier | The internal work center location. |
| create_uid | INTEGER | true | Creator user identifier | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user identifier | Audit trail for record updates. |
| name | VARCHAR | true | Production order reference | Human-readable document number (e.g., MO/0001). |
| priority | VARCHAR | true | Priority level | Usually '0' (normal) or '1' (urgent). |
| origin | VARCHAR | true | Source document reference | Links to sales orders or other triggers. |
| state | VARCHAR | true | Order status | e.g., 'draft', 'confirmed', 'progress', 'done'. |
| reservation_state | VARCHAR | true | Material availability status | e.g., 'confirmed', 'waiting', 'assigned'. |
| product_description_variants | VARCHAR | true | Product variant description | Custom text for specific variants. |
| consumption | VARCHAR | false | Consumption policy | Defines how raw materials are consumed. |
| product_qty | NUMERIC | false | Planned quantity | The target production volume. |
| qty_producing | NUMERIC | true | Actual quantity produced | The amount currently processed. |
| propagate_cancel | BOOLEAN | true | Cancel propagation flag | Whether to cancel downstream moves. |
| is_locked | BOOLEAN | true | Lock status | Prevents editing if true. |
| is_planned | BOOLEAN | true | Planning status | Indicates if the order is scheduled. |
| allow_workorder_dependencies | BOOLEAN | true | Dependency flag | Enables work order sequencing. |
| is_outdated_bom | BOOLEAN | true | BOM version flag | Indicates if the BOM has changed. |
| date_deadline | TIMESTAMP | true | Deadline date | The target completion date. |
| date_start | TIMESTAMP | false | Scheduled start date | The planned start of production. |
| date_finished | TIMESTAMP | true | Actual finish date | The timestamp when production ended. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp. |
| product_uom_qty | DOUBLE PRECISION | true | Total quantity in UOM | Often redundant with product_qty. |
| extra_cost | DOUBLE PRECISION | true | Additional production costs | Monetary value. |
| project_id | INTEGER | true | Project identifier | Links to project management module. |
| sale_line_id | INTEGER | true | Sales order line identifier | Links to the specific sales order item. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Likely target for product master data)
    - `bom_id` → `mrp_bom.id` (Links to the Bill of Materials definition)
    - `company_id` → `res_company.id` (Standard Odoo multi-company link)
- **Natural keys (inferred):** 
    - `name` (The production order reference number is typically unique within the system)

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but `user_id` and `create_uid` link to internal employee records.
- **Timestamps:** All timestamps (`date_start`, `create_date`, etc.) are stored in UTC.
- **Soft Deletes:** Odoo typically does not use soft deletes; records are usually hard-deleted unless an `active` column exists (not present here).
- **Precision:** `product_qty` and `qty_producing` are `NUMERIC`; ensure downstream systems handle decimal precision correctly to avoid rounding errors in inventory valuation.
- **State Logic:** The `state` column is the primary filter for active vs. historical production; queries should typically filter for `state = 'done'` for completed production analysis.