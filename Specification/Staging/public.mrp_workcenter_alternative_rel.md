# mrp_workcenter_alternative_rel

## Source system
This table likely originates from an ERP system such as Odoo or a similar manufacturing execution system (MES). The naming convention `mrp_` (Manufacturing Resource Planning) and the `_rel` suffix are characteristic of join tables used in relational ERP databases to manage many-to-many relationships between production resources.

## Functional process 
This table supports the production scheduling and capacity planning process. It defines the relationship between primary work centers and their designated alternatives, allowing the manufacturing system to reroute production tasks if a primary work center is unavailable or at capacity.

## Description
Each row represents a single mapping between a primary work center and an alternative work center that can perform the same operations. This is a raw landing table in the staging layer, capturing the direct association as defined in the source ERP's configuration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| workcenter_id | INTEGER | false | Foreign key to the primary work center. | References the primary resource ID. |
| alternative_workcenter_id | INTEGER | false | Foreign key to the alternative work center. | References the backup resource ID. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of `(workcenter_id, alternative_workcenter_id)`.
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id`: Guessed based on standard ERP naming conventions for work center entities.
    - `alternative_workcenter_id` → `mrp_workcenter.id`: Guessed based on the column name implying a reference to the same work center entity table.
- **Natural keys (inferred):** The combination of `(workcenter_id, alternative_workcenter_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There is no explicit "active" or "deleted" flag; assume all rows represent currently defined relationships in the source system.
- Ensure inner joins are used when linking to `mrp_workcenter` to avoid orphaned records if the source system does not enforce strict referential integrity.