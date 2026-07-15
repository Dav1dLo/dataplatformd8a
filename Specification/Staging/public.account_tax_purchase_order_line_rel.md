# account_tax_purchase_order_line_rel

## Source system
This table likely originates from an ERP or accounting system (e.g., Odoo or a similar modular business suite), given the naming convention `account_tax_..._rel` which typically denotes a join table managing many-to-many relationships between tax configurations and purchase order line items.

## Functional process 
This table supports the procurement and tax calculation process. It acts as a bridge to associate specific tax rules or rates with individual line items on a purchase order, ensuring that the correct tax amounts are applied during the financial reconciliation of procurement activities.

## Description
One row represents a single association between a purchase order line item and a specific tax record. It serves as a raw landing copy of a relational mapping table, facilitating the resolution of many-to-many relationships between tax entities and procurement line items in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| purchase_order_line_id | INTEGER | false | Foreign key to the purchase order line item | Links to the primary purchase order line table. |
| account_tax_id | INTEGER | false | Foreign key to the tax configuration record | Identifies the specific tax rule applied to the line. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of `(purchase_order_line_id, account_tax_id)`.
- **Foreign keys (inferred):** 
    - `purchase_order_line_id` → `purchase_order_line.id` (guess: standard naming convention for line item references).
    - `account_tax_id` → `account_tax.id` (guess: standard naming convention for tax master data).
- **Natural keys (inferred):** The combination of `purchase_order_line_id` and `account_tax_id` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; expect multiple rows per `purchase_order_line_id` if a single line item is subject to multiple taxes.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure inner joins are used when resolving these IDs to parent tables to avoid orphaned records if the source system does not enforce strict referential integrity.