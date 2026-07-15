# barcode_rule

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit columns in the Odoo ORM.

## Functional process 
This table supports the barcode scanning and inventory management process. It defines the rules for interpreting scanned barcodes, mapping specific patterns to internal system entities like products or units of measure, and handling GS1-standardized barcode data.

## Description
One row represents a single parsing rule used to interpret a barcode string based on its encoding and pattern. This is a raw landing table in the Staging layer, capturing the configuration state of barcode nomenclature rules as defined in the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.barcode_rule_id_seq`. |
| barcode_nomenclature_id | INTEGER | true | Foreign key to the parent nomenclature | Links to the barcode nomenclature definition. |
| sequence | INTEGER | true | Sort order for rule evaluation | Lower numbers are evaluated first. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| name | VARCHAR | false | Rule name | Human-readable label for the rule. |
| encoding | VARCHAR | false | Barcode encoding standard | e.g., 'ean13', 'gs1-128'. |
| type | VARCHAR | false | Rule type | Defines the logic applied to the barcode. |
| pattern | VARCHAR | false | Regex or pattern string | The pattern used to match the scanned barcode. |
| alias | VARCHAR | false | Alias for the rule | Alternative identifier for the rule. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |
| associated_uom_id | INTEGER | true | Unit of measure ID | Links to the UOM if the rule defines a quantity. |
| gs1_content_type | VARCHAR | true | GS1 content category | Used for GS1-128 barcode parsing. |
| gs1_decimal_usage | BOOLEAN | true | Decimal usage flag | Indicates if the rule supports decimal values. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `barcode_nomenclature_id` → `barcode_nomenclature.id` (Guess: standard Odoo naming convention for parent-child relationships).
    - `associated_uom_id` → `uom_uom.id` (Guess: standard Odoo naming convention for unit of measure references).
- **Natural keys (inferred):** 
    - `name` (Assuming uniqueness within a nomenclature).

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume all rows are current unless otherwise specified by the source system's logic.
- **Data Quality:** As a staging table, this contains raw configuration data; ensure that `pattern` strings are validated against the expected regex engine before use in downstream transformations.
- **Sensitivity:** No PII is present in this table; it contains system configuration and metadata.