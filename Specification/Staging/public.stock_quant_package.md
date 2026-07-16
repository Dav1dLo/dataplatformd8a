# stock_quant_package

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`stock_quant_package`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the inventory management and logistics process, specifically tracking physical packaging units (e.g., pallets, boxes, or containers) within a warehouse. It links inventory quantities to specific packaging types and locations, facilitating the tracking of shipping weights and package usage states within the supply chain.

## Description
One row in this table represents a single physical packaging unit used to group inventory items. It serves as a raw landed copy of the Odoo `stock.quant.package` model, capturing the metadata, location, and weight attributes of a package at the grain of an individual package instance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `stock_quant_package_id_seq`. |
| package_type_id | INTEGER | true | Foreign key to package type | References the definition of the packaging container. |
| location_id | INTEGER | true | Foreign key to location | The current warehouse location of the package. |
| company_id | INTEGER | true | Foreign key to company | Multi-company identifier for data partitioning. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Package reference name | The human-readable identifier (e.g., "PACK001"). |
| package_use | VARCHAR | false | Usage status | Indicates if the package is for shipping, internal, etc. |
| pack_date | DATE | true | Packaging date | The date the package was created or sealed. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of the last modification. |
| shipping_weight | DOUBLE PRECISION | true | Weight of the package | Unit is typically kilograms; confirm against Odoo settings. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `package_type_id` → `product_packaging.id` (Guess: links to the package definition table).
    - `location_id` → `stock_location.id` (Guess: links to the warehouse location hierarchy).
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link).
- **Natural keys (inferred):** 
    - `name` (The unique package reference string).

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC as per standard Odoo/PostgreSQL configurations.
- **Soft Deletes:** This table does not appear to implement a `deleted` or `active` flag; assume all records are current unless otherwise specified by business logic.
- **Data Sensitivity:** Contains no PII, but `create_uid` and `write_uid` link to internal user IDs which may be considered sensitive in some security contexts.
- **Precision:** `shipping_weight` is `DOUBLE PRECISION`; be aware of floating-point arithmetic nuances when aggregating weights.