# account_report_column

## Source system
The table likely originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`, `JSONB` for multi-language fields) and the specific sequence-based primary key pattern are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the configuration of financial or analytical report layouts. It defines the specific columns that appear in custom reports, determining their display order, data types (e.g., monetary vs. percentage), and formatting logic (e.g., hiding zeros).

## Description
One row represents a single column definition within a specific report configuration. This is a raw landing table in the staging layer, capturing the metadata required to render report structures. It serves as the source for downstream reporting engines to construct the tabular output of financial statements.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.account_report_column_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort columns in the report UI. |
| report_id | INTEGER | true | Foreign key to the parent report | Links this column to a specific report definition. |
| custom_audit_action_id | INTEGER | true | Audit/Action reference | Likely links to a custom action or audit log entry. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| expression_label | VARCHAR | false | Unique identifier for the expression | Used to map data values to this column. |
| figure_type | VARCHAR | false | Data type of the column | Defines how the figure is rendered (e.g., 'float', 'monetary'). |
| name | JSONB | false | Display name of the column | Multi-language support; contains localized labels. |
| sortable | BOOLEAN | true | Sortability flag | Indicates if the column can be sorted by the user. |
| blank_if_zero | BOOLEAN | true | Zero-suppression flag | If true, hides the value if it equals zero. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard practices. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC based on Odoo standard practices. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `report_id` → `account_report.id` (Guess: links to the parent report definition).
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** 
    - `(report_id, expression_label)`: Likely the business-level unique constraint for a column within a specific report.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timezones:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage.
- **Data Format:** The `name` column is `JSONB`; ensure your SQL environment supports JSON path extraction (e.g., `name->>'en_US'`) for human-readable labels.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.