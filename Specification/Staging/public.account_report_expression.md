# account_report_expression

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit columns for Odoo's ORM layer.

## Functional process 
This table supports the financial reporting engine, specifically the configuration of dynamic report lines. It defines the mathematical expressions and logic (formulas) used to calculate specific values within custom financial reports, such as balance sheets or profit and loss statements.

## Description
One row represents a single calculation expression or rule assigned to a specific financial report line. It acts as a raw landed copy of the configuration metadata, defining how data should be aggregated or computed for display in the reporting module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_report_expression_id_seq`. |
| report_line_id | INTEGER | false | Foreign key to the parent report line | Links expression to a specific line item definition. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res.users`. |
| label | VARCHAR | false | Display label for the expression | Used as the header or identifier in reports. |
| engine | VARCHAR | false | Calculation engine type | Defines the logic processor (e.g., 'domain', 'tax'). |
| formula | VARCHAR | false | The mathematical or domain formula | The core logic string for the calculation. |
| subformula | VARCHAR | true | Secondary calculation logic | Optional refinement for the primary formula. |
| date_scope | VARCHAR | false | Temporal scope of the expression | Defines the period (e.g., 'to_date', 'from_date'). |
| figure_type | VARCHAR | true | Data type of the result | e.g., 'float', 'percentage', 'monetary'. |
| carryover_target | VARCHAR | true | Target for carryover values | Used for multi-period reporting logic. |
| green_on_positive | BOOLEAN | true | UI formatting flag | If true, renders positive values in green. |
| blank_if_zero | BOOLEAN | true | UI formatting flag | If true, hides the value if it equals zero. |
| auditable | BOOLEAN | true | Audit trail flag | Indicates if the expression result is drillable/auditable. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC timestamp of last update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `report_line_id` → `account_report_line.id` (Inferred from Odoo naming convention for parent-child relationships).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains no direct PII, but exposes internal business logic and financial reporting structures.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` or `active` flag; assume all rows are current unless otherwise specified by the source system's business logic.
- **Data Types:** `VARCHAR` lengths are not explicitly defined in the source metadata; downstream systems should handle variable-length strings appropriately.