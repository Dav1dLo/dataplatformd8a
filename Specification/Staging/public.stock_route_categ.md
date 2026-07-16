# stock_route_categ

## Source system
The table likely originates from an Odoo ERP system, as the naming convention `stock_route_categ` (linking stock routes to categories) is characteristic of Odoo's inventory management module schema.

## Functional process 
This table supports the inventory routing and logistics configuration process. It acts as a bridge table to associate specific stock routes (e.g., "Pick-Pack-Ship" or "Dropship") with product categories, defining how items within those categories should be handled or routed through the warehouse.

## Description
One row in this table represents a single association between a stock route and a product category. It serves as a raw landing copy of the many-to-many relationship mapping in the staging layer, enabling downstream models to determine which routing rules apply to specific product groups.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| route_id | INTEGER | false | Foreign key to the stock route definition | Links to the primary key of the stock route table. |
| categ_id | INTEGER | false | Foreign key to the product category definition | Links to the primary key of the product category table. |

## Keys

- **Primary key (inferred):** The combination of (`route_id`, `categ_id`) is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `route_id` → `stock_route.id`: Guessed based on standard Odoo naming conventions for route entities.
    - `categ_id` → `product_category.id`: Guessed based on standard Odoo naming conventions for category entities.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join/link table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure referential integrity checks are performed against the source `stock_route` and `product_category` tables, as this staging table may contain orphaned IDs if the source system does not enforce strict constraints.