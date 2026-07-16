# stock_warn_insufficient_qty_scrap

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_date`, `product_uom_name`) and the use of PostgreSQL sequences for primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the inventory management and manufacturing process, specifically tracking warnings or logs generated when a scrap operation is attempted with insufficient stock quantity. It acts as a transient or audit record for inventory adjustments where the requested scrap quantity exceeds available on-hand stock.

## Description
One row in this table represents a single instance of an insufficient quantity warning triggered during a scrap operation. It serves as a raw landing record in the staging layer, capturing the product, location, and quantity details associated with the failed or flagged scrap event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `stock_warn_insufficient_qty_scrap_id_seq`. |
| product_id | INTEGER | false | Foreign key to product | References the product being scrapped. |
| location_id | INTEGER | false | Foreign key to location | References the inventory location where the scrap was attempted. |
| scrap_id | INTEGER | true | Foreign key to scrap order | Links to the parent scrap operation record. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who triggered the warning. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| product_uom_name | VARCHAR | false | Unit of measure label | Human-readable name of the unit of measure (e.g., "Units", "kg"). |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |
| quantity | DOUBLE PRECISION | false | Scrap quantity | The amount of product requested for scrap. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Standard Odoo naming convention for product references).
    - `location_id` → `stock_location.id` (Standard Odoo naming convention for inventory locations).
    - `scrap_id` → `stock_scrap.id` (Links to the primary scrap transaction table).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory for PII masking.
- **Timestamps:** Assumed to be in UTC, consistent with Odoo's standard database configuration.
- **Data Integrity:** The `scrap_id` is nullable, suggesting that some warning records may exist independently of a successfully created scrap order.
- **Precision:** `quantity` is stored as `DOUBLE PRECISION`; ensure downstream systems handle floating-point arithmetic appropriately when aggregating these values.