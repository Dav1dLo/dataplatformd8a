# stock_route_move

## Source system
The table likely originates from an ERP or Warehouse Management System (WMS) such as Odoo or a custom inventory management platform. The naming convention `stock_route_move` suggests a junction table linking inventory movement records to specific routing configurations.

## Functional process 
This table supports the inventory logistics and supply chain execution process. It defines the relationship between specific stock movements and the predefined routes or workflows they must follow within the warehouse or distribution network.

## Description
One row in this table represents a single association between a stock movement event and a routing path. It serves as a raw landing copy of a many-to-many relationship table, facilitating the mapping of movements to their respective operational routes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| move_id | INTEGER | false | Unique identifier for the stock movement | Foreign key to the stock_move table. |
| route_id | INTEGER | false | Unique identifier for the routing path | Foreign key to the stock_route table. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of (`move_id`, `route_id`).
- **Foreign keys (inferred):** 
    - `move_id` → `stock_move.id`: Links the association to the specific inventory movement record.
    - `route_id` → `stock_route.id`: Links the association to the specific routing definition.
- **Natural keys (inferred):** The composite of (`move_id`, `route_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; expect high cardinality and frequent joins to parent entities.
- There is no audit or timestamp column present; it is impossible to determine the temporal order of associations from this table alone.
- As a staging table, this data is provided "as-is" from the source; verify referential integrity against the source system before performing inner joins.