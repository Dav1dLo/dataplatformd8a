# product_template_attribute_value_sale_order_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific association between `sale_order_line` and `product_template_attribute_value` is characteristic of Odoo's many-to-many relationship join tables used to track product variants and attribute selections on sales orders.

## Functional process 
This table supports the sales order configuration process. It maps specific product attribute values (e.g., "Size: Large", "Color: Blue") to individual lines within a sales order, ensuring that the exact configuration of a product variant is persisted alongside the order line item.

## Description
Each row represents a single association between a sales order line and a specific product attribute value. This is a junction table used to resolve a many-to-many relationship, allowing a single order line to reference multiple attribute values that define the product variant. It serves as a raw landed copy of the Odoo relational link table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_line_id | INTEGER | false | Foreign key to the sales order line | Links to the primary order line record. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value | Identifies the specific attribute choice made for the product. |

## Keys

- **Primary key (inferred):** The combination of `sale_order_line_id` and `product_template_attribute_value_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `sale_order_line_id` → `sale_order_line.id`: This column references the parent sales order line entity.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: This column references the specific attribute value definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no surrogate primary key; queries should use the composite key for joins or deduplication.
- As a staging table, this reflects the raw state of the source database; expect no soft-delete flags or audit timestamps unless they were explicitly part of the Odoo source schema.
- Ensure joins to the parent tables handle the potential for missing records if the source system has experienced referential integrity issues.