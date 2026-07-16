# mrp_batch_produce

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` audit columns, alongside the `mrp_` prefix which is standard for Odoo's Manufacturing Resource Planning module.

## Functional process 
This table supports the manufacturing execution process, specifically tracking the batch production of items. It manages the configuration and output of production lots, including separators used for parsing component and quantity data during the batch production lifecycle.

## Description
One row in this table represents a specific batch production record or configuration instance within the manufacturing module. It serves as a raw landed copy of the Odoo `mrp.batch.produce` model, capturing both the metadata of the production run and the formatting parameters used for batch tracking.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| production_id | INTEGER | true | Foreign key to production order | Links to the parent manufacturing order. |
| lot_qty | INTEGER | true | Quantity produced in the batch | Unit count for the specific lot. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| lot_name | VARCHAR | true | Lot identifier | Human-readable name or code for the batch. |
| component_separator | VARCHAR | false | Parsing character for components | Used to delimit component data strings. |
| lots_separator | VARCHAR | false | Parsing character for lots | Used to delimit lot data strings. |
| lots_quantity_separator | VARCHAR | false | Parsing character for quantities | Used to delimit quantity data strings. |
| production_text | TEXT | true | Descriptive notes | Free-text field for production details. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Record modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `production_id` → `mrp_production.id` (Guess: Standard Odoo naming convention for production order links).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against user tables to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** `production_id` is nullable; records without a production ID may represent orphaned or draft configurations.
- **Formatting:** The `*_separator` columns are critical for any downstream logic that attempts to parse the `production_text` or related batch strings.