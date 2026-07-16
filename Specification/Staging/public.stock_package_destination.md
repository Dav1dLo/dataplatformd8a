# stock_package_destination

## Source system
The table likely originates from an Odoo ERP system. The naming convention (e.g., `picking_id`, `location_dest_id`, `create_uid`, `write_date`) and the use of PostgreSQL sequences (`nextval` on `id`) are characteristic of Odoo's internal ORM structure for managing inventory picking operations.

## Functional process 
This table supports the inventory management and logistics pipeline. It tracks the destination locations associated with specific package movements or picking operations, ensuring that inventory items are routed to the correct warehouse zones or customer delivery points during the fulfillment process.

## Description
One row represents a specific destination assignment for a package within a picking operation. This is a raw landed staging table containing the direct mapping between a picking event and its target warehouse location, intended for use in downstream inventory movement analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.stock_package_destination_id_seq`. |
| picking_id | INTEGER | false | Foreign key to the picking operation | Links to the parent stock picking record. |
| location_dest_id | INTEGER | false | Foreign key to the destination location | Identifies the physical or logical warehouse location. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `picking_id` → `stock_picking.id` (Inferred from Odoo naming conventions for picking operations).
    - `location_dest_id` → `stock_location.id` (Inferred from Odoo naming conventions for warehouse locations).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC; verify against the source system configuration if local time offsets are observed.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Data Integrity:** As a staging table, ensure that `picking_id` and `location_dest_id` are validated against their respective master tables in the target layer to maintain referential integrity.