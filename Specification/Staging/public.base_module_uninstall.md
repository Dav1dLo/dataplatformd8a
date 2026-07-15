# base_module_uninstall

## Source system
This table originates from an Odoo ERP system. The naming convention (`base_module_uninstall`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the sequence-based primary key are characteristic of the Odoo framework's internal module management and metadata tracking.

## Functional process 
This table supports the module lifecycle management process within the ERP, specifically tracking the uninstallation or removal of software modules. It records the administrative actions taken when a module is flagged for removal, likely used to maintain a history of system configuration changes and to manage dependencies during the uninstallation workflow.

## Description
One row in this table represents a single uninstallation event or configuration record for a specific software module within the ERP environment. It serves as a raw landing copy of the system's internal module uninstall state, capturing the identity of the user who initiated or modified the record and the associated timestamps.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `base_module_uninstall_id_seq`. |
| module_id | INTEGER | false | Foreign key to the module being uninstalled | References the internal module registry. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users.id`. |
| show_all | BOOLEAN | true | Flag to display all modules | Likely a UI filter preference for the uninstallation wizard. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last record update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `ir_module_module.id` (Guess: standard Odoo link to the module definition table).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit link to the user who performed the action).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit link to the user who performed the action).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the system's default timezone (typically UTC in Odoo deployments), but verify against the application server configuration.
- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure appropriate access controls are applied if joining with `res_users` to expose PII.
- **Soft Deletes:** This table tracks uninstallation events; it does not appear to implement soft-delete logic itself, but rather logs the state of the uninstallation process.
- **Data Integrity:** As a staging table, this may contain transient data or intermediate states from the uninstallation wizard; ensure filtering for relevant records if performing analytical counts.