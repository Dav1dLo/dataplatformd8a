# mrp_bom_byproduct_product_template_attribute_value_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `mrp_bom_byproduct_..._rel` is characteristic of Odoo's ORM, which generates join tables for many-to-many relationships between Manufacturing (MRP) Bill of Materials (BOM) byproducts and product template attribute values.

## Functional process 
This table supports the Manufacturing (MRP) process by defining the relationship between specific byproduct entries in a Bill of Materials and the variant attributes (e.g., color, size) associated with those products. It ensures that when a byproduct is generated during a manufacturing order, the system correctly identifies which product variant attributes are applicable to that byproduct.

## Description
Each row represents a single link between a specific MRP BOM byproduct record and a product template attribute value. This is a junction table used to resolve a many-to-many relationship, serving as a raw landed copy of the Odoo database schema in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_bom_byproduct_id | INTEGER | false | Foreign key to the MRP BOM byproduct record. | Links to the parent byproduct definition. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product template attribute value. | Identifies the specific attribute value (e.g., 'Red') applied to the byproduct. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite primary key consisting of both columns.
- **Foreign keys (inferred):** 
    - `mrp_bom_byproduct_id` → `mrp_bom_byproduct.id`: Links to the byproduct definition within the BOM.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: Links to the specific attribute value definition.
- **Natural keys (inferred):** The combination of `(mrp_bom_byproduct_id, product_template_attribute_value_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume this table reflects the current state of the Odoo database as captured during the last ingestion.
- Ensure inner joins are used when querying to avoid orphaned records if the source system has referential integrity gaps.