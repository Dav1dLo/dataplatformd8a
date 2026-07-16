# product_variant_combination

## Source system
The table likely originates from an Odoo ERP or a similar modular e-commerce/inventory management system. The naming convention `product_template_attribute_value_id` is highly characteristic of Odoo's product variant architecture, where combinations of attributes (like color and size) define specific product variants.

## Functional process 
This table supports the product catalog and inventory management process. It acts as a bridge table (associative entity) that maps specific product variants to the attribute values that define them, enabling the system to track which combinations of attributes constitute a unique sellable product.

## Description
One row in this table represents a single association between a product variant and a specific attribute value (e.g., linking a "Large" size attribute to a specific T-shirt variant). It serves as a raw landed copy of the relational mapping table used to resolve product variant configurations within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_product_id | INTEGER | false | Foreign key to the product variant | Represents the specific variant being configured. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the attribute value | Represents the specific attribute option (e.g., 'Red', 'XL'). |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both `product_product_id` and `product_template_attribute_value_id`.
- **Foreign keys (inferred):** 
    - `product_product_id` → `product_product.id` (Guess: links to the master product variant table).
    - `product_template_attribute_value_id` → `product_template_attribute_value.id` (Guess: links to the definition of the attribute value).
- **Natural keys (inferred):** The combination of `product_product_id` and `product_template_attribute_value_id` acts as the business key for this mapping.

## Caveats for downstream consumers

- This table is a junction table; expect many-to-many relationships between products and attribute values.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` fields.
- The table contains only integer identifiers; all descriptive metadata (names, codes) must be joined from the parent tables.
- Assumes standard relational integrity; verify if the source system performs hard or soft deletes on these associations.