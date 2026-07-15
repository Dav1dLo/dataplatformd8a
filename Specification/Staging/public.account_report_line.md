# account_report_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for localized names, and the specific structure of the `account_report_line` entity which is a core component of the Odoo Financial Reporting engine.

## Functional process 
This table supports the Financial Reporting configuration process. It defines the hierarchical structure, grouping logic, and display properties (such as foldability and page breaks) for custom financial reports like Balance Sheets or Profit & Loss statements within the accounting module.

## Description
One row in this table represents a single line item or node within a financial report hierarchy. It acts as a raw landed copy of the report configuration, defining how data should be aggregated and presented to the end user.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| report_id | INTEGER | false | Foreign key to the parent report | Links to the report definition. |
| hierarchy_level | INTEGER | false | Depth in the report tree | Used for indentation/nesting logic. |
| parent_id | INTEGER | true | Self-referencing parent ID | Defines the tree structure. |
| sequence | INTEGER | true | Display order index | Determines vertical position. |
| action_id | INTEGER | true | Associated action or drill-down | Likely links to a specific report action. |
| create_uid | INTEGER | true | Creator user ID | Reference to the system user. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the system user. |
| groupby | INTEGER | true | Grouping criteria | Logic for data aggregation. |
| user_groupby | VARCHAR | true | User-defined grouping label | Custom label for the group. |
| code | VARCHAR | true | Internal report code | Used for formula references. |
| horizontal_split_side | VARCHAR | true | Layout positioning | Defines split-view behavior. |
| name | JSONB | false | Display name | Multilingual JSON object. |
| foldable | BOOLEAN | true | UI toggle flag | Indicates if the row can be collapsed. |
| print_on_new_page | BOOLEAN | true | Formatting flag | Forces page break in PDF exports. |
| hide_if_zero | BOOLEAN | true | Visibility logic | Hides row if calculated value is 0. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `report_id` → `account_report.id` (Inferred from Odoo schema patterns).
    - `parent_id` → `account_report_line.id` (Self-referencing hierarchy).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - None. This table relies on the surrogate `id` for identity within the report hierarchy.

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified; contains configuration and metadata.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.
- **JSONB:** The `name` column is `JSONB`. Downstream SQL queries will require `->>` or `->` operators to extract specific language strings (e.g., `name->>'en_US'`).
- **Hierarchy:** Queries traversing the tree structure will require Recursive Common Table Expressions (CTEs) due to the `parent_id` self-reference.