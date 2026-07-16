# sale_order_template_line

## Source system
This table originates from Odoo ERP. The naming convention (`sale_order_template_line`), the presence of Odoo-specific audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of `JSONB` for translatable fields like `name` are characteristic of the Odoo PostgreSQL schema.

## Functional process 
This table supports the "Quote/Template Management" process. It stores the individual line items associated with predefined sales order templates, allowing users to quickly populate sales orders with standard sets of products, quantities, and descriptions.

## Description
One row represents a single line item within a sales order template, defining the product, quantity, and unit of measure associated with that template. This is a raw landing table in the staging layer, representing a direct extract of the Odoo `sale_order_template_line` model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| sale_order_template_id | INTEGER | false | Foreign key to the parent template | Links to `sale_order_template`. |
| sequence | INTEGER | true | Display order index | Used to sort lines in the UI. |
| company_id | INTEGER | true | Owning company ID | Multi-company support. |
| product_id | INTEGER | true | Product identifier | Links to `product_product`. |
| product_uom_id | INTEGER | true | Unit of measure identifier | Links to `uom_uom`. |
| create_uid | INTEGER | true | Creator user ID | Links to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res_users`. |
| display_type | VARCHAR | true | Line type classification | e.g., 'line_section' or 'line_note'. |
| name | JSONB | true | Product description | Multilingual text stored as JSON. |
| product_uom_qty | NUMERIC | false | Quantity of the product | Unit quantity. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sale_order_template_id` → `sale_order_template.id` (Parent template relationship)
    - `product_id` → `product_product.id` (Product reference)
    - `product_uom_id` → `uom_uom.id` (Unit of measure reference)
    - `company_id` → `res_company.id` (Company reference)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII/Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may link to employee names in other tables.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** Odoo typically does not use soft-delete flags; records are usually physically deleted from the database.
- **JSONB:** The `name` column contains JSON data; downstream consumers will need to use `->>` or `->` operators to extract specific language strings.
- **Data Integrity:** As a staging table, this may contain orphaned records if the parent `sale_order_template` was deleted.