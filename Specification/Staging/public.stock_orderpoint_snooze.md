# stock_orderpoint_snooze

## Source system
This table originates from an Odoo ERP system. The naming convention (`stock_orderpoint_snooze`), the presence of `create_uid`/`write_uid` audit columns, and the use of Postgres sequence-based primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the inventory replenishment process, specifically the "snooze" functionality for stock order points. It allows users to temporarily suppress or delay replenishment alerts for specific stock items until a predefined date, preventing unnecessary purchase or manufacturing orders.

## Description
One row represents a single snooze configuration applied to a stock order point, defining when the replenishment alert should resume. This is a raw landed staging table, acting as a direct copy of the Odoo `stock_orderpoint_snooze` model. It tracks the lifecycle of snooze events, including who created or modified the snooze record and the target date for alert resumption.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_orderpoint_snooze_id_seq`. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to `res_users.id`. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to `res_users.id`. |
| predefined_date | VARCHAR | true | Preset snooze duration | Likely stores string identifiers like 'next_week' or 'custom'. |
| snoozed_until | DATE | true | Resumption date | The date when the order point alert becomes active again. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the Odoo server. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the Odoo server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are stored in UTC.
- **Sensitivity:** `create_uid` and `write_uid` link to user records; ensure appropriate access controls if joining with user identity tables.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely physically deleted if the snooze is removed in the source system.
- **Data Quality:** `predefined_date` is a `VARCHAR` and may contain inconsistent string values depending on the Odoo version or custom configurations.