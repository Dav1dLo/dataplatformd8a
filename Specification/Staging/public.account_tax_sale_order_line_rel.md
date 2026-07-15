# account_tax_sale_order_line_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular accounting/ERP system. The naming convention `account_tax_..._rel` is characteristic of Odoo's many-to-many relationship tables, which link tax definitions to specific order line items.

## Functional process 
This table supports the tax calculation process within the order-to-cash pipeline. It acts as a bridge to associate multiple tax rates or tax rules with individual line items on a sales order, ensuring that correct tax amounts are applied during invoicing.

## Description
One row represents a single association between a specific sales order line and a tax record. It is a raw landing table used to resolve the many-to-many relationship between order line items and tax definitions in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_line_id | INTEGER | false | Foreign key to the sales order line | Links to the primary order line entity. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Links to the specific tax rule or rate. |

## Keys

- **Primary key (inferred):** The combination of `sale_order_line_id` and `account_tax_id` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `sale_order_line_id` → `sale_order_line.id` (Guess: standard naming convention for Odoo-style relational tables).
    - `account_tax_id` → `account_tax.id` (Guess: standard naming convention for Odoo-style relational tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; queries should expect multiple rows per `sale_order_line_id` if a line item is subject to multiple taxes.
- There are no timestamps or audit columns; incremental loading logic cannot rely on `updated_at` fields.
- Ensure joins to parent tables handle the potential for missing records if the source system performs hard deletes on parent entities.