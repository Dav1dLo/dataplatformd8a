# stock_quantity_history

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences for the primary key, is characteristic of the Odoo ORM framework.

## Functional process 
This table supports inventory management and audit tracking. It records historical snapshots or changes in stock quantities, allowing the business to track inventory levels over time and identify which users performed specific updates to stock records.

## Description
One row in this table represents a single historical record or audit entry for a stock quantity adjustment. It serves as a raw landed copy of the Odoo `stock.quant.history` model, capturing the state of inventory at a specific point in time and the associated metadata for tracking changes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res_users` table. |
| inventory_datetime | TIMESTAMP | true | Timestamp of the inventory event | Represents the point in time the stock level was recorded. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit field; typically UTC. |
| write_date | TIMESTAMP | true | Record last modification timestamp | Audit field; typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for record creation tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for record modification tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are generally stored in UTC by the Odoo framework, but verify against the application configuration.
- **Audit fields:** `create_date` and `write_date` are system-generated; `write_date` will equal `create_date` for records that have not been modified since creation.
- **Data completeness:** This is a staging table; ensure that downstream models handle potential nulls in `create_uid` and `write_uid` if the user has been deleted from the source system.