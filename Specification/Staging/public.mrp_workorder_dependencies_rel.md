# mrp_workorder_dependencies_rel

## Source system
This table likely originates from an ERP or Manufacturing Execution System (MES) such as Odoo or a similar modular business suite. The naming convention `mrp_` (Manufacturing Resource Planning) and the `_rel` suffix are characteristic of join tables used in relational databases to manage many-to-many relationships between work orders.

## Functional process 
This table supports the production scheduling and sequencing process. It defines the dependency graph for manufacturing work orders, ensuring that a specific work order cannot commence until its prerequisite (blocking) work order has been completed.

## Description
Each row represents a single dependency relationship between two work orders. It acts as a junction table to map which work order is blocked by another. This is a raw landing copy of the relationship state from the source ERP system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| workorder_id | INTEGER | false | The ID of the work order that is being blocked. | References the primary work order. |
| blocked_by_id | INTEGER | false | The ID of the work order that must be completed first. | The prerequisite work order. |

## Keys

- **Primary key (inferred):** Not confidently inferable. This table likely uses a composite primary key on `(workorder_id, blocked_by_id)`.
- **Foreign keys (inferred):** 
    - `workorder_id` → `mrp_workorder.id` (Guess: links to the main work order table).
    - `blocked_by_id` → `mrp_workorder.id` (Guess: links to the prerequisite work order).
- **Natural keys (inferred):** The combination of `(workorder_id, blocked_by_id)` acts as the unique business key for the dependency relationship.

## Caveats for downstream consumers

- This table is a junction table; expect no descriptive attributes, only foreign key identifiers.
- There is no explicit timestamp or audit metadata provided in this table; the current state represents the latest snapshot from the source.
- Ensure that queries account for potential circular dependencies if the source system does not enforce strict acyclic graph validation at the application level.