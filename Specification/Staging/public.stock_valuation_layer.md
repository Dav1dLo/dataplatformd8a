# stock_valuation_layer

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns like `categ_id`, `create_uid`, `write_uid`, and the specific pattern of linking inventory valuation layers to `stock_move_id` and `account_move_id`.

## Functional process 
This table supports the inventory valuation and accounting reconciliation process. It tracks the financial impact of stock movements, recording the quantity and cost of goods as they move through the warehouse, and links these physical movements to their corresponding general ledger entries.

## Description
One row in this table represents a single valuation layer entry for a specific stock movement, capturing the quantity, unit cost, and total value at the time of the transaction. It serves as a raw landed copy of the Odoo `stock.valuation.layer` model, providing the granular data required to calculate inventory value and reconcile stock movements with financial accounts.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | false | Identifier for the company | Links to the company entity. |
| product_id | INTEGER | false | Identifier for the product | Links to the product master. |
| categ_id | INTEGER | true | Identifier for the product category | Used for grouping valuation. |
| stock_valuation_layer_id | INTEGER | true | Parent valuation layer ID | Used for hierarchical valuation tracking. |
| stock_move_id | INTEGER | true | Identifier for the stock movement | Links to the physical inventory move. |
| account_move_id | INTEGER | true | Identifier for the accounting entry | Links to the GL journal entry. |
| account_move_line_id | INTEGER | true | Identifier for the GL line item | Specific line in the accounting entry. |
| lot_id | INTEGER | true | Identifier for the lot/serial number | Tracks specific inventory batches. |
| create_uid | INTEGER | true | User ID who created the record | Audit trail for record creation. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit trail for record modification. |
| description | VARCHAR | true | Descriptive text for the valuation | Often contains move references. |
| quantity | NUMERIC | true | Quantity of product moved | Units depend on product configuration. |
| unit_cost | NUMERIC | true | Cost per unit | Monetary value. |
| value | NUMERIC | true | Total value of the movement | Calculated as quantity * unit_cost. |
| remaining_qty | NUMERIC | true | Quantity remaining in stock | Snapshot of inventory balance. |
| remaining_value | NUMERIC | true | Value of remaining stock | Snapshot of inventory financial value. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| price_diff_value | DOUBLE PRECISION | true | Price difference value | Used for standard cost variance. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link)
    - `product_id` → `product_product.id` (Guess: standard Odoo product link)
    - `stock_move_id` → `stock_move.id` (Guess: links to physical inventory movement)
    - `account_move_id` → `account_move.id` (Guess: links to financial ledger entry)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains financial valuation data; ensure access is restricted to authorized finance/inventory personnel.
- **Timestamps:** Assumed to be in UTC as per standard Odoo database configurations.
- **Data Integrity:** `remaining_qty` and `remaining_value` are snapshots at the time of the record; they may not reflect current real-time inventory levels.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically immutable once created in Odoo valuation layers.
- **Precision:** `NUMERIC` types do not have defined scale/precision in the metadata; downstream consumers should handle potential rounding differences when aggregating.