# stock_route

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for translatable fields like `name`.

## Functional process 
This table supports the inventory and logistics routing process, specifically defining the paths or "routes" that products take between warehouses or supply points. It is used to configure supply chain logic, such as determining which warehouses are selectable for specific products, categories, or sales operations.

## Description
One row in this table represents a single stock routing configuration rule or path. It acts as a raw landed copy of the Odoo `stock.route` model, capturing the operational parameters and metadata for inventory movement logic within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `stock_route_id_seq`. |
| sequence | INTEGER | true | Display order priority | Lower numbers typically indicate higher priority. |
| supplied_wh_id | INTEGER | true | Destination warehouse ID | Foreign key to the warehouse being supplied. |
| supplier_wh_id | INTEGER | true | Source warehouse ID | Foreign key to the supplying warehouse. |
| company_id | INTEGER | true | Owning company ID | Multi-company context identifier. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | JSONB | false | Route name | Often contains multi-language strings. |
| active | BOOLEAN | true | Soft-delete flag | If false, the route is archived. |
| product_selectable | BOOLEAN | true | Product selection flag | Indicates if this route can be applied to products. |
| product_categ_selectable | BOOLEAN | true | Category selection flag | Indicates if this route can be applied to product categories. |
| warehouse_selectable | BOOLEAN | true | Warehouse selection flag | Indicates if this route can be applied to warehouses. |
| packaging_selectable | BOOLEAN | true | Packaging selection flag | Indicates if this route can be applied to packaging. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| sale_selectable | BOOLEAN | true | Sales selection flag | Indicates if this route can be applied to sales orders. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `supplied_wh_id` → `stock_warehouse.id` (Guess: links to the destination warehouse).
    - `supplier_wh_id` → `stock_warehouse.id` (Guess: links to the source warehouse).
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII/Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may link to employee tables.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column should be filtered (`WHERE active = true`) for most operational reporting.
- **Data Format:** The `name` column is `JSONB`; downstream consumers will need to extract the relevant language key (e.g., `name->>'en_US'`) to use it in reporting.