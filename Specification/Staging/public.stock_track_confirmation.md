# stock_track_confirmation

## Source system
This table originates from an Odoo ERP system. The naming convention (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the inventory tracking and stock management process. It likely records confirmation events for stock tracking operations, serving as an audit or status log for movements or adjustments within the warehouse management module.

## Description
One row in this table represents a single confirmation event for a stock tracking record. It acts as a raw landing copy of the source system's audit trail, capturing the identity of the users who created or modified the record and the corresponding timestamps.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| create_uid | INTEGER | true | ID of the user who created the record | References the users table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the users table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not contain an explicit `active` or `deleted_at` flag; check if the source system uses hard deletes or if records are simply never removed.
- **Audit Fields:** `create_uid` and `write_uid` are nullable; ensure queries handle cases where these fields might be empty for legacy or system-generated records.