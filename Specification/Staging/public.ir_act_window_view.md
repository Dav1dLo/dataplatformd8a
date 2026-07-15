# ir_act_window_view

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_act_window_view` (Information Resource Action Window View) is a standard internal table structure within the Odoo framework used to map specific views to window actions.

## Functional process 
This table supports the UI/UX configuration process within the ERP, specifically defining which views (e.g., form, tree, kanban) are associated with specific window actions. It dictates the order and availability of views when a user navigates to a specific record or menu item.

## Description
One row in this table represents a single association between a window action and a specific view definition. It serves as a raw landed copy of the Odoo metadata table, capturing the configuration state of the application interface at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_act_window_view_id_seq`. |
| sequence | INTEGER | true | Display order | Determines the priority of the view in the UI. |
| view_id | INTEGER | true | Foreign key to view definition | References the specific view object. |
| act_window_id | INTEGER | true | Foreign key to window action | References the parent action definition. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| view_mode | VARCHAR | false | View type | e.g., 'tree', 'form', 'kanban'. |
| multi | BOOLEAN | true | Multi-record flag | Indicates if the view supports multi-record operations. |
| create_date | TIMESTAMP | true | Creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id` (Guess: standard Odoo naming for view definitions).
    - `act_window_id` → `ir_act_window.id` (Guess: standard Odoo naming for window actions).
    - `create_uid` → `res_users.id` (Guess: standard Odoo reference for system users).
    - `write_uid` → `res_users.id` (Guess: standard Odoo reference for system users).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains system configuration metadata; it does not contain PII, but it does track administrative user activity via `create_uid` and `write_uid`.
- The table does not implement soft deletes; it reflects the current state of the Odoo metadata repository.
- `view_mode` is a critical field for filtering; ensure downstream joins account for the specific view types required for your analysis.