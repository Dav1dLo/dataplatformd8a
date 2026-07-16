# mrp_consumption_warning_mrp_production_rel

## Source system
This table likely originates from an Odoo ERP system or a similar modular manufacturing execution system (MES). The naming convention `_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link core business entities—in this case, material requirements planning (MRP) consumption warnings and production orders.

## Functional process 
This table supports the manufacturing production tracking process, specifically managing the relationship between consumption warnings (alerts triggered when material usage deviates from the bill of materials) and the specific production orders that generated them. It facilitates the traceability of production variances back to the source work order.

## Description
One row in this table represents a single association between a specific MRP consumption warning and a production order. It acts as a join table in a many-to-many relationship, ensuring that multiple warnings can be linked to multiple production orders. This is a raw landed copy of the relational mapping table from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_consumption_warning_id | INTEGER | false | Foreign key to the consumption warning entity | Links to the primary key of the warning table. |
| mrp_production_id | INTEGER | false | Foreign key to the production order entity | Links to the primary key of the production order table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both `mrp_consumption_warning_id` and `mrp_production_id`.
- **Foreign keys (inferred):** 
    - `mrp_consumption_warning_id` → `mrp_consumption_warning.id` (Inferred from naming convention).
    - `mrp_production_id` → `mrp_production.id` (Inferred from naming convention).
- **Natural keys (inferred):** The combination of `(mrp_consumption_warning_id, mrp_production_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table contains no descriptive attributes, only relational identifiers.
- There is no audit timestamp (e.g., `created_at`) available in this table; ingestion timing must be inferred from the parent pipeline metadata.
- As a join table, expect high cardinality and frequent joins against the parent entities.
- Ensure referential integrity checks are performed when joining, as staging tables may contain orphaned records if the source system's cleanup processes are inconsistent.