# account_report

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for localized names, which are standard patterns in Odoo's ORM layer.

## Functional process 
This table supports the financial reporting configuration process. It defines the parameters, filters, and display logic for various accounting reports (e.g., Balance Sheet, Profit & Loss) available within the accounting module, allowing users to customize how financial data is aggregated and presented.

## Description
One row in this table represents a single configuration profile for an accounting report, defining its display settings, available filters, and structural behavior. It serves as a raw landed copy of the report configuration metadata from the Odoo staging environment.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order index | Used for sorting reports in UI. |
| root_report_id | INTEGER | true | Parent report reference | Links to a base report definition. |
| country_id | INTEGER | true | Country identifier | Restricts report availability by region. |
| load_more_limit | INTEGER | true | Pagination limit | Max records to load in report view. |
| prefix_groups_threshold | INTEGER | true | Grouping threshold | Logic for collapsing account prefixes. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to res_users. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to res_users. |
| chart_template | VARCHAR | true | Chart of accounts template | Defines the accounting structure. |
| availability_condition | VARCHAR | true | Visibility logic | Condition string for report access. |
| integer_rounding | VARCHAR | true | Rounding method | Precision setting for report values. |
| default_opening_date_filter | VARCHAR | true | Default date range | Initial filter state for the report. |
| currency_translation | VARCHAR | true | Currency conversion method | Logic for multi-currency reporting. |
| filter_multi_company | VARCHAR | true | Multi-company filter config | Configuration for company scope. |
| filter_hide_0_lines | VARCHAR | true | Zero-line suppression | Toggle for hiding empty accounts. |
| filter_hierarchy | VARCHAR | true | Hierarchy display mode | Configuration for tree-view display. |
| filter_account_type | VARCHAR | true | Account type filter | Scope of accounts to include. |
| name | JSONB | false | Report display name | Multi-language label storage. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if report is enabled. |
| use_sections | BOOLEAN | true | Section usage toggle | Enables grouping by sections. |
| only_tax_exigible | BOOLEAN | true | Tax exigibility filter | Limits to tax-relevant entries. |
| search_bar | BOOLEAN | true | Search bar visibility | UI toggle for search functionality. |
| filter_date_range | BOOLEAN | true | Date range filter enabled | UI toggle for date picker. |
| filter_show_draft | BOOLEAN | true | Draft entries filter enabled | UI toggle for draft visibility. |
| filter_unreconciled | BOOLEAN | true | Unreconciled filter enabled | UI toggle for reconciliation status. |
| filter_unfold_all | BOOLEAN | true | Unfold all enabled | UI toggle for expansion state. |
| filter_period_comparison | BOOLEAN | true | Period comparison enabled | UI toggle for time-series analysis. |
| filter_growth_comparison | BOOLEAN | true | Growth comparison enabled | UI toggle for variance analysis. |
| filter_journals | BOOLEAN | true | Journal filter enabled | UI toggle for journal selection. |
| filter_analytic | BOOLEAN | true | Analytic filter enabled | UI toggle for analytic accounting. |
| filter_partner | BOOLEAN | true | Partner filter enabled | UI toggle for partner grouping. |
| filter_fiscal_position | BOOLEAN | true | Fiscal position filter enabled | UI toggle for tax mapping. |
| filter_aml_ir_filters | BOOLEAN | true | AML filter enabled | UI toggle for ledger filters. |
| filter_budgets | BOOLEAN | true | Budget filter enabled | UI toggle for budget tracking. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column)
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column)
    - `root_report_id` → `account_report.id` (Guess: self-referencing hierarchy)
    - `country_id` → `res_country.id` (Guess: standard Odoo country reference)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC as per standard Odoo/PostgreSQL practices.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` to retrieve current configurations.
- **JSONB:** The `name` column contains localized strings; use `name->>'en_US'` or similar syntax to extract specific languages.
- **Audit Columns:** `create_date` and `write_date` are maintained by the application layer and may not reflect database-level triggers.