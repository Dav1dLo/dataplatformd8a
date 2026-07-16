# mrp_workcenter_mrp_workcenter_tag_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `mrp_workcenter_mrp_workcenter_tag_rel` is a standard pattern used by Odoo to represent a many-to-many relationship table (often referred to as an "ir_model_relation" table) linking manufacturing work centers to their associated tags.

## Functional process 
This table supports the manufacturing resource planning (MRP) process by enabling the categorization and filtering of work centers. It allows multiple tags to be assigned to a single work center, which is typically used for scheduling, capacity planning, or grouping resources by capability or location.

## Description
One row in this table represents a single association between a specific work center and a tag. It is a junction table used to resolve a many-to-many relationship, acting as a raw landed copy of the link between the `mrp.workcenter` and `mrp.workcenter.tag` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_workcenter_id | INTEGER | false | Foreign key to the work center | References the primary key of the work center entity. |
| mrp_workcenter_tag_id | INTEGER | false | Foreign key to the work center tag | References the primary key of the tag entity. |

## Keys

- **Primary key (inferred):** The composite key (`mrp_workcenter_id`, `mrp_workcenter_tag_id`) is the inferred primary key.
- **Foreign keys (inferred):** 
    - `mrp_workcenter_id` → `mrp_workcenter.id`: This column links to the master record for the manufacturing work center.
    - `mrp_workcenter_tag_id` → `mrp_workcenter_tag.id`: This column links to the definition of the specific tag applied.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `created_at` or `updated_at`) present in this table, making it difficult to determine the history of when associations were created or removed.
- Ensure that joins to the parent tables handle potential orphan records if referential integrity is not strictly enforced at the source database level.