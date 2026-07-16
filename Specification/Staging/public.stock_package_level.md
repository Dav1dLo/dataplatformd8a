# stock_package_level

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the specific sequence-based default value for the `id` column, which is characteristic of Odoo's PostgreSQL schema.

## Functional process 
This table supports the inventory management and warehouse logistics process, specifically tracking the movement and location of stock packages. It links packages to specific picking operations and destination locations, facilitating the tracking of goods through the supply chain.

## Description
One row in this table represents a specific inventory package level record, detailing its association with a picking operation and a destination location. As a staging table, it serves as a raw landed copy of the Odoo `stock.package.level` model, capturing the state of package movements within the warehouse.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `stock_package_level_id_seq`. |
| package_id | INTEGER | false | Foreign key to the stock package | Links to the specific package being moved. |
| picking_id | INTEGER | true | Foreign key to the picking operation | The warehouse operation associated with this package level. |
| location_dest_id | INTEGER | true | Foreign key to the destination location | The target warehouse location for the package. |
| company_id | INTEGER | false | Foreign key to the owning company | Identifies the legal entity owning the stock. |
| create_uid | INTEGER | true | User ID who created the record | References the system user. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the application in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `package_id` → `stock_quant_package.id` (Guess: standard Odoo relation for packages)
    - `picking_id` → `stock_picking.id` (Guess: standard Odoo relation for warehouse operations)
    - `location_dest_id` → `stock_location.id` (Guess: standard Odoo relation for locations)
    - `company_id` → `res_company.id` (Guess: standard Odoo relation for multi-company support)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table contains audit fields (`create_uid`, `write_uid`) which are useful for tracking data lineage but may contain internal system IDs that require joining to a user dimension table.
- The table does not explicitly show a soft-delete flag; assume rows are hard-deleted if they disappear from the source, or check for an `active` column if it appears in future schema updates.
- `picking_id` and `location_dest_id` are nullable, implying that some package levels may exist independently of a specific picking operation or destination at certain stages of the process.