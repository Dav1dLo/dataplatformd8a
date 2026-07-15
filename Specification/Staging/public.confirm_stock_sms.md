# confirm_stock_sms

## Source system
This table originates from an Odoo ERP environment, evidenced by the standard Odoo naming conventions for audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys (`nextval` on `id`).

## Functional process 
This table supports the inventory management and notification process, specifically tracking the confirmation of stock-related SMS alerts. It likely logs the audit trail for automated or manual stock confirmation messages sent to stakeholders or warehouse staff.

## Description
One row in this table represents a single audit record for a stock confirmation SMS event. It serves as a raw landing staging table, capturing the metadata and lifecycle timestamps of SMS confirmation entries within the Odoo inventory module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the users table; identifies who initiated the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the users table; identifies who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was first inserted. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for record creation tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for record modification tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the database server's timezone (typically UTC in Odoo environments), but verify against the application configuration.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume records are hard-deleted if they disappear from the source.
- **Audit Columns:** `create_uid` and `write_uid` are system-level references; ensure joins to the `res_users` table are handled as left joins to account for potential nulls or deleted user accounts.