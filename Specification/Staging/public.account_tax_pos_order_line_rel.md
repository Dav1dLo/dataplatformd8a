# account_tax_pos_order_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `account_tax_pos_order_line_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link tax definitions (`account_tax`) to specific line items within a Point of Sale order (`pos_order_line`).

## Functional process 
This table supports the tax calculation and financial reporting process for retail transactions. It acts as a join table to associate multiple tax rates (e.g., VAT, state tax, local tax) with individual line items in a Point of Sale order, ensuring that the correct tax amounts are applied to the gross transaction value.

## Description
One row represents a single association between a specific Point of Sale order line and a tax record. It is a raw landing copy of a junction table used to resolve a many-to-many relationship between order lines and tax entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_order_line_id | INTEGER | false | Foreign key to the POS order line | Links to the specific item sold in a transaction. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Identifies the tax rule applied to the line item. |

## Keys

- **Primary key (inferred):** The combination of `pos_order_line_id` and `account_tax_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `pos_order_line_id` → `pos_order_line.id`: This column references the primary key of the POS order line table.
    - `account_tax_id` → `account_tax.id`: This column references the primary key of the tax configuration table.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no business data other than the relationship identifiers.
- There are no timestamps or audit columns present in this table; rely on the parent `pos_order_line` or `pos_order` tables for temporal context.
- Ensure that queries joining this table handle the composite key correctly to avoid fan-out issues when calculating total tax per order line.