# report_stock_quantity

## Source system
This table originates from an Odoo ERP system. The naming convention `report_stock_quantity` and the presence of columns like `product_tmpl_id`, `product_id`, and `warehouse_id` are characteristic of Odoo's stock reporting models, which track inventory levels across various locations and product templates.

## Functional process 
This table supports the inventory management and supply chain reporting process. It captures snapshots or aggregated movements of stock quantities, allowing the business to track inventory availability across different warehouses and companies over time.

## Description
One row in this table represents the stock quantity of a specific product at a given date, filtered by its state and location (warehouse). It serves as a raw landing copy of the Odoo stock report model, providing a point-in-time view of inventory levels for analytical downstream processing.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely an internal Odoo record ID. |
| product_id | INTEGER | true | Product variant identifier | Foreign key to the product variant table. |
| product_tmpl_id | INTEGER | true | Product template identifier | Foreign key to the base product definition. |
| state | TEXT | true | Inventory status | Represents the state of the stock (e.g., 'confirmed', 'draft'). |
| date | DATE | true | Transaction or snapshot date | The date associated with the stock quantity record. |
| product_qty | NUMERIC | true | Quantity of product | The numerical stock count; unit depends on product configuration. |
| company_id | INTEGER | true | Company identifier | Foreign key to the company owning the stock. |
| warehouse_id | INTEGER | true | Warehouse identifier | Foreign key to the warehouse location. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Guess: links to the specific product variant).
    - `product_tmpl_id` → `product_template.id` (Guess: links to the master product template).
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link).
    - `warehouse_id` → `stock_warehouse.id` (Guess: links to the physical warehouse location).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Data Quality:** The `id` column is marked as nullable, which is unusual for a primary key; verify if this table contains records without unique identifiers.
- **Precision:** `product_qty` is defined as `NUMERIC` without scale/precision; check for potential rounding or decimal issues in downstream calculations.
- **Timestamps:** The `date` column is a `DATE` type; it does not contain time-of-day information.
- **Soft Deletes:** Odoo tables typically do not use soft-delete flags; assume this is a snapshot or transaction log where records are either current or historical.
- **Sensitivity:** This table contains operational inventory data; no PII is present, but it may be commercially sensitive.