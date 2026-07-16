# res_partner_autocomplete_sync

## Source system
This table originates from Odoo ERP. The naming convention `res_partner_` is characteristic of Odoo's core "Resource Partner" module, and the presence of `create_uid`, `write_uid`, and `_seq` sequence defaults are standard patterns for Odoo's PostgreSQL-based ORM layer.

## Functional process 
This table supports the partner data synchronization process, specifically managing the state of autocomplete requests for business partners. It tracks which partner records have been processed or synchronized against external autocomplete services, likely to prevent redundant API calls or to manage background sync queues.

## Description
One row in this table represents the synchronization status of a specific partner record within the Odoo partner registry. It acts as a raw landing/staging record used to track the lifecycle of autocomplete metadata associated with a partner. The grain is one row per partner sync event or status entry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `res_partner_autocomplete_sync_id_seq`. |
| partner_id | INTEGER | true | Foreign key to the partner | Links to the `res_partner` table. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the sync record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the sync record. |
| synched | BOOLEAN | true | Synchronization status | Indicates if the autocomplete data has been successfully synced. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard practices. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard practices. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id`: This column maps to the primary entity table in Odoo's partner module.
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record ownership.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) and partner references; ensure access is restricted according to internal PII policies.
- **Timezone:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.
- **Data Integrity:** `partner_id` is nullable, which may indicate orphaned sync records or records awaiting association.