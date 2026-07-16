# stock_inventory_conflict

## Source system
This table likely originates from an Odoo ERP or a similar Python-based framework that utilizes standard audit fields (`create_uid`, `write_uid`, `create_date`, `write_date`). The naming convention and the use of sequence-based primary keys are characteristic of Odoo's ORM layer.

## Functional process 
This table supports inventory management and reconciliation processes. It tracks conflicts or discrepancies identified during stock inventory counts or adjustments, likely serving as an audit log or a staging area for resolving stock-on-hand mismatches between the system record and physical counts.

## Description
One row represents a single inventory conflict event or discrepancy record identified within the stock management module. As a staging table, it acts as a raw, landed copy of the source system's conflict log, capturing the audit trail of who created or modified the record and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_inventory_conflict_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard ERP staging practices.
- **Audit Fields:** The presence of `create_uid` and `write_uid` suggests this table is managed by an ORM; ensure these IDs are joined against the correct user dimension in the target environment.
- **Soft Deletes:** There is no explicit `active` or `deleted_at` flag; assume this table contains only active records unless otherwise specified by the source system's business logic.
- **Data Completeness:** As a staging table, this may contain partial or transient data; verify row counts against the source system's audit logs during reconciliation.