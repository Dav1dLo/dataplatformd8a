# hr_skill_level

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequences for primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the Human Resources management module, specifically the skills and competency tracking process. It defines the hierarchical or categorical levels (e.g., "Beginner", "Intermediate", "Expert") that can be assigned to specific skills within the organization.

## Description
One row in this table represents a specific proficiency level definition associated with a skill type. It serves as a staging entity, providing a raw copy of the skill level configuration data used to standardize employee competency assessments.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_skill_level_id_seq`. |
| skill_type_id | INTEGER | true | Foreign key to the parent skill type | Links to the category of skill this level belongs to. |
| level_progress | INTEGER | true | Numerical progress indicator | Represents the percentage or rank value of the level. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table. |
| name | VARCHAR | false | Name of the skill level | The display label for the level. |
| default_level | BOOLEAN | true | Default level flag | Indicates if this is the starting level for a skill. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `skill_type_id` → `hr_skill_type.id` (Guess: standard Odoo naming pattern for skill categories).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, as is standard for Odoo PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active`), so assume all rows are current unless filtered by business logic.
- **Data Integrity:** `skill_type_id` is nullable; ensure queries handle orphaned skill levels if the parent skill type has been removed.
- **Precision:** The `VARCHAR` type for `name` does not specify a length; downstream systems should be prepared for varying string lengths.