# ir_embedded_actions

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_embedded_actions` (where `ir` stands for "Internal Resources"), the presence of `create_uid`/`write_uid` audit columns, and the use of `JSONB` for translatable fields are characteristic of the Odoo framework's metadata and action management modules.

## Functional process 
This table supports the UI and navigation framework, specifically managing "embedded actions" that appear within the context of specific records or views. It defines how secondary actions (such as buttons, links, or specific view filters) are injected into the interface based on the `parent_res_model` and `parent_res_id`.

## Description
One row in this table represents a single embedded action configuration linked to a specific Odoo model or record. It acts as a raw landing copy of the system's internal action registry, used to determine which dynamic actions should be rendered for a user in the application interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order index | Used to sort actions in the UI. |
| parent_action_id | INTEGER | false | Reference to parent action | Links to the primary action definition. |
| parent_res_id | INTEGER | true | ID of the parent record | Null if the action is model-wide. |
| action_id | INTEGER | true | Target action ID | The specific action to be executed. |
| user_id | INTEGER | true | Restricted user ID | If set, the action is visible only to this user. |
| create_uid | INTEGER | true | Creator user ID | References `res_users.id`. |
| write_uid | INTEGER | true | Last modifier user ID | References `res_users.id`. |
| parent_res_model | VARCHAR | false | Target model name | The technical name of the Odoo model (e.g., 'sale.order'). |
| python_method | VARCHAR | true | Executable method name | Python function to trigger if applicable. |
| default_view_mode | VARCHAR | true | UI view type | e.g., 'tree', 'form', 'kanban'. |
| domain | VARCHAR | true | Filter domain | Odoo domain expression for filtering records. |
| context | VARCHAR | true | Action context | Dictionary-like string for UI state. |
| name | JSONB | true | Action display name | Multi-language label stored as JSON. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern)
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern)
    - `action_id` → `ir_actions.id` (Links to the core actions registry)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `context` and `domain` strings which may expose internal business logic or filter criteria.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's internal storage.
- **JSONB:** The `name` column is stored as `JSONB`; downstream consumers will need to use `->>` or `jsonb_extract_path_text` to access specific language keys.
- **Soft Deletes:** This table does not appear to implement soft deletes; it reflects the current state of the Odoo `ir_embedded_actions` table.
- **Precision:** `VARCHAR` lengths were not provided by the source; these are likely variable-length strings up to 255 characters in the source DDL.