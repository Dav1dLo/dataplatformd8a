# account_report_external_value

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `_id`, `_uid`, `create_date`, `write_date`) and the specific structure of linking report expressions to fiscal positions and companies are characteristic of Odoo's financial reporting and accounting modules.

## Functional process 
This table supports the financial reporting and tax compliance process. It stores external or manual overrides for specific report line expressions, allowing users to inject or adjust values (both numeric and text-based) into financial reports, such as VAT declarations or balance sheet adjustments, linked to specific fiscal positions and companies.

## Description
One row represents a single external value entry or manual override assigned to a specific financial report expression for a given company. It serves as a staging entity that captures supplemental data points required for report generation that are not derived directly from standard ledger entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| target_report_expression_id | INTEGER | false | Foreign key to report expression | Links to the specific report line logic. |
| company_id | INTEGER | false | Foreign key to company | The entity to which this value belongs. |
| foreign_vat_fiscal_position_id | INTEGER | true | Foreign key to fiscal position | Used for cross-border VAT reporting logic. |
| carryover_origin_report_line_id | INTEGER | true | Foreign key to origin report line | Tracks the source of carryover values. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Descriptive label | Human-readable name for the external value. |
| text_value | VARCHAR | true | Textual data override | Used if the report expression expects a string. |
| carryover_origin_expression_label | VARCHAR | true | Origin label | Label identifying the source expression. |
| date | DATE | false | Effective date | The accounting date for this value. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| value | DOUBLE PRECISION | true | Numeric value | The actual numeric amount for the report. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `target_report_expression_id` → `account_report_expression.id` (Inferred from Odoo naming patterns).
    - `company_id` → `res_company.id` (Standard Odoo multi-company link).
    - `foreign_vat_fiscal_position_id` → `account_fiscal_position.id` (Links to tax mapping rules).
    - `carryover_origin_report_line_id` → `account_report_line.id` (Links to source report structure).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) and potentially sensitive financial labels; ensure access is restricted.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Integrity:** The `value` column is `DOUBLE PRECISION`; ensure appropriate rounding is applied if used for financial reconciliation.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all records are active unless otherwise specified by business logic.