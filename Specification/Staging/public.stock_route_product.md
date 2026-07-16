# stock_route_product

## Source system
Unknown — insufficient evidence. The table name suggests a mapping between logistics routes and product catalogs, which is common in ERP or Warehouse Management Systems (WMS), but the lack of metadata prevents a definitive attribution to a specific vendor system.

## Functional process 
This table supports the mapping of products to specific distribution or logistics routes. It likely facilitates inventory allocation or shipping logic by defining which products are eligible for transport via specific routes in a supply chain management process.

## Description
Each row represents a unique association between a specific product and a defined logistics route. As a staging table, it serves as a raw, landed link entity used to resolve many-to-many relationships between product master data and route definitions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| route_id | INTEGER | false | Unique identifier for the logistics route | Foreign key to the routes master table |
| product_id | INTEGER | false | Unique identifier for the product | Foreign key to the products master table |

## Keys

- **Primary key (inferred):** (`route_id`, `product_id`) — The combination of these two columns is required to uniquely identify the relationship.
- **Foreign keys (inferred):** 
    - `route_id` → `routes.id` (guess: standard naming convention for route entities).
    - `product_id` → `products.id` (guess: standard naming convention for product entities).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; ensure joins are handled correctly to avoid fan-out issues when aggregating product or route data.
- No audit timestamps (e.g., `created_at`, `updated_at`) are present; assume this is a snapshot or a raw feed without native change tracking.
- There are no soft-delete flags; assume the presence of a row indicates an active relationship.