# ir_act_server

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP platform. The naming convention `ir_act_server` (Internal Resource Action Server) is a core component of the Odoo framework's action management system, which handles server-side automated actions and triggers.

## Functional process 
This table supports the "Automated Action" or "Server Action" engine within Odoo. It defines logic that executes on the server side in response to user interactions, cron jobs, or data changes, such as updating records, sending emails, triggering SMS, or executing custom Python code.

## Description
One row represents a single server-side action definition, including its execution logic, target model, and trigger configuration. This is a raw landed copy of the Odoo `ir.actions.server` model, serving as the staging entity for auditing or analyzing system automation and business logic triggers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| binding_model_id | INTEGER | true | Target model for action binding | Links to `ir_model`. |
| create_uid | INTEGER | true | Creator user ID | Links to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res_users`. |
| type | VARCHAR | false | Action type identifier | e.g., 'ir.actions.server'. |
| path | VARCHAR | true | URL path for web actions | Used for routing. |
| binding_type | VARCHAR | false | Binding scope | e.g., 'action', 'report'. |
| binding_view_types | VARCHAR | true | View types where action is visible | Comma-separated list. |
| name | JSONB | false | Action display name | Multi-language support via JSONB. |
| help | JSONB | true | Help/description text | Multi-language support via JSONB. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| sequence | INTEGER | true | Execution order | Lower numbers run first. |
| model_id | INTEGER | false | Target model ID | Links to `ir_model`. |
| crud_model_id | INTEGER | true | Target model for CRUD operations | Links to `ir_model`. |
| link_field_id | INTEGER | true | Field ID for linking | Links to `ir_model_fields`. |
| update_field_id | INTEGER | true | Field ID to update | Links to `ir_model_fields`. |
| update_related_model_id | INTEGER | true | Related model for updates | Links to `ir_model`. |
| selection_value | INTEGER | true | Selection field value | Used for filtering. |
| usage | VARCHAR | false | Usage category | e.g., 'ir_actions_server'. |
| state | VARCHAR | false | Action execution state | e.g., 'code', 'object_create'. |
| model_name | VARCHAR | true | Target model technical name | Denormalized model name. |
| update_path | VARCHAR | true | Path for field updates | Used in complex updates. |
| update_m2m_operation | VARCHAR | true | Many2many operation type | e.g., 'add', 'remove'. |
| update_boolean_value | VARCHAR | true | Boolean value for update | String representation. |
| evaluation_type | VARCHAR | true | Code evaluation mode | e.g., 'value', 'equation'. |
| resource_ref | VARCHAR | true | Resource reference | External reference string. |
| webhook_url | VARCHAR | true | Webhook endpoint URL | Used for external triggers. |
| code | TEXT | true | Python code block | The actual logic to execute. |
| value | TEXT | true | Static value for updates | Used in simple assignments. |
| template_id | INTEGER | true | Email template ID | Links to `mail_template`. |
| activity_type_id | INTEGER | true | Activity type ID | Links to `mail_activity_type`. |
| activity_date_deadline_range | INTEGER | true | Deadline range value | Integer offset. |
| activity_user_id | INTEGER | true | Assigned user ID | Links to `res_users`. |
| mail_post_method | VARCHAR | true | Email posting method | e.g., 'email', 'note'. |
| activity_summary | VARCHAR | true | Activity summary text | |
| activity_date_deadline_range_type | VARCHAR | true | Deadline range unit | e.g., 'days', 'weeks'. |
| activity_user_type | VARCHAR | true | User assignment type | e.g., 'specific', 'generic'. |
| activity_user_field_name | VARCHAR | true | Field name for user assignment | |
| activity_note | TEXT | true | Activity description | |
| mail_post_autofollow | BOOLEAN | true | Auto-follow flag | |
| sms_template_id | INTEGER | true | SMS template ID | Links to `sms_template`. |
| sms_method | VARCHAR | true | SMS sending method | |
| website_path | VARCHAR | true | Website URL path | |
| website_published | BOOLEAN | true | Published status | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `model_id` → `ir_model.id` (Defines the primary business object the action acts upon)
    - `create_uid` → `res_users.id` (Tracks the user who created the automation)
    - `template_id` → `mail_template.id` (Links to email templates for automated notifications)
- **Natural keys (inferred):**
    - None. Odoo actions are typically identified by their surrogate `id` within the `ir_actions` registry.

## Caveats for downstream consumers

- **Sensitive Data:** The `code` column contains raw Python logic which may include hardcoded credentials, API keys, or sensitive business logic. Mask or restrict access to this column.
- **Timestamps:** All `_date` columns are stored in UTC as per Odoo standard practice.
- **JSONB:** The `name` and `help` columns are `JSONB` and likely contain language-specific keys (e.g., `{"en_US": "My Action", "fr_FR": "Mon Action"}`). Use `->>` operator to extract values.
- **Soft Deletes:** This table does not implement soft deletes; rows are physically removed upon deletion in the source system.
- **Complexity:** The `code` column can contain complex, multi-line Python scripts. Ensure downstream parsers can handle large text blobs.