# stock_picking_type

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (`stock_picking_type`, `warehouse_id`, `create_uid`, `write_date`) and the presence of `JSONB` fields for multi-language labels are characteristic of the Odoo ORM layer.

## Functional process 
This table supports the Inventory and Warehouse management process, specifically defining the operational workflows for stock movements (e.g., Receipts, Internal Transfers, Deliveries). It dictates how picking operations are handled, including automation rules for printing labels, reservation strategies for stock, and default source/destination locations for specific movement types.

## Description
One row in this table represents a specific configuration or "type" of stock picking operation within the warehouse management system. It acts as a template that governs the behavior of stock moves, such as whether to automatically create backorders, how to handle lot tracking, and which documents to print upon completion. This is a raw landed staging table reflecting the configuration state of the Odoo inventory module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| color | INTEGER | true | UI color index | Used for dashboard/calendar visualization. |
| sequence | INTEGER | true | Display order | Controls the sort order in the UI. |
| sequence_id | INTEGER | true | Sequence reference | Link to the sequence generator for picking names. |
| default_location_src_id | INTEGER | false | Default source location | Foreign key to stock.location. |
| default_location_dest_id | INTEGER | false | Default destination location | Foreign key to stock.location. |
| return_picking_type_id | INTEGER | true | Return picking type | Link to the picking type used for returns. |
| warehouse_id | INTEGER | true | Warehouse association | Foreign key to stock.warehouse. |
| reservation_days_before | INTEGER | true | Reservation lead time | Days before scheduled date to reserve stock. |
| reservation_days_before_priority | INTEGER | true | Priority reservation lead time | Days before for high-priority items. |
| company_id | INTEGER | false | Company ID | Multi-company isolation key. |
| create_uid | INTEGER | true | Creator user ID | Reference to res.users. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to res.users. |
| sequence_code | VARCHAR | false | Sequence prefix | Code used for document numbering. |
| code | VARCHAR | false | Operation type code | e.g., 'incoming', 'outgoing', 'internal'. |
| reservation_method | VARCHAR | false | Reservation strategy | e.g., 'at_confirm', 'manual', 'by_date'. |
| product_label_format | VARCHAR | true | Product label template | Format identifier for printing. |
| lot_label_format | VARCHAR | true | Lot label template | Format identifier for printing. |
| package_label_to_print | VARCHAR | true | Package label template | Format identifier for printing. |
| barcode | VARCHAR | true | Barcode identifier | Used for scanning operations. |
| create_backorder | VARCHAR | false | Backorder policy | e.g., 'ask', 'always', 'never'. |
| move_type | VARCHAR | false | Move grouping policy | e.g., 'direct', 'one'. |
| name | JSONB | false | Operation type name | Multi-language label. |
| picking_properties_definition | JSONB | true | Custom properties schema | JSON definition for dynamic fields. |
| show_entire_packs | BOOLEAN | true | Display pack details | Toggle for UI visibility. |
| active | BOOLEAN | true | Soft-delete flag | False indicates the type is archived. |
| use_create_lots | BOOLEAN | true | Allow lot creation | Permission to create new lots on the fly. |
| use_existing_lots | BOOLEAN | true | Allow existing lots | Permission to select existing lots. |
| print_label | BOOLEAN | true | Print label toggle | Global print flag. |
| show_operations | BOOLEAN | true | Show detailed operations | UI toggle. |
| auto_show_reception_report | BOOLEAN | true | Auto-show report | UI automation. |
| auto_print_delivery_slip | BOOLEAN | true | Auto-print delivery slip | Automation flag. |
| auto_print_return_slip | BOOLEAN | true | Auto-print return slip | Automation flag. |
| auto_print_product_labels | BOOLEAN | true | Auto-print product labels | Automation flag. |
| auto_print_lot_labels | BOOLEAN | true | Auto-print lot labels | Automation flag. |
| auto_print_reception_report | BOOLEAN | true | Auto-print reception report | Automation flag. |
| auto_print_reception_report_labels | BOOLEAN | true | Auto-print reception labels | Automation flag. |
| auto_print_packages | BOOLEAN | true | Auto-print packages | Automation flag. |
| auto_print_package_label | BOOLEAN | true | Auto-print package label | Automation flag. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| mrp_product_label_to_print | VARCHAR | true | MRP product label template | Manufacturing specific. |
| done_mrp_lot_label_to_print | VARCHAR | true | MRP lot label template | Manufacturing specific. |
| generated_mrp_lot_label_to_print | VARCHAR | true | Generated MRP lot template | Manufacturing specific. |
| use_create_components_lots | BOOLEAN | true | Allow component lot creation | Manufacturing specific. |
| auto_print_done_production_order | BOOLEAN | true | Auto-print production order | Manufacturing specific. |
| auto_print_done_mrp_product_labels | BOOLEAN | true | Auto-print MRP product labels | Manufacturing specific. |
| auto_print_done_mrp_lot | BOOLEAN | true | Auto-print MRP lot | Manufacturing specific. |
| auto_print_mrp_reception_report | BOOLEAN | true | Auto-print MRP report | Manufacturing specific. |
| auto_print_mrp_reception_report_labels | BOOLEAN | true | Auto-print MRP report labels | Manufacturing specific. |
| auto_print_generated_mrp_lot | BOOLEAN | true | Auto-print generated MRP lot | Manufacturing specific. |
| analytic_costs | BOOLEAN | true | Enable analytic accounting | Cost tracking toggle. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `warehouse_id` → `stock_warehouse.id` (Guess: links to the warehouse definition).
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo audit trail).
- **Natural keys (inferred):**
    - `code` (In Odoo, the `code` field is typically unique per warehouse/company context for system operations).

## Caveats for downstream consumers

- **Sensitive Data:** No PII, but contains configuration logic that may be sensitive to business operations.
- **Timestamps:** Assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** The `active` column is used for soft-deletion; queries should filter by `WHERE active = TRUE` unless auditing archived configurations.
- **JSONB:** The `name` and `picking_properties_definition` columns contain JSONB data; use `->>` or `->` operators in PostgreSQL to extract values.
- **Odoo Context:** This table is highly relational; ensure joins to `stock_warehouse` and `res_company` are handled correctly to avoid cross-company data leakage.