# product_attribute_product_template_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular e-commerce/inventory management system. The naming convention `_rel` is characteristic of Odoo's ORM, which automatically generates junction tables to manage many-to-many relationships between product attributes (e.g., color, size) and product templates (the base product definition).

## Functional process 
This table supports the product catalog management process by defining the association between product attributes and product templates. It enables the system to determine which configurable attributes are available for specific product templates, facilitating the generation of product variants.

## Description
One row in this table represents a single association between a specific product attribute and a product template. It serves as a raw, landing-layer junction table that resolves the many-to-many relationship between attributes and templates, ensuring that the product configuration engine can map available options to base products.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_attribute_id | INTEGER | false | Foreign key to the product attribute definition. | Links to the attribute master table. |
| product_template_id | INTEGER | false | Foreign key to the product template definition. | Links to the base product template table. |

## Keys

- **Primary key (inferred):** The composite of (`product_attribute_id`, `product_template_id`).
- **Foreign keys (inferred):** 
    - `product_attribute_id` → `product_attribute.id`: This column references the unique identifier of the attribute definition.
    - `product_template_id` → `product_template.id`: This column references the unique identifier of the base product template.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- Expect high cardinality and frequent joins against the `product_attribute` and `product_template` tables.
- There are no timestamps or audit columns present; incremental loading logic must rely on full-table snapshots or external metadata.
- Ensure that joins are performed on both columns to maintain referential integrity, as neither column is unique on its own.