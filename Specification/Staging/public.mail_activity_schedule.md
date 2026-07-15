# mail_activity_schedule

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `res_model_id`, `create_uid`, `write_uid`, `res_ids`) and the use of PostgreSQL sequences for primary keys are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the automated activity scheduling and task management process within Odoo. It tracks planned activities or follow-ups associated with specific business records (like leads, opportunities, or partners), allowing users to define templates for recurring tasks or scheduled communications.

## Description
One row in this table represents a single scheduled activity configuration or a template for a business process. It acts as a staging record for defining when and to whom specific activities should be assigned relative to a business object. This table serves as a raw landing copy of the Odoo `mail.activity.schedule` model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mail_activity_schedule_id_seq`. |
| res_model_id | INTEGER | false | ID of the associated model | References the `ir.model` table. |
| plan_id | INTEGER | true | ID of the activity plan | Links to a specific activity plan definition. |
| plan_on_demand_user_id | INTEGER | true | User ID for on-demand tasks | The user responsible for triggering the activity. |
| activity_type_id | INTEGER | true | ID of the activity type | Defines the category of the activity (e.g., Call, Email). |
| activity_user_id | INTEGER | true | Assigned user ID | The user to whom the activity is assigned. |
| create_uid | INTEGER | true | Creator user ID | References `res.users` who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References `res.users` who last updated the record. |
| res_model | VARCHAR | false | Technical name of the model | The string identifier of the Odoo model (e.g., 'crm.lead'). |
| summary | VARCHAR | true | Activity summary | A short description or title for the activity. |
| plan_date | DATE | true | Planned date | The scheduled date for the activity. |
| date_deadline | DATE | true | Deadline date | The final date by which the activity must be completed. |
| res_ids | TEXT | true | Associated record IDs | A serialized list or reference to specific record IDs. |
| note | TEXT | true | Activity notes | Detailed instructions or context for the activity. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM on insertion. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM on update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `res_model_id` → `ir_model.id` (Inferred from Odoo standard schema).
    - `activity_type_id` → `mail_activity_type.id` (Inferred from Odoo standard schema).
    - `activity_user_id` → `res_users.id` (Inferred from Odoo standard schema).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are stored in UTC by the Odoo application server.
- **Soft Deletes:** This table does not implement soft deletes; records are physically removed from the database upon deletion in the source system.
- **Data Serialization:** The `res_ids` column contains text-based data that may require parsing (e.g., JSON or comma-separated values) depending on the Odoo version implementation.
- **PII:** The `summary` and `note` columns may contain free-text input from users which could include PII; ensure appropriate masking if exposing to non-authorized roles.