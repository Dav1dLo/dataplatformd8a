# pos_daily_sales_reports_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (`_wizard`, `create_uid`, `write_uid`, `pos_session_id`) is characteristic of Odoo's transient models, which are used to manage temporary state for UI-driven workflows or report generation wizards.

## Functional process 
This table supports the Point of Sale (POS) reporting workflow. It acts as a transient configuration store for generating daily sales summaries, allowing users to toggle specific reporting parameters (such as employee-level breakdowns) before triggering the final report generation process.

## Description
One row in this table represents a single configuration instance for a POS daily sales report generation task. It serves as a raw landed copy of the wizard's state, capturing the session context and user-defined preferences at the time the report was requested.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `pos_daily_sales_reports_wizard_id_seq`. |
| pos_session_id | INTEGER | false | Foreign key to the POS session | Identifies the specific session being reported on. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the wizard settings. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC; audit timestamp for the wizard instance. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC; audit timestamp for the wizard instance. |
| add_report_per_employee | BOOLEAN | true | Toggle for employee breakdown | If true, the generated report includes per-employee metrics. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `pos_session_id` → `pos_session.id` (Likely target based on Odoo standard naming conventions).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Transient Data:** As a "wizard" table, this data is often temporary and may be purged or overwritten frequently by the source system.
- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against user master tables to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement soft-delete flags; records represent transient state rather than persistent business entities.