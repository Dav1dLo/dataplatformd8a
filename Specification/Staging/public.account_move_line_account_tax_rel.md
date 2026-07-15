# account_move_line_account_tax_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `account_move_line_account_tax_rel` is a standard pattern used by Odoo to represent a many-to-many join table between accounting journal items (`account_move_line`) and tax definitions (`account_tax`).

## Functional process 
This table supports the financial accounting and tax reporting process. It maps specific journal line items to the tax rates or tax groups applied to them, ensuring that tax liabilities are correctly calculated and attributed to individual ledger entries during the posting of invoices or journal entries.

## Description
One row in this table represents a single association between an accounting journal line and a tax record. It acts as a link table to resolve the many-to-many relationship where a single journal line may be subject to multiple taxes, or a single tax definition may be applied across many journal lines. This is a raw landed copy of the Odoo relational mapping table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_line_id | INTEGER | false | Foreign key to the journal line | Links to the specific accounting entry line. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Links to the tax record applied to the line. |

## Keys

- **Primary key (inferred):** The composite key `(account_move_line_id,