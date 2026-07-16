# spreadsheet_dashboard_group

## Source system
The table likely originates from Odoo (formerly OpenERP), as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized fields (common in Odoo's multi-language support).

## Functional process 
This table supports the organization and grouping of dashboard elements within a spreadsheet or reporting module. It manages the structural hierarchy or display order of dashboard groups, likely used to categorize widgets or data views for end-users.

## Description
Each row represents a single dashboard group entity within the spreadsheet application. This is a raw landed staging table containing the primary configuration and audit metadata for these groups. It serves as the base layer for downstream reporting on dashboard structure and user-defined groupings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `spreadsheet_dashboard_group_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort groups in the UI. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the group. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the group. |
| name | JSONB | false | Group name | Likely contains localized strings (e.g., `{"en_US": "Sales", "fr_FR": "Ventes"}`). |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `name` column contains user-defined text which may contain sensitive information.
- **Timestamps:** Timestamps are stored in the application's local time or UTC; verify against the Odoo server configuration.
- **Data Format:** The `name` column is `JSONB`; downstream consumers must parse this to extract the relevant language string.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are active unless otherwise specified by business logic.