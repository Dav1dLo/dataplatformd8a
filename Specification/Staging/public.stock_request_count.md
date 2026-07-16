# stock_request_count

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of PostgreSQL sequences for the `id` column, is highly characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the inventory management and stock reconciliation process. It tracks specific inventory counts or stock adjustment requests, likely linked to periodic stock-taking exercises where users record quantities for specific items or locations on a given date.

## Description
One row in this table represents a single stock request or inventory count entry recorded in the system. It serves as a raw landed staging entity, capturing the audit trail of who created or modified the count, the date of the inventory, and the associated accounting period.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.stock_request_count_id_seq`. |
| user_id | INTEGER | true | ID of the user associated with the request | Likely references a user/employee table. |
| create_uid | INTEGER | true | ID of the user who created the record | References the user who performed the initial entry. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the user who performed the last update. |
| set_count | VARCHAR | true | The recorded inventory quantity | Data type is generic; verify if this holds numeric strings or JSON. |
| inventory_date | DATE | false | The date the inventory count was performed | Business date for the stock adjustment. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Inferred UTC; check Odoo timezone settings. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Inferred UTC; check Odoo timezone settings. |
| accounting_date | DATE | true | Date for financial recognition | Used to post the inventory adjustment to a specific period. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: standard Odoo pattern for user associations).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Types:** The `set_count` column is defined as `VARCHAR`; ensure explicit casting to numeric types in downstream transformations to handle potential non-numeric characters.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all records are active unless Odoo's internal logic implies otherwise.
- **Audit Columns:** `create_uid` and `write_uid` are critical for data lineage and identifying the responsible party for inventory discrepancies.