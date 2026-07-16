# mrp_routing_workcenter_product_template_attribute_value_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `mrp_routing_workcenter_..._rel` is characteristic of Odoo's ORM, which automatically generates join tables for many-to-many relationships between manufacturing routing workcenters and product attribute values.

## Functional process 
This table supports the manufacturing configuration process, specifically linking specific product attribute values (such as size, color, or material) to workcenters within a manufacturing routing. This allows the system to determine which workcenters are required based on the specific configuration of a product being manufactured.

## Description
One row represents a single association between a manufacturing routing workcenter and a specific product template attribute value. It acts as a bridge table in a many-to-many relationship, enabling the mapping of product-specific configurations to the production resources required to process them. As a staging table, it provides a raw, normalized view of these associations as they exist in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_routing_workcenter_id | INTEGER | false | Foreign key to the manufacturing routing workcenter. | Links to the workcenter definition. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product template attribute value. | Identifies the specific product configuration attribute. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both columns `(mrp_routing_workcenter_id, product_template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `mrp_routing_workcenter_id` → `mrp_routing_workcenter.id`: This column references the primary key of the workcenter routing table.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: This column references the primary key of the product attribute values table.
- **Natural keys (inferred):** The combination of `(mrp_routing_workcenter_id, product_template_attribute_value_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit or timestamp information available in this table to track when these associations were created or modified.
- Ensure that joins to the parent tables handle potential orphans if the source system's referential integrity is not strictly enforced.
- As this is a staging table, assume no data has been filtered or transformed; it reflects the raw state of the Odoo many-to-many relationship table.