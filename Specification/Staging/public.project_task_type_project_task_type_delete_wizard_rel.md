# project_task_type_project_task_type_delete_wizard_rel

## Source system
This table originates from an Odoo ERP environment, as indicated by the naming convention `_rel` (indicating a many-to-many join table) and the specific pattern of linking a wizard/process object (`delete_wizard`) to a core business entity (`project_task_type`).

## Functional process 
This table supports the project management module, specifically handling the cleanup or deletion workflow for project task types. It acts as a join table to track which task types are currently selected or associated with a specific "delete wizard" session, ensuring the system knows which records to process when a user initiates a bulk deletion.

## Description
One row in this table represents a single association between a project task type and a specific deletion wizard instance. It is a raw landing copy of a many-to-many relationship table used to manage state during the task type removal process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_task_type_delete_wizard_id | INTEGER | false | Foreign key to the delete wizard session | Links to the wizard instance managing the deletion. |
| project_task_type_id | INTEGER | false | Foreign key to the project task type | Identifies the specific task type targeted for deletion. |

## Keys

- **Primary key (inferred):** The combination of `project_task_type_delete_wizard_id` and `project_task_type_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `project_task_type_delete_wizard_id` → `project_task_type_delete_wizard.id` (Guess: standard Odoo naming convention for wizard relations).
    - `project_task_type_id` → `project_task_type.id` (Guess: standard Odoo naming convention for core entities).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a technical join table; it likely contains transient data that is cleared once the wizard process completes.
- There are no timestamps or audit columns; rely on the parent wizard table for session context.
- Ensure joins to parent tables handle potential orphaned records if the wizard session has already been purged from the source system.