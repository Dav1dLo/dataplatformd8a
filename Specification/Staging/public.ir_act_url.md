# ir_act_url

## Source system
This table originates from an Odoo ERP system, as evidenced by the `ir_` prefix (common in Odoo's "ir" or "ir_actions" module), the use of `JSONB` for localized fields like `name` and `help`, and the standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the Odoo "Actions" framework, specifically managing URL-based actions that appear in the user interface. It defines how the system navigates to external or internal URLs when a user triggers a specific menu item or button, often used for integrating external web-based tools or documentation directly into the ERP dashboard.

## Description
One row represents a single URL action definition within the Odoo system. It acts as a raw landing copy of the configuration record, storing the destination URL, the display name, and the binding context that determines where in the UI the action is available.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.ir_actions_id_seq`. |
| binding_model_id | INTEGER | true | Foreign key to the model this action is bound to | Links to `ir_model` table. |
| create_uid | INTEGER | true | User ID who created the record | Links to `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | Links to `res_users` table. |
| type | VARCHAR | false | Action type identifier | Typically 'ir.actions.act_url'. |
| path | VARCHAR | true | URL path segment | Often used for routing logic. |
| binding_type | VARCHAR | false | Binding category | Defines if the action is for a model or a report. |
| binding_view_types | VARCHAR | true | UI view types | Comma-separated list of views (e.g., 'list,form'). |
| name | JSONB | false | Display name of the action | Multilingual JSON object. |
| help | JSONB | true | Help tooltip text | Multilingual JSON object. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| target | VARCHAR | false | Navigation target | e.g., 'current', 'new' (for new tab). |
| url | TEXT | false | The destination URL | The actual link to be opened. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `binding_model_id` → `ir_model.id` (Evidence: standard Odoo naming convention for model bindings).
    - `create_uid` → `res_users.id` (Evidence: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Evidence: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `url` column may contain sensitive parameters or internal path structures; treat with caution.
- **Timezones:** Timestamps are stored in the database server's time, typically UTC in Odoo deployments.
- **Data Format:** The `name` and `help` columns are `JSONB` and will require extraction (e.g., `name->>'en_US'`) to be used in standard reporting tools.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically hard-deleted in Odoo's `ir` tables.