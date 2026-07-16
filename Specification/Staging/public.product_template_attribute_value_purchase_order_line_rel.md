# product_template_attribute_value_purchase_order_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific association between purchase order lines and product template attribute values is characteristic of Odoo's many-to-many relationship tables, which are used to link configuration attributes to specific procurement line items.

## Functional process 
This table supports the procurement and inventory management process. It tracks the specific attribute values (e.g., color, size, or material) selected for products within a purchase order line, ensuring that the correct product variant is ordered from the supplier.

## Description
One row in this table represents a single association between a purchase order line and a specific product template attribute value. It acts as a join table in the staging layer, providing a raw, normalized link between procurement records and product configuration details.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| purchase_order_line_id | INTEGER | false | Foreign key to the purchase order line | Links to the specific line item in a purchase order. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value | Identifies the specific attribute value applied to the product. |

## Keys

- **Primary key (inferred):** The composite of `(purchase_order_line_id, product_template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `purchase_order_line_id` → `purchase_order_line.id`: Links to the source purchase order line record.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: Links to the definition of the product attribute value.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes of its own.
- There are no timestamps or audit columns present; incremental loading logic must rely on the upstream source system's change tracking or full-table replacement.
- Ensure that joins to this table are performed on both columns to maintain the integrity of the many-to-many relationship.