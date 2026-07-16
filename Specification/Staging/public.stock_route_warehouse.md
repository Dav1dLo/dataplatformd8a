# stock_route_warehouse

## Source system
Unknown — insufficient evidence. The naming convention suggests an internal logistics or supply chain management system, but the lack of metadata or specific system-identifying prefixes makes a definitive attribution to a platform like SAP or Oracle impossible.

## Functional process 
This table supports the logistics and distribution network configuration process. It defines the many-to-many relationship between shipping routes and the warehouses that serve as nodes or transit points within those routes.

## Description
One row in this table represents a single association between a specific shipping route and a warehouse. It serves as a raw landing staging table, capturing the mapping configuration used to determine which warehouses are serviced by which routes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| route_id | INTEGER | false | Unique identifier for the shipping route | Foreign key to the routes master table. |
| warehouse_id | INTEGER | false | Unique identifier for the warehouse | Foreign key to the warehouses master table. |

## Keys

- **Primary key (inferred):** Composite key of (`route_id`, `warehouse_id`).
- **Foreign keys (inferred):** 
    - `route_id` → `routes.id`: Guessed based on the naming convention and standard relational modeling for route-warehouse associations.
    - `warehouse_id` → `warehouses.id`: Guessed based on the naming convention and standard relational modeling for route-warehouse associations.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table represents a junction/link table; expect high cardinality if the network is complex.
- No audit timestamps (e.g., `created_at`, `updated_at`) are present; incremental loading logic must rely on source-side change data capture (CDC) or full-table snapshots.
- There is no soft-delete flag; assume that the absence of a record implies the removal of the association in the source system.