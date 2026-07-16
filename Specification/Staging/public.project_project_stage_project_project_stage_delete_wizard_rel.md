# project_project_stage_project_project_stage_delete_wizard_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `_rel` combined with the specific association between a "delete wizard" and a "project stage" is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to manage associations between wizard instances and the records they are processing.

## Functional process 
This table supports the project management module's cleanup or deletion workflows. It tracks the association between a specific "delete wizard" session and the "project stages" targeted for removal or modification within that session, ensuring the wizard knows which records to act upon.

## Description
One row represents a single link between a project stage deletion wizard instance and a specific project stage record. This table serves as a raw landing of an Odoo join table, facilitating the many-to-many relationship required for batch processing of stage deletions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_project_stage_delete_wizard_id | INTEGER | false | Foreign key to the delete wizard instance | Links to the wizard session record. |
| project_project_stage_id | INTEGER | false | Foreign key to the project stage record | Links to the specific stage being processed. |

## Keys

- **Primary key (inferred):** The combination of `project_project_stage_delete_wizard_id` and `project_project_stage_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `project_project_stage_delete_wizard_id` → `project_project_stage_delete_wizard.id` (Inferred from Odoo naming conventions for wizard relations).
    - `project_project_stage_id` → `project_project_stage.id` (Inferred from Odoo naming conventions for model relations).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a join table; it contains no business data other than the relationship itself.
- There are no timestamps or audit columns; the lifecycle of these rows is tied to the duration of the wizard session in the source application.
- Ensure joins to this table are performed on both columns to maintain referential integrity.