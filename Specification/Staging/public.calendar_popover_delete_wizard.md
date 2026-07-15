# calendar_popover_delete_wizard

## Source system
This table originates from Odoo (OpenERP), an open-source ERP system. The naming convention (using `_uid`, `_date`, and `_seq` sequences) and the specific structure of wizard-related tables are characteristic of Odoo's ORM-generated staging tables used to manage transient UI state or temporary data processing.

## Functional process 
This table supports the "Calendar Event Deletion" process. It acts as a transient wizard state holder, capturing the intent and metadata when a user initiates the deletion of a calendar record through the Odoo web interface.

## Description
One row in this table represents a single instance of a deletion wizard session triggered by a user. It serves as a staging entity to track the lifecycle of a deletion request, including who created the request, who modified it, and the associated record ID targeted for removal.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `calendar_popover_delete_wizard_id_seq`. |
| record | INTEGER | true | Target record identifier | The ID of the calendar event being processed for deletion. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the wizard state. |
| delete | VARCHAR | true | Deletion flag or criteria | Likely stores a boolean string or specific deletion scope/reason. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the wizard session was initialized. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the wizard session was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creation).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modification).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are typically stored in UTC by Odoo; verify against the application server configuration.
- **Data Volatility:** As a "wizard" table, this data is often transient and may be truncated or cleared by the application after the deletion process completes.
- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against `res_users` to resolve names; ensure access controls are applied to user-identifying information.
- **Soft Deletes:** This table tracks the *process* of deletion, not the calendar events themselves; do not treat this as a source of truth for the existence of calendar records.