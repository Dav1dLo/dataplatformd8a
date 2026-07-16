# product_combo_product_template_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular e-commerce/inventory management system. The naming convention `_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link product templates to product combinations (often used for bundles or configurable product variants).

## Functional process 
This table supports the product catalog and bundling process. It defines the many-to-many relationship between product templates (the base product definitions) and product combos (groups or sets of products), allowing the system to track which templates are included in which specific product combinations.

## Description
One row in this table represents a single association between a product template and a product combo. It serves as a raw junction table in the staging layer, capturing the link between base product definitions and their respective bundle or combo groupings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_id | INTEGER | false | Foreign key to the product template definition. | Represents the base product entity. |
| product_combo_id | INTEGER | false | Foreign key to the product combo definition. | Represents the bundle or combo entity. |

## Keys

- **Primary key (inferred):** The combination of `(product_template_id, product_combo_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `product_template_id