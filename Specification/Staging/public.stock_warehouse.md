# stock_warehouse

## Source system
This table originates from Odoo ERP, indicated by the characteristic naming conventions such as `_id` suffixes for relational fields, `create_uid`/`write_uid` audit columns, and specific module-related fields like `reception_steps`, `pbm_type_id` (Pick-Before-Manufacturing), and `mto_pull_id` (Make-to-Order).

## Functional process 
This table supports the Inventory and Warehouse Management process. It defines the physical and logical structure of warehouses, including their associated stock locations (input, quality control, output, packing), internal routing configurations, and supply chain strategies (e.g., Make-to-Order, resupply rules).

## Description
One row represents a single warehouse entity within the organization, defining its operational configuration and logistical workflow. This is a raw landed copy of the Odoo `stock.warehouse` model, serving as the primary dimension for warehouse-level inventory operations in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | false | Foreign key to company | Links warehouse to a specific legal entity. |
| partner_id | INTEGER | true | Foreign key to partner | Address/contact associated with the warehouse. |
| view_location_id | INTEGER | false | Foreign key to location | The root location for the warehouse hierarchy. |
| lot_stock_id | INTEGER | false | Foreign key to location | The primary stock location for this warehouse. |
| wh_input_stock_loc_id | INTEGER | true | Foreign key to location | Input location for incoming goods. |
| wh_qc_stock_loc_id | INTEGER | true | Foreign key to location | Quality control location. |
| wh_output_stock_loc_id | INTEGER | true | Foreign key to location | Output location for outgoing shipments. |
| wh_pack_stock_loc_id | INTEGER | true | Foreign key to location | Packing location. |
| mto_pull_id | INTEGER | true | Foreign key to pull rule | Rule for Make-to-Order replenishment. |
| pick_type_id | INTEGER | true | Foreign key to operation type | Picking operation type. |
| pack_type_id | INTEGER | true | Foreign key to operation type | Packing operation type. |
| out_type_id | INTEGER | true | Foreign key to operation type | Outgoing shipment operation type. |
| in_type_id | INTEGER | true | Foreign key to operation type | Incoming shipment operation type. |
| int_type_id | INTEGER | true | Foreign key to operation type | Internal transfer operation type. |
| qc_type_id | INTEGER | true | Foreign key to operation type | Quality control operation type. |
| store_type_id | INTEGER | true | Foreign key to operation type | Store operation type. |
| xdock_type_id | INTEGER | true | Foreign key to operation type | Cross-dock operation type. |
| crossdock_route_id | INTEGER | true | Foreign key to route | Cross-docking route configuration. |
| reception_route_id | INTEGER | true | Foreign key to route | Reception route configuration. |
| delivery_route_id | INTEGER | true | Foreign key to route | Delivery route configuration. |
| sequence | INTEGER | true | Display sequence | Used for UI ordering. |
| create_uid | INTEGER | true | User ID | Creator of the record. |
| write_uid | INTEGER | true | User ID | Last modifier of the record. |
| name | VARCHAR | false | Warehouse name | Descriptive name of the warehouse. |
| code | VARCHAR(5) | false | Warehouse short code | Unique short identifier (e.g., WH01). |
| reception_steps | VARCHAR | false | Reception strategy | e.g., 'one_step', 'two_steps'. |
| delivery_steps | VARCHAR | false | Delivery strategy | e.g., 'ship_only', 'pick_pack_ship'. |
| active | BOOLEAN | true | Soft-delete flag | False indicates the warehouse is archived. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| manufacture_pull_id | INTEGER | true | Foreign key to pull rule | Manufacturing replenishment rule. |
| manufacture_mto_pull_id | INTEGER | true | Foreign key to pull rule | MTO manufacturing rule. |
| pbm_mto_pull_id | INTEGER | true | Foreign key to pull rule | Pick-before-manufacturing MTO rule. |
| sam_rule_id | INTEGER | true | Foreign key to pull rule | Sub-assembly rule. |
| manu_type_id | INTEGER | true | Foreign key to operation type | Manufacturing operation type. |
| pbm_type_id | INTEGER | true | Foreign key to operation type | Pick-before-manufacturing type. |
| sam_type_id | INTEGER | true | Foreign key to operation type | Sub-assembly operation type. |
| pbm_route_id | INTEGER | true | Foreign key to route | Pick-before-manufacturing route. |
| pbm_loc_id | INTEGER | true | Foreign key to location | Pick-before-manufacturing location. |
| sam_loc_id | INTEGER | true | Foreign key to location | Sub-assembly location. |
| manufacture_steps | VARCHAR | false | Manufacturing strategy | e.g., 'mto', 'mts'. |
| manufacture_to_resupply | BOOLEAN | true | Resupply flag | Boolean for manufacturing resupply. |
| pos_type_id | INTEGER | true | Foreign key to operation type | Point of Sale operation type. |
| buy_pull_id | INTEGER | true | Foreign key to pull rule | Purchase replenishment rule. |
| buy_to_resupply | BOOLEAN | true | Resupply flag | Boolean for purchase resupply. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `partner_id` → `res_partner.id` (Standard Odoo contact linking).
    - `view_location_id` → `stock_location.id` (Links to the warehouse's root location).
- **Natural keys (inferred):** 
    - `code` (The short warehouse code is typically unique per Odoo instance).

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC as per Odoo standard behavior.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless auditing archived warehouses.
- **Data Integrity:** Many columns are foreign keys to other Odoo tables (locations, routes, operation types); ensure joins are handled via `LEFT JOIN` as many are nullable.
- **Precision:** `code` is strictly limited to 5 characters; ensure downstream systems respect this constraint.