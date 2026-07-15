# account_analytic_line

## Source system
This table originates from Odoo ERP, as evidenced by the characteristic naming conventions such as `account_analytic_line`, the presence of `create_uid`/`write_uid` audit columns, and the `x_` prefix on custom fields (e.g., `x_plan2_id`).

## Functional process 
This table supports the analytical accounting and project costing process. It records individual financial or operational entries (analytic lines) that track costs, revenues, or quantities against specific analytic accounts, often linked to projects, sales orders (`so_line`), or general ledger movements (`move_line_id`).

## Description
One row represents a single analytical entry, which acts as a granular record of a financial or operational transaction associated with an analytic account. It serves as a raw landing copy of the Odoo `account.analytic.line` model, capturing both monetary amounts and quantitative units for cost accounting purposes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| account_id | INTEGER | true | Analytic account identifier | Foreign key to `account_analytic_account`. |
| product_uom_id | INTEGER | true | Unit of measure identifier | References `uom_uom`. |
| partner_id | INTEGER | true | Customer/Vendor identifier | References `res_partner`. |
| user_id | INTEGER | true | Responsible user identifier | References `res_users`. |
| company_id | INTEGER | false | Company identifier | References `res_company`. |
| currency_id | INTEGER | true | Currency identifier | References `res_currency`. |
| create_uid | INTEGER | true | Creator user identifier | References `res_users`. |
| write_uid | INTEGER | true | Last modifier user identifier | References `res_users`. |
| name | VARCHAR | false | Description of the line | Free-text label for the entry. |
| category | VARCHAR | true | Category classification | Used for grouping analytic lines. |
| date | DATE | false | Transaction date | The business date of the entry. |
| amount | NUMERIC | false | Monetary amount | Financial value of the line. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| unit_amount | DOUBLE PRECISION | true | Quantity | Used for non-monetary tracking (e.g., hours). |
| x_plan2_id | INTEGER | true | Custom plan 2 identifier | Custom field; source precision unknown. |
| x_plan3_id | INTEGER | true | Custom plan 3 identifier | Custom field; source precision unknown. |
| product_id | INTEGER | true | Product identifier | References `product_product`. |
| general_account_id | INTEGER | true | General ledger account identifier | References `account_account`. |
| journal_id | INTEGER | true | Analytic journal identifier | References `account_analytic_journal`. |
| move_line_id | INTEGER | true | GL move line identifier | References `account_move_line`. |
| code | VARCHAR(8) | true | Short code | Often used for internal mapping. |
| ref | VARCHAR | true | Reference string | External reference or document number. |
| so_line | INTEGER | true | Sales order line identifier | References `sale_order_line`. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account_analytic_account.id` (Standard Odoo analytic link)
    - `partner_id` → `res_partner.id` (Standard Odoo partner link)
    - `product_id` → `product_product.id` (Standard Odoo product link)
    - `move_line_id` → `account_move_line.id` (Links analytic entry to GL entry)
    - `so_line` → `sale_order_line.id` (Links to sales order line)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** Odoo typically performs hard deletes on this model; there is no `active` flag present in this schema.
- **Precision:** The `amount` column is `NUMERIC` (precision not specified in metadata, usually `16,2` in Odoo); ensure downstream casting handles potential rounding.
- **Custom Fields:** `x_plan2_id` and `x_plan3_id` are custom fields; their existence and usage may vary based on specific Odoo module configurations.