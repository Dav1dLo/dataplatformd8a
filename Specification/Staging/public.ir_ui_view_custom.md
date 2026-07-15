# ir_ui_view_custom

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_ui_view_custom` (Internal Resource User Interface View Custom) and the presence of `create_uid`, `write_uid`, and `arch` (architecture) columns are characteristic of Odoo's metadata-driven view customization engine.

## Functional process 
This table supports the UI customization and personalization process within the ERP. It stores user-specific overrides or modifications to the base XML architecture of views, allowing the system to render custom layouts or field visibility settings for specific users or references without altering the core application code.

## Description
One row in this table represents a single custom modification applied to a specific UI view component. It acts as a raw landing copy of the customization record, capturing the XML architecture (`arch`) and the audit trail of who created or modified the view override.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| ref_id | INTEGER | false | Reference to the base view | Links to the original view being customized. |
| user_id | INTEGER | false | User identifier | The user for whom this customization is applied. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this customization. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this customization. |
| arch | TEXT | false | XML architecture | The custom XML definition for the view. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Likely links to the user account table).
    - `create_uid` → `res_users.id` (Likely links to the user account table).
    - `write_uid` → `res_users.id` (Likely links to the user account table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `arch` column may contain field-level visibility logic or references to sensitive business objects; ensure access is restricted.
- **Timestamps:** Timestamps are assumed to be in the server's local time (standard Odoo behavior), which may require conversion to UTC for cross-platform analytics.
- **Data Integrity:** The `arch` column contains raw XML strings; downstream consumers will need an XML parser to extract specific UI attributes or field mappings.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely physically deleted if removed from the source.