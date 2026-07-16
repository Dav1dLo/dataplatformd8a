# uom_category

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions (`create_uid`, `write_uid`, `write_date`), the use of `JSONB` for multi-language field support, and the specific sequence-based default value pattern for the primary key.

## Functional process 
This table supports the inventory and product management process by defining categories for Units of Measure (UoM). It allows the system to group related units (e.g., "Length", "Weight", "Volume") to ensure that conversions are only performed between compatible units, preventing logical errors in stock movements and procurement.

## Description
One row in this table represents a single category of units of measure used to classify and group related measurement units. It serves as a raw landed copy of the Odoo `uom.category` model, capturing the metadata and configuration for unit grouping within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| name | JSONB | false | Category name | Multi-language string stored as JSON; typically contains keys for different locales. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application layer. |
| is_pos_groupable | BOOLEAN | true | POS grouping flag | Indicates if units in this category can be grouped together in Point of Sale transactions. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming for record ownership).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming for record modification).
- **Natural keys (inferred):** 
    - `name` (Assuming the category name is unique within the business context).

## Caveats for downstream consumers

- The `name` column is a `JSONB` object; query writers must use the `->>` operator to extract the string value (e.g., `name->>'en_US'`).
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table does not appear to implement soft deletes; standard `SELECT` queries will retrieve all records.
- `create_uid` and `write_uid` may be null if the record was created via a system process or migration script rather than a specific user action.