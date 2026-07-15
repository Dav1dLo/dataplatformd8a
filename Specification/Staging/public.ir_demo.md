# ir_demo

## Source system
This table originates from an Odoo ERP system. The naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default for the `id` column are characteristic patterns of the Odoo ORM framework.

## Functional process 
This table supports the internal audit and record-tracking process within the Odoo ecosystem. It tracks the lifecycle of records by capturing the identity of the users who created or modified the data and the corresponding timestamps, facilitating traceability across business modules.

## Description
One row in this table represents a single audit-tracked entity within the system. It serves as a raw landing copy of the record's metadata, capturing the grain of "one row per system entity instance." Its primary purpose in the Staging layer is to provide a historical audit trail for downstream transformation into silver-layer entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.ir_demo_id_seq` for auto-incrementing values. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's user table; null if created by system process. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the system's user table; updated on every write operation. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Inferred as UTC based on standard Odoo configuration. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Inferred as UTC; updated automatically by the ORM on save. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure access control is applied if these IDs are joined to PII-containing user tables.
- **Timezone:** Timestamps are assumed to be in UTC, consistent with standard Odoo database deployments.
- **Soft Deletes:** This table does not explicitly show a soft-delete flag (e.g., `active`), so assume all records are active unless otherwise specified by business logic.
- **Data Integrity:** As a staging table, expect potential nulls in `create_uid` or `write_uid` if records were migrated or created via system-level scripts.