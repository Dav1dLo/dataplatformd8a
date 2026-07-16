# stock_backorder_confirmation

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the inventory management and order fulfillment process. It specifically tracks the confirmation state of backorders, which are generated when a stock move or delivery order cannot be fully satisfied by current inventory levels.

## Description
One row in this table represents a single backorder confirmation event or configuration record within the inventory module. It serves as a raw landed copy of the Odoo `stock.backorder.confirmation` model, capturing the audit trail of who created or modified the confirmation and whether associated transfers should be displayed to the user.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| show_transfers | BOOLEAN | true | Display flag | Indicates if the UI should show transfers associated with this backorder. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of the last record modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for record ownership).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure access control is applied if joining with user metadata.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by business logic.
- **Data Pattern:** As a staging table, this data is a direct reflection of the source and may contain transient records or system-generated noise.