# product_attribute_value_product_template_attribute_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific association of `product_attribute_value` and `product_template_attribute_line` is characteristic of Odoo's many-to-many relationship join tables used to link product attribute values to specific template attribute lines.

## Functional process 
This table supports the Product Catalog management process. It defines the specific attribute values (e.g., "Red", "Large") that are available for selection within a specific product template's attribute line (e.g., "Color", "Size"), enabling the configuration of product variants.

## Description
One row represents a single association between a specific product attribute value and a product template attribute line. This is a raw landing of a join table, serving as the bridge to resolve many-to-many relationships between attribute definitions and their available values in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_attribute_value_id | INTEGER | false | Foreign key to the product attribute value definition. | Links to the specific value (e.g., 'Blue'). |
| product_template_attribute_line_id | INTEGER | false | Foreign key to the product template attribute line. | Links to the attribute category (e.g., 'Color'). |

## Keys

- **Primary key (inferred):** The combination of `product_attribute_value_id` and `product_template_attribute_line_id`.
- **Foreign keys (inferred):** 
    - `product_attribute_value_id` → `product_attribute_value.id`: This column references the master list of available attribute values.
    - `product_template_attribute_line_id` → `product_template_attribute_line.id`: This column references the specific attribute lines defined for product templates.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume this represents the current state of relationships as exported from the source.
- Ensure joins to parent tables are handled as inner joins if you require only valid, existing associations.