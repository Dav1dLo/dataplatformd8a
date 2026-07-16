# mrp_routing_workcenter_dependencies_rel

## Source system
This table likely originates from an Odoo ERP or a similar manufacturing execution system (MES). The naming convention `mrp_routing_workcenter_dependencies_rel` is characteristic of Odoo's internal table naming for many-to-many relationship tables (often suffixed with `_rel`), specifically managing dependencies between manufacturing routing operations.

## Functional process 
This table supports the manufacturing production planning process, specifically the sequencing of operations within a routing. It defines the dependency graph where one manufacturing operation must be completed before another can begin, ensuring correct workflow execution on the shop floor.

## Description
Each row represents a single dependency relationship between two manufacturing operations, where one operation is blocked by the completion of another. This is a raw landing table representing a many-to-many join entity, used to reconstruct the sequence of workcenter tasks in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| operation_id | INTEGER | false | The ID of the operation that is being blocked. | References the primary key of the operations table. |
| blocked_by_id | INTEGER | false | The ID of the operation that must be completed first. | References the primary key of the operations table. |

## Keys

- **Primary key (inferred):** The composite of `(operation_id, blocked_by_id)`.
- **Foreign keys (inferred):** 
    - `operation_id → mrp_routing_operation.id` (Guess: Represents the dependent task).
    - `blocked_by_id → mrp_routing_operation.id` (Guess: Represents the prerequisite task).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only relationship identifiers.
- There is no explicit `is_active` or `deleted` flag; assume this represents the current state of dependencies as captured during the last extraction.
- Ensure that downstream joins handle the potential for circular dependencies, as this table structure does not inherently prevent them.