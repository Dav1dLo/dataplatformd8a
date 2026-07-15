# account_tax_sale_order_discount_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular accounting/sales system. The naming convention `_rel` is characteristic of Odoo's many-to-many relationship tables, which link core entities like sales orders, discounts, and tax configurations.

## Functional process 
This table supports the tax calculation and discount application process within the order-to-cash pipeline. It acts as a bridge to associate specific tax rules or rates with discount line items applied to sales orders, ensuring that tax liabilities are correctly calculated based on the net impact of discounts.

## Description
One row in this table represents a single association between a specific sales order discount and an account tax record. It serves as a raw, junction-table copy from the source system to maintain referential integrity for many-to-many relationships in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_discount_id | INTEGER | false | Foreign key to the sales order discount entity | Represents the specific discount instance applied to an order. |
| account_tax_id | INTEGER | false | Foreign key to the account tax entity | Represents the tax rule or rate applied to the discount. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both `sale_order_discount_id` and `account_tax_id`.
- **Foreign keys (inferred):** 
    - `sale_order_discount_id` → `sale_order_discount.id` (guess: links to the discount definition table).
    - `account_tax_id` → `account_tax.id` (guess: links to the tax configuration table).
- **Natural keys (inferred):** The combination of `(sale_order_discount_id, account_tax_id)` is the natural business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect many-to-many cardinality.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` fields.
- Ensure inner joins are used when querying to avoid orphaned records if the source system performs hard deletes on parent entities.