# mrp_bom_line_product_template_attribute_value_rel

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `mrp_bom_line` (Manufacturing Resource Planning Bill of Materials line) and the `_rel` suffix, which is the standard pattern for many-to-many join tables in the Odoo ORM.

## Functional process 
This table supports the manufacturing configuration process by linking specific Bill of Materials (BOM) lines to the specific product attribute values (e.g., color, size, or material) that define a variant. It ensures that when a product is manufactured, the correct components are selected based on the specific attributes chosen for that product configuration.

## Description
One row in this table represents a single association between a Bill of Materials line item and a specific product template attribute value. It serves as a raw, junction-table copy from the source system, facilitating the many-to-many relationship required to resolve product variants within the manufacturing module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_bom_line_id | INTEGER | false | Foreign key to the BOM line | Links to the parent manufacturing component definition. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the attribute value | Identifies the specific variant attribute applied to this BOM line. |

## Keys

- **Primary key (inferred):** The combination of `(mrp_bom_line_id, product_template_attribute_value_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `mrp_bom_line_id` → `mrp_bom_line.id` (Inferred from Odoo naming conventions).
    - `product_template_attribute_value_id` → `product_template_attribute_value.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a pure junction table; it contains no descriptive data, only relationship identifiers.
- There are no timestamps or audit columns present in this table; incremental loading must rely on upstream source system logs or full table refreshes.
- As a staging table, this data is expected to be joined with the corresponding `mrp_bom_line` and `product_template_attribute_value` tables to provide meaningful business context.