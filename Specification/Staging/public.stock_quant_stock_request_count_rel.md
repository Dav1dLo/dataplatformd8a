# stock_quant_stock_request_count_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` is a standard pattern used by Odoo to denote a many-to-many join table created automatically by the ORM to link two entities, in this case, `stock_request_count` and `stock_quant`.

## Functional process 
This table supports the inventory management and stock reservation process. It acts as a bridge to associate specific stock quantities (`stock_quant`) with stock request counts, facilitating the tracking of how much inventory is allocated or requested against specific stock records.

## Description
One row in this table represents a single association between a stock quantity record and a stock request count record. It serves as a raw, junction-table copy from the source system, maintaining the many-to-many relationship between inventory levels and request tracking.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_request_count_id | INTEGER | false | Foreign key to the stock request count entity | Represents the identifier for the request side of the relationship. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant entity | Represents the identifier for the inventory quantity side of the relationship. |

## Keys

- **Primary key (inferred):** Not confidently inferable. As a junction table, the primary key is likely a composite of `(stock_request_count_id, stock_quant_id)`.
- **Foreign keys (inferred):** 
    - `stock_request_count_id` → `stock_request_count.id` (Inferred from naming convention).
    - `stock_quant_id` → `stock_quant.id` (Inferred from naming convention).
- **Natural keys (inferred):** The combination of `(stock_request_count_id, stock_quant_id)` acts as the natural key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no additional descriptive attributes, only relationship identifiers.
- There are no timestamps or audit columns present in this table; tracking changes to these relationships requires comparing snapshots over time.
- Ensure inner joins are used when filtering by specific request or quant IDs to avoid Cartesian products.