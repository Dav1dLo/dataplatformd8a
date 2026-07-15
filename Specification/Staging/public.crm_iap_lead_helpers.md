# crm_iap_lead_helpers

## Source system
This table originates from an Odoo ERP or CRM system. The naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys (`nextval` on a `_seq` object) are characteristic signatures of the Odoo framework's ORM layer.

## Functional process 
This table supports the "Lead-to-cash" or "Marketing-to-Sales" pipeline, specifically managing helper associations for In-App Purchase (IAP) leads. It tracks metadata regarding the creation and modification of lead-related helper records, facilitating audit trails for lead enrichment or qualification processes.

## Description
One row in this table represents a single audit record or helper association linked to an IAP lead entity. It serves as a raw landed copy of the Odoo database table, capturing the system-level tracking fields for record lifecycle management.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the record. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record insertion; assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last modification; assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to internal user IDs; ensure these are mapped to human-readable names via the `res_users` table if necessary.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are active unless otherwise specified by the source system logic.
- **Data Completeness:** As a staging table, this contains raw system metadata; ensure joins to parent lead tables are validated for referential integrity.