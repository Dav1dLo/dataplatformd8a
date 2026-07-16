# mrp_routing_workcenter_dependencies_rel

## Source system
This table likely originates from an ERP or Manufacturing Execution System (MES) such as Odoo or a similar modular manufacturing suite. The naming convention `mrp_routing_workcenter_dependencies_rel` is characteristic of an association table used to manage many-to-many relationships between manufacturing routing operations and their prerequisite dependencies.

## Functional process 
This table supports the production scheduling and manufacturing routing process. It defines the sequence constraints in a bill of operations, ensuring that specific manufacturing steps (operations) cannot commence until their prerequisite operations (blocked_by) have been completed.

## Description
Each row represents a single dependency relationship between two manufacturing operations within a routing sequence. It is a raw landing copy of a join table, serving to map which operation must be finished before another can begin.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| operation_id | INTEGER | false | The ID of the dependent manufacturing operation. | Foreign key to the operations table. |
| blocked_by_id | INTEGER | false | The ID of the prerequisite manufacturing operation. | Foreign key to the operations table. |

## Keys

- **Primary key (inferred):** The composite of (`operation_id`, `blocked_by_id`).
- **Foreign keys (inferred):** 
    - `operation_id` → `mrp_routing_workcenter.id`: This column identifies the operation being constrained.
    - `blocked_by_id` → `mrp_routing_workcenter.id`: This column identifies the operation that acts as the prerequisite.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- Ensure that queries account for potential circular dependencies (e.g., A depends on B, B depends on A) which may exist in the source data and could cause infinite loops in recursive CTEs.
- There are no timestamps or soft-delete flags present; this table represents the current state of dependencies as captured during the last ingestion.