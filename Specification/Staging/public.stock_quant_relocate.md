# stock_quant_relocate

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`stock_quant_relocate`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the inventory management process, specifically tracking the relocation of stock quantities between warehouse locations or packaging units. It serves as a transaction log or staging record for movements that change the physical or logical placement of inventory items within the warehouse hierarchy.

## Description
One row represents a single relocation event or request for stock quantities. It captures the destination details, associated messaging, and audit timestamps for the movement. As a staging table, it provides a raw, append-only record of relocation activity before further processing into inventory fact tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the relocation record. |
| dest_location_id | INTEGER | true | Foreign key to destination location | References the target warehouse location for the stock. |
| dest_package_id | INTEGER | true | Foreign key to destination package | References the target packaging unit, if applicable. |
| create_uid | INTEGER | true | Creator user ID | References the system user who initiated the relocation. |
| write_uid | INTEGER | true | Last modifier user ID | References the system user who last updated the record. |
| message | TEXT | true | Relocation notes | Free-text field for comments or reasons regarding the move. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of when the relocation record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification to this record. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `dest_location_id` → `stock_location.id` (Guess: standard Odoo naming for location references).
    - `dest_package_id` → `stock_quant_package.id` (Guess: standard Odoo naming for package references).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo naming for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with user tables to identify individuals.
- **Timestamps:** Timestamps are assumed to be in the server's local time or UTC as configured in the Odoo instance; verify against system settings.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are active unless otherwise specified by business logic.
- **Data Integrity:** As a staging table, `dest_location_id` and `dest_package_id` may be null if the relocation was cancelled or failed to complete.