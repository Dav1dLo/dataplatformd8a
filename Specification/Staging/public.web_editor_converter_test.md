# web_editor_converter_test

## Source system
This table originates from an Odoo ERP instance. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the presence of a `many2one` column are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table serves as a technical test or sandbox entity for the Odoo web editor converter. It is used to validate the serialization and storage of various data types—ranging from simple primitives to complex HTML and binary blobs—within the Odoo framework's persistence layer.

## Description
One row in this table represents a single record instance within the web editor converter test module. It acts as a raw landing copy of the application's internal state, capturing a wide variety of field types to ensure data integrity during conversion processes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo ORM. |
| integer | INTEGER | true | Integer value | - |
| many2one | INTEGER | true | Foreign key reference | Likely points to a related Odoo model ID. |
| create_uid | INTEGER | true | Creator user ID | References `res.users.id`. |
| write_uid | INTEGER | true | Last modifier user ID | References `res.users.id`. |
| char | VARCHAR | true | Character string | Length unspecified in metadata; confirm against source. |
| selection_str | VARCHAR | true | Selection field value | Stores the key of an Odoo selection field. |
| date | DATE | true | Date value | - |
| html | TEXT | true | HTML content | Likely contains sanitized or raw HTML markup. |
| text | TEXT | true | Long-form text | - |
| numeric | NUMERIC | true | Fixed-point number | Precision/scale unspecified; confirm against source. |
| datetime | TIMESTAMP | true | Timestamp value | Odoo typically stores these in UTC. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC. |
| float | DOUBLE PRECISION | true | Floating-point number | - |
| binary | BYTEA | true | Binary data | Stores encoded file or image data. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
    - `many2one` → `unknown_target_table.id` (Guess: generic relationship field).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns (`create_date`, `write_date`, `datetime`) are assumed to be in UTC, consistent with Odoo's standard behavior.
- **Sensitive Data:** The `html` and `text` columns may contain user-generated content; ensure PII scanning is performed if this data is exposed to reporting layers.
- **Binary Data:** The `binary` column contains `BYTEA` data; ensure downstream systems can handle large binary objects before selecting this column.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column), which is common in other Odoo tables. Assume all rows are active unless otherwise specified by business logic.