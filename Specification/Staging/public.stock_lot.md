# stock_lot

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `product_uom_id`, `create_uid`, `write_uid`, `lot_properties` as `JSONB`) and the use of standard Odoo sequence generators for the primary key are characteristic of the Odoo PostgreSQL schema.

## Functional process 
This table supports the inventory management and supply chain process, specifically tracking individual batches or lots of products. It is used to maintain traceability for items within a warehouse, linking specific lots to products, locations, and internal company entities.

## Description
One row in this table represents a unique stock lot or serial number assigned to a specific product. It serves as a raw landed copy of the Odoo `stock.lot` model, capturing the metadata, properties, and audit timestamps for each inventory batch.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `public.stock_lot_id_seq`. |
| product_id | INTEGER | false | Foreign key to product | Links to the product definition. |
| product_uom_id | INTEGER | true | Unit of measure ID | Defines the measurement unit for this lot. |
| company_id | INTEGER | true | Owning company ID | Identifies the legal entity owning the stock. |
| location_id | INTEGER | true | Current location ID | The warehouse location where the lot is stored. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Lot/Serial number | The human-readable identifier for the lot. |
| ref | VARCHAR | true | Internal reference | An optional secondary reference code. |
| lot_properties | JSONB | true | Dynamic lot attributes | Stores flexible, schema-less attributes for the lot. |
| note | TEXT | true | Internal notes | Free-text field for operational comments. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |
| standard_price | JSONB | true | Costing data | Stores price-related metadata in JSON format. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_template.id` (Likely target based on Odoo standard schema).
    - `company_id` → `res_company.id` (Likely target based on Odoo standard schema).
    - `location_id` → `stock_location.id` (Likely target based on Odoo standard schema).
- **Natural keys (inferred):** 
    - `name` (In combination with `product_id`, this typically forms the unique business key for a lot).

## Caveats for downstream consumers

- **Sensitive Data:** The `lot_properties` and `note` fields may contain internal business logic or operational details; review for PII if necessary.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are active unless otherwise specified by Odoo's internal logic.
- **JSONB Usage:** `lot_properties` and `standard_price` require PostgreSQL-specific JSONB operators (e.g., `->>`, `@>`) for querying.
- **Precision:** `VARCHAR` columns do not have defined lengths in the metadata; assume standard Odoo lengths (usually 255 characters) but verify against source DDL if performing bulk inserts.