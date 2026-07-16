# project_project_project_task_type_delete_wizard_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `project_project_project_task_type_delete_wizard_rel` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link wizard-based transient models (used for bulk operations or deletions) to core project entities.

## Functional process 
This table supports the "Project Management" module, specifically the cleanup or deletion workflow for task stages. It acts as a join table to associate specific project instances with a wizard session tasked with deleting or modifying task types (stages) across those projects.

## Description
One row in this table represents a single association between a project and a task type deletion wizard instance. It is a raw landed copy of a transient join table used to maintain state during bulk administrative operations within the project management interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_task_type_delete_wizard_id | INTEGER | false | Foreign key to the wizard session | Links to the transient wizard model. |
| project_project_id | INTEGER | false | Foreign key to the project | Links to the target project entity. |

## Keys

- **Primary key (inferred):** Not confidently inferable. Odoo many-to-many tables often lack a single-column surrogate PK, relying on a composite of both columns.
- **Foreign keys (inferred):** 
    - `project_task_type_delete_wizard_id` → `project_task_type_delete_wizard.id` (Inferred from naming convention).
    - `project_project_id` → `project_project.id` (Inferred from naming convention).
- **Natural keys (inferred):** The combination of `(project_task_type_delete_wizard_id, project_project_id)` is the unique business key for this relationship.

## Caveats for downstream consumers

- This table represents a transient wizard state; data here is likely short-lived and may be purged by the source system after the wizard operation completes.
- No PII is present in this table.
- There are no timestamps or soft-delete flags; assume this table is truncated or managed by the application's internal wizard lifecycle.