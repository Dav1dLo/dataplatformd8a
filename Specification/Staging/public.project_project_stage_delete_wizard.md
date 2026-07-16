# project_project_stage_delete_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention `project_project_stage_delete_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's transient model architecture used for UI-driven wizard processes.

## Functional process 
This table supports the project management module's "Project Stage Deletion" workflow. It acts as a temporary state container for the wizard process that handles the logic of removing a project stage, likely managing the reassignment or cleanup of tasks associated with the stage being deleted.

## Description
One row in this table represents a single execution instance of the project stage deletion wizard. It serves as a raw landing copy of the transient data used during the interactive deletion process within the Odoo application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `project_project_stage_delete_wizard_id_seq`. |
| create_uid | INTEGER | true | User ID who initiated the wizard | References `res.users`. |
| write_uid | INTEGER | true | User ID who last updated the wizard | References `res.users`. |
| create_date | TIMESTAMP | true | Timestamp of wizard creation | Inferred UTC. |
| write_date | TIMESTAMP | true | Timestamp of last wizard update | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo audit field linking to the user who created the record.
    - `write_uid` → `res_users.id`: Standard Odoo audit field linking to the user who last modified the record.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table represents a "Transient" model in Odoo; data here is typically short-lived and may be purged by the application periodically.
- Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- No PII is explicitly identified, but `create_uid` and `write_uid` link to user identity records.
- This table is unlikely to contain meaningful historical business data; it is primarily for tracking the state of an active UI operation.