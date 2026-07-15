# ir_act_client

## Source system
This table originates from an Odoo ERP system, as evidenced by the `ir_act_` naming convention (Internal Resource Actions), the use of `JSONB` for localized fields like `name` and `help`, and the specific sequence generator `ir_actions_id_seq`.

## Functional process 
This table supports the Odoo UI/UX framework by defining client-side actions. It manages how the interface behaves when a user triggers a specific action, such as opening a view, executing a wizard, or navigating to a specific URL, by storing the configuration parameters and binding logic required by the web client.

## Description
One row represents a single client-side action definition within the Odoo framework. It serves as a raw landed copy of the action configuration, capturing the metadata, target models, and execution context required to render UI components or trigger client-side logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `ir_actions_id_seq`. |
| binding_model_id | INTEGER | true | Foreign key to the model this action is bound to | Links to `ir_model`. |
| create_uid | INTEGER | true | User ID who created the record | Links to `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | Links to `res_users`. |
| type | VARCHAR | false | Action type identifier | Determines how the client interprets the action. |
| path | VARCHAR | true | URL path or resource location | Used for client-side navigation. |
| binding_type | VARCHAR | false | Binding category | e.g., 'action', 'report'. |
| binding_view_types | VARCHAR | true | Comma-separated list of view types | Defines where the action appears in the UI. |
| name | JSONB | false | Display name of the action | Localized string stored as JSON. |
| help | JSONB | true | Help tooltip or description | Localized string stored as JSON. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| tag | VARCHAR | false | Action tag/identifier | Used for client-side event triggering. |
| target | VARCHAR | true | UI target window | e.g., 'current', 'new'. |
| res_model | VARCHAR | true | Associated resource model | The model this action operates on. |
| context | VARCHAR | false | Execution context dictionary | Serialized dictionary of parameters. |
| params_store | BYTEA | true | Serialized parameters | Binary storage for complex action parameters. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `binding_model_id` → `ir_model.id` (Inferred from Odoo naming conventions).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB content:** The `name` and `help` columns contain JSONB data; queries requiring readable text must extract the appropriate language key (e.g., `name->>'en_US'`).
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** No direct PII, but `context` and `params_store` may contain internal system configuration details that should be handled with care.
- **Soft Deletes:** This table does not implement a soft-delete flag; records are typically hard-deleted in the source system.