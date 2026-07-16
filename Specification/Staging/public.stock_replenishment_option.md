# stock_replenishment_option

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the inventory replenishment process, specifically managing the configuration or options associated with how products are restocked across different supply routes. It links specific products to replenishment logic and routing definitions.

## Description
One row in this table represents a single configuration option for a stock replenishment rule or strategy. It serves as a raw landed staging entity, capturing the relationship between a product, a supply route, and specific replenishment parameters.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the option. |
| route_id | INTEGER | true | Foreign key to supply route | Links to the routing logic for the replenishment. |
| product_id | INTEGER | true | Foreign key to product | The specific item being replenished. |
| replenishment_info_id | INTEGER | true | Foreign key to replenishment info | Links to detailed replenishment configuration parameters. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `route_id` → `stock_location_route.id` (Guess: standard Odoo naming for route entities).
    - `product_id` → `product_product.id` (Guess: standard Odoo naming for product entities).
    - `replenishment_info_id` → `stock_replenishment_info.id` (Guess: inferred from naming pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may map to PII in a separate user/employee table.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all records are current unless filtered by business logic.
- **Data Integrity:** As a staging table, foreign key relationships are not enforced at the database level; verify existence of IDs in target tables before joining.