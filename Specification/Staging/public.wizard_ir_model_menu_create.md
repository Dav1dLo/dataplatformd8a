# wizard_ir_model_menu_create

## Source system
This table originates from an Odoo ERP environment. The naming convention `ir_model_menu_create` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal registry (IR) models used for managing menu creation wizards.

## Functional process 
This table supports the administrative process of generating menu items within the Odoo application interface. It tracks the state and metadata of wizard sessions used to link specific models to the application's menu structure, facilitating the dynamic creation of UI navigation elements.

## Description
One row in this table represents a single execution instance of a menu creation wizard. It acts as a staging record for the configuration parameters required to register a new menu item in the system. This is a raw landing table capturing the transient state of the menu creation process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| menu_id | INTEGER | false | Target menu identifier | Foreign key reference to the parent menu structure. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Menu display name | The label for the menu item being created. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of when the wizard record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification to the record. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `menu_id` → `ir_ui_menu.id` (Guess: standard Odoo relationship for menu management).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail for user creation).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail for user modification).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against `res_users` to resolve PII (names/emails).
- **Timestamps:** Assumed to be in UTC, consistent with Odoo's standard database storage format.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely permanent audit logs of wizard activity.
- **Data Quality:** As a wizard staging table, records may be transient or incomplete depending on whether the user completed the menu creation process.