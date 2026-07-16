# stock_wh_resupply_table

## Source system
Unknown — insufficient evidence. The naming convention suggests an internal warehouse management or logistics system, but there are no specific vendor-identifying prefixes or patterns (e.g., SAP, Oracle, NetSuite) to confirm the origin.

## Functional process 
This table supports the inventory replenishment and supply chain logistics process. It defines the relationship between warehouses, specifically identifying which warehouse acts as the supplier for a given destination warehouse.

## Description
One row in this table represents a single supply-chain link between two warehouse entities. It serves as a raw landed mapping table in the staging layer, intended to define the topology of the internal distribution network.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| supplied_wh_id | INTEGER | false | The unique identifier of the warehouse receiving the stock. | Foreign key to the master warehouse table. |
| supplier_wh_id | INTEGER | false | The unique identifier of the warehouse providing the stock. | Foreign key to the master warehouse table. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata. It is likely a composite key of `(supplied_wh_id, supplier_wh_id)`.
- **Foreign keys (inferred):** 
    - `supplied_wh_id → warehouses.id`: Guessed based on the suffix `_wh_id` and the context of warehouse resupply.
    - `supplier_wh_id → warehouses.id`: Guessed based on the suffix `_wh_id` and the context of warehouse resupply.
- **Natural keys (inferred):** 
    - `(supplied_wh_id, supplier_wh_id)`: This pair represents the unique business relationship between a supplier and a recipient warehouse.

## Caveats for downstream consumers

- This table contains no timestamps or audit metadata; it is a snapshot of the current supply configuration.
- The table structure implies a directed graph of warehouse dependencies; ensure queries handle potential circular references if the business logic allows for bidirectional supply.
- There are no soft-delete flags; assume this table represents the current active state of the supply network.