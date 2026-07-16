# product_tag_product_template_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `product_template_id` and `product_tag_id` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link product templates to their associated tags.

## Functional process 
This table supports the product categorization and tagging process within the inventory or e-commerce module. It enables the many-to-many relationship between product templates (the base product definition) and product tags (used for filtering, reporting, or website navigation).

## Description
One row in this table represents a single association between a specific product template and a specific product tag. It serves as a raw, junction-table copy from the source system, maintaining the link between product definitions and their assigned metadata tags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_id | INTEGER | false | Foreign key to the product template | Links to the primary product definition. |
| product_tag_id | INTEGER | false | Foreign key to the product tag | Links to the specific tag assigned to the product. |

## Keys

- **Primary key (inferred):** The combination of `(product_template_id, product_tag_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `product_template_id` → `product_template.id`: This column references the master product template record.
    - `product_tag_id` → `product_tag.id`: This column references the master product tag definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only the relationship identifiers.
- There is no surrogate primary key (e.g., an `id` column), so queries should rely on the composite key for uniqueness.
- Ensure that joins to the parent tables (`product_template` and `product_tag`) handle potential orphans if referential integrity is not strictly enforced in the staging layer.