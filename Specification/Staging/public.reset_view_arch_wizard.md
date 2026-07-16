# reset_view_arch_wizard

## Source system
The table likely originates from an Odoo ERP or a similar modular business application framework. The naming convention (e.g., `_id_seq`, `create_uid`, `write_uid`, `write_date`) is highly characteristic of the Odoo ORM's internal audit and tracking columns.

## Functional process 
This table supports the "UI/UX Configuration" or "View Customization" process. It appears to track wizard-based operations used to reset or revert architectural view definitions (XML layouts) to their original state, likely allowing users to compare current view architectures against previous versions or default templates.

## Description
One row represents a single execution instance of a "reset view architecture" wizard session. It acts as a staging record capturing the parameters of the reset operation, including the target view, the comparison view, and the user-initiated audit metadata. Its purpose in the staging layer is to provide a raw, immutable record of configuration changes performed via the application's UI.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.reset_view_arch_wizard_id_seq`. |
| view_id | INTEGER | true | Target view identifier | Foreign key to the system's view definition table. |
| compare_view_id | INTEGER | true | Comparison view identifier | Used when resetting against a specific baseline view. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the wizard session. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this wizard record. |
| reset_mode | VARCHAR | false | Reset operation mode | Defines the logic or scope of the reset (e.g., 'hard', 'soft'). |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp of when the wizard session was started. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification to this record. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id` (Guess: standard Odoo view table).
    - `compare_view_id` → `ir_ui_view.id` (Guess: standard Odoo view table).
    - `create_uid` → `res_users.id` (Guess: standard Odoo user table).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Data Integrity:** `view_id` and `compare_view_id` are nullable, implying some wizard sessions may not be tied to a specific view context or may represent global resets.
- **Soft Deletes:** This table does not appear to have an `active` or `deleted` flag; assume all records are current unless otherwise specified by the source system logic.