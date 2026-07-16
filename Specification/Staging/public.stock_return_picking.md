# stock_return_picking

## Source system
This table originates from an Odoo ERP system. The naming convention (`picking`, `create_uid`, `write_uid`, `create_date`) and the use of PostgreSQL sequence-based primary keys are characteristic of Odoo's internal data model for inventory management.

## Functional process 
This table supports the inventory return process within the warehouse management module. It tracks the association between a return request and the original picking (transfer) operation, facilitating the reversal of stock movements when goods are returned by customers or vendors.

## Description
One row in this table represents a single return operation linked to a specific inventory picking event. It serves as a raw landing record in the staging layer, capturing the audit trail and linkage required to process stock reversals.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the return record. |
| picking_id | INTEGER | true | Foreign key to the original picking | Links the return to the specific stock transfer being reversed. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the return record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Date and time the return record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Date and time the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `picking_id` → `stock_picking.id`: This column references the primary key of the stock picking table, representing the source transfer being returned.
    - `create_uid` → `res_users.id`: References the user who created the record.
    - `write_uid` → `res_users.id`: References the user who last modified the record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names; no direct PII is present.
- **Timestamps:** Timestamps are stored in the database's local time; verify if the Odoo instance is configured for UTC (standard practice).
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are active unless otherwise specified by business logic.
- **Data Integrity:** `picking_id` is nullable, which may indicate orphaned records or returns not yet associated with a specific picking event.