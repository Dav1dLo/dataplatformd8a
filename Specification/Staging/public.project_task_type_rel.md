# project_task_type_rel

## Source system
The table likely originates from a project management or task-tracking operational system (e.g., Jira, Asana, or a custom ERP module). The naming convention `_rel` strongly suggests this is a junction table used to resolve a many-to-many relationship between project entities and task type definitions.

## Functional process 
This table supports the configuration of project-specific task workflows or taxonomies. It defines which task types are permitted or available within the scope of a specific project, ensuring that users can only assign relevant task categories to project-related work items.

## Description
Each row represents a single association between a project and a task type, effectively mapping a task category to a project container. As a staging table, it provides a raw, landed copy of the relationship link, serving as the foundation for building project-task configuration dimensions in downstream layers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_id | INTEGER | false | Unique identifier for the project | Foreign key to the projects master table. |
| type_id | INTEGER | false | Unique identifier for the task type | Foreign key to the task_types master table. |

## Keys

- **Primary key (inferred):** The composite key `(project_id, type_id)` is the inferred primary key, as it represents the unique link between the two entities.
- **Foreign keys (inferred):** 
    - `project_id` → `projects.id` (Inferred based on standard naming conventions for project associations).
    - `type_id` → `task_types.id` (Inferred based on standard naming conventions for type associations).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; expect no descriptive attributes other than the two foreign keys.
- There is no surrogate primary key (e.g., an `id` column), so queries should rely on the composite key for uniqueness.
- Ensure inner joins are used when filtering for valid project-task configurations, as this table contains no soft-delete flags or status indicators.