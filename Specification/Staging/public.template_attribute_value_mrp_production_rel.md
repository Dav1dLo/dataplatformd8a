# template_attribute_value_mrp_production_rel

## Source system
This table likely originates from an ERP or manufacturing execution system (MES), such as Odoo or a similar modular business suite. The naming convention `_mrp_production_rel` strongly suggests a relational link table connecting manufacturing resource planning (MRP) production orders to specific attribute values defined in a template system.

## Functional process 
This table supports the manufacturing configuration and production tracking process. It acts as a bridge to associate specific production runs with custom attributes or configurations (e.g., material specifications, custom dimensions, or quality parameters) defined in a template, enabling granular tracking of production requirements.

## Description
One row in this table represents a single association between a specific production order and a template attribute value. It serves as a raw landing join table in the staging layer, facilitating a many-to-many relationship between production entities and attribute definitions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| production_id | INTEGER | false | Foreign key to the production order | Links to the primary production record. |
| template_attribute_value_id | INTEGER | false | Foreign key to the attribute value definition | Links to the specific attribute value assigned to the production. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(production_id, template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `production_id` → `mrp_production.id` (Inferred based on the table name suffix).
    - `template_attribute_value_id` → `template_attribute_value.id` (Inferred based on the column name).
- **Natural keys (inferred):** The combination of `(production_id, template_attribute_value_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes other than the two foreign keys.
- Ensure inner joins are used when filtering for complete associations, as these columns are non-nullable.
- No audit timestamps (e.g., `created_at`) are present in this table; rely on the parent tables for lineage or ingestion timing.