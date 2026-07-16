# mrp_production_picking_label_type_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `mrp_production_picking_label_type_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link Manufacturing Resource Planning (MRP) production orders to specific picking label configurations.

## Functional process 
This table supports the manufacturing execution process by managing the association between production orders and the specific label types required for picking operations. It ensures that when a production order is processed, the system identifies the correct label format or type to be generated for inventory picking.

## Description
One row in this table represents a single association between a manufacturing production order and a picking label type. It serves as a raw landing copy of a join table, facilitating the many-to-many relationship between production entities and label configuration entities within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| picking_label_type_id | INTEGER | false | Foreign key to the picking label type definition. | Links to the configuration entity. |
| mrp_production_id | INTEGER | false | Foreign key to the manufacturing production order. | Links to the production entity. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both `picking_label_type_id` and `mrp_production_id`.
- **Foreign keys (inferred):** 
    - `picking_label_type_id` → `picking_label_type.id` (Guess: standard Odoo naming convention for relational tables).
    - `mrp_production_id` → `mrp_production.id` (Guess: standard Odoo naming convention for relational tables).
- **Natural keys (inferred):** The combination of `(mrp_production_id, picking_label_type_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a junction/link table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- As a raw staging table, it may contain orphaned records if the upstream source system does not enforce strict referential integrity during the extraction process.
- No PII is present in this table.