# stock_picking

## Source system
This table originates from Odoo ERP, indicated by the characteristic naming convention (`stock_picking`, `create_uid`, `write_uid`), the use of `JSONB` for properties, and the specific sequence-based primary key pattern (`nextval('"public".stock_picking_id_seq'::regclass)`).

## Functional process 
This table supports the inventory management and logistics pipeline, specifically the "picking" process which tracks the movement of goods between locations. It integrates with sales (`sale_id`), point of sale (`pos_order_id`), and project management (`project_id`) to coordinate fulfillment, returns, and backorders.

## Description
One row represents a single inventory picking operation, which is a document authorizing the movement of products from a source location to a destination location. This table serves as a raw landed copy of the Odoo `stock.picking` model, capturing the state, scheduling, and audit metadata for warehouse operations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| backorder_id | INTEGER | true | Reference to the original picking | Links to a parent picking if this is a backorder. |
| return_id | INTEGER | true | Reference to the return picking | Links to the original picking if this is a return. |
| group_id | INTEGER | true | Procurement group ID | Used to group related stock moves. |
| location_id | INTEGER | false | Source location ID | The origin warehouse location. |
| location_dest_id | INTEGER | false | Destination location ID | The target warehouse location. |
| picking_type_id | INTEGER | false | Picking type ID | Defines the operation type (e.g., Receipt, Delivery). |
| partner_id | INTEGER | true | Customer/Vendor ID | The business partner associated with the move. |
| company_id | INTEGER | true | Company ID | Multi-company context identifier. |
| user_id | INTEGER | true | Responsible user ID | The employee assigned to this picking. |
| owner_id | INTEGER | true | Stock owner ID | Used for third-party logistics/consignment. |
| create_uid | INTEGER | true | Creator user ID | Audit: user who created the record. |
| write_uid | INTEGER | true | Modifier user ID | Audit: user who last modified the record. |
| name | VARCHAR | true | Picking reference number | The human-readable document number (e.g., WH/OUT/0001). |
| origin | VARCHAR | true | Source document | Reference to the document that triggered the picking. |
| move_type | VARCHAR | false | Delivery strategy | Defines how to handle partial deliveries. |
| state | VARCHAR | true | Lifecycle status | Current status (e.g., draft, waiting, assigned, done). |
| priority | VARCHAR | true | Urgency level | Priority indicator for warehouse staff. |
| picking_properties | JSONB | true | Dynamic properties | Flexible storage for custom attributes. |
| note | TEXT | true | Internal notes | Free-text field for warehouse instructions. |
| has_deadline_issue | BOOLEAN | true | Deadline flag | Indicates if the picking is behind schedule. |
| printed | BOOLEAN | true | Print status | Indicates if the picking slip has been generated. |
| is_locked | BOOLEAN | true | Lock status | Prevents modification of the picking. |
| scheduled_date | TIMESTAMP | true | Scheduled date | Planned date for the operation. |
| date_deadline | TIMESTAMP | true | Deadline date | The latest date to complete the operation. |
| date | TIMESTAMP | true | Effective date | The date the picking was confirmed. |
| date_done | TIMESTAMP | true | Completion date | The actual timestamp when the picking was finished. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit: record creation time. |
| write_date | TIMESTAMP | true | Modification timestamp | Audit: record last update time. |
| project_id | INTEGER | true | Project ID | Links to project management module. |
| pos_session_id | INTEGER | true | POS session ID | Links to a Point of Sale session. |
| pos_order_id | INTEGER | true | POS order ID | Links to a specific Point of Sale order. |
| sale_id | INTEGER | true | Sales order ID | Links to the originating Sales Order. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Likely link to customer/vendor master data)
    - `sale_id` → `sale_order.id` (Likely link to sales order header)
    - `location_id` / `location_dest_id` → `stock_location.id` (Likely link to warehouse location definitions)
- **Natural keys (inferred):** 
    - `name` (The document number, e.g., "WH/OUT/00001", is typically unique within an Odoo instance)

## Caveats for downstream consumers

- **Sensitive Data:** `partner_id` and `user_id` link to entities that may contain PII.
- **Timestamps:** All timestamps are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** Odoo typically uses hard deletes for this table; however, check for `active` flags if present in other related tables.
- **JSONB:** The `picking_properties` column contains unstructured data; ensure your downstream pipeline handles schema evolution for this field.
- **State Logic:** The `state` column is a critical business logic field; ensure you filter for `state = 'done'` when calculating completed inventory movements.