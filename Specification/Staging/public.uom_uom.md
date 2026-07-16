# uom_uom

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`uom_uom`), the use of `JSONB` for localized names, and the standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the inventory and product management process by defining Units of Measure (UoM) and their conversion factors. It is used to normalize quantities across different product categories, ensuring that conversions between units (e.g., grams to kilograms) are calculated consistently using the `factor` and `rounding` precision settings.

## Description
One row in this table represents a single unit of measure definition within the system. It serves as a raw landed copy of the Odoo `uom.uom` model, capturing the configuration for how a specific unit relates to its reference unit within a category.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| category_id | INTEGER | false | Foreign key to UoM category | Links to the grouping of related units. |
| create_uid | INTEGER | true | User ID who created the record | Reference to `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | Reference to `res.users`. |
| uom_type | VARCHAR | false | Type of unit | e.g., 'reference', 'bigger', 'smaller'. |
| name | JSONB | false | Unit name | Multi-language support; contains key-value pairs for locales. |
| factor | NUMERIC | false | Conversion factor | Multiplier used to convert to the reference unit. |
| rounding | NUMERIC | false | Rounding precision | Defines the decimal precision for this unit. |
| active | BOOLEAN | true | Soft-delete flag | If false, the unit is hidden from UI. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `category_id` → `uom_category.id`: Links the unit to its parent category.
    - `create_uid` → `res_users.id`: Identifies the creator of the record.
    - `write_uid` → `res_users.id`: Identifies the last modifier of the record.
- **Natural keys (inferred):** 
    - `name`: While stored as JSONB, the internal name value is typically unique within a category.

## Caveats for downstream consumers

- **Sensitive Data:** No PII or financial secrets; contains system configuration data.
- **Timestamps:** Assumed to be in UTC, consistent with Odoo standard behavior.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` to retrieve only current records.
- **JSONB:** The `name` column requires extraction (e.g., `name->>'en_US'`) to be used in standard reporting tools.
- **Precision:** `factor` and `rounding` are `NUMERIC` types; ensure downstream systems handle these as high-precision decimals to avoid rounding errors in inventory calculations.