# mrp_routing_workcenter_product_template_attribute_value_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `mrp_routing_workcenter_..._rel` is characteristic of Odoo's ORM, which uses `_rel` suffixes for many-to-many join tables created automatically to link manufacturing routing workcenters with product template attribute values.

## Functional process 
This table supports the manufacturing configuration process, specifically linking workcenters in a routing sequence to specific product attribute values. This allows the manufacturing module to dynamically determine which workcenters are required based on the specific configuration (attributes) of a product being manufactured.

## Description
This table acts as a junction entity representing a many-to-many relationship between manufacturing routing workcenters and product template attribute values. Each row represents a single association between a specific workcenter and a specific product attribute value, enabling conditional routing logic in the production pipeline. It serves as a raw landing copy of the Odoo relational mapping table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_routing_workcenter_id | INTEGER | false | Foreign key to the workcenter routing record | Links to the manufacturing routing workcenter definition. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value | Identifies the specific product variant attribute involved. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both columns `(mrp_routing_workcenter_id, product_template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `mrp_routing_workcenter_id` → `mrp_routing_workcenter.id`: This column references the primary key of the routing workcenter table.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: This column references the primary key of the product attribute value table.
- **Natural keys (inferred):** The combination of `(mrp_routing_workcenter_id, product_template_attribute_value_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; this table reflects the current state of the relationship as defined in the source ERP.
- Ensure that joins to this table are performed on both columns to maintain the integrity of the many-to-many relationship.