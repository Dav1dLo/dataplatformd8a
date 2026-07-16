# stock_rule

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `picking_type_id`, `procure_method`, `route_id`, `write_uid`) and the presence of `JSONB` for localized names are characteristic of the Odoo framework's inventory management module.

## Functional process 
This table supports the inventory replenishment and supply chain routing process. It defines the rules that dictate how stock moves between locations, how procurement is triggered (e.g., "make to order" vs "make to stock"), and how warehouse operations are sequenced based on defined routes.

## Description
One row represents a single inventory rule that governs the movement or procurement of stock within a specific route. It acts as a configuration entity in the staging layer, capturing the logic for how items are pushed or pulled between source and destination locations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| group_id | INTEGER | true | Procurement group ID | Links to a grouping of procurement orders. |
| sequence | INTEGER | true | Rule priority | Lower numbers indicate higher priority. |
| company_id | INTEGER | true | Company ID | Multi-company context identifier. |
| location_dest_id | INTEGER | false | Destination location ID | Target location for the stock movement. |
| location_src_id | INTEGER | true | Source location ID | Origin location for the stock movement. |
| route_id | INTEGER | false | Route ID | Parent route this rule belongs to. |
| route_sequence | INTEGER | true | Route sequence | Ordering within the route. |
| picking_type_id | INTEGER | false | Picking type ID | Defines the operation type (e.g., Receipt, Delivery). |
| delay | INTEGER | true | Lead time | Delay in days for the rule execution. |
| partner_address_id | INTEGER | true | Partner address ID | Associated shipping or partner address. |
| warehouse_id | INTEGER | true | Warehouse ID | Warehouse associated with this rule. |
| propagate_warehouse_id | INTEGER | true | Propagate warehouse ID | Warehouse to propagate to. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| group_propagation_option | VARCHAR | true | Group propagation option | Strategy for propagating procurement groups. |
| action | VARCHAR | false | Action type | Defines the rule action (e.g., 'pull', 'push'). |
| procure_method | VARCHAR | false | Procurement method | Method used (e.g., 'make_to_stock'). |
| auto | VARCHAR | false | Automation mode | Defines if the rule is triggered automatically. |
| push_domain | VARCHAR | true | Push domain | Domain filter for push rules. |
| name | JSONB | false | Rule name | Localized name of the rule. |
| active | BOOLEAN | true | Active status | Soft-delete flag. |
| location_dest_from_rule | BOOLEAN | true | Use dest from rule | Flag to override destination location. |
| propagate_cancel | BOOLEAN | true | Propagate cancel | Flag to propagate cancellations. |
| propagate_carrier | BOOLEAN | true | Propagate carrier | Flag to propagate carrier info. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `route_id` → `stock_location_route.id` (Inferred from Odoo standard schema)
    - `location_dest_id` → `stock_location.id` (Inferred from Odoo standard schema)
    - `picking_type_id` → `stock_picking_type.id` (Inferred from Odoo standard schema)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with Odoo standard behavior.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE`.
- **JSONB:** The `name` column contains JSONB data; use `name->>'en_US'` or similar syntax to extract specific language values.
- **Data Integrity:** `location_src_id` is nullable, which is expected for rules where the source is implicit (e.g., procurement from external suppliers).