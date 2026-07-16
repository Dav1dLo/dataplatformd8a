# picking_type_favorite_user_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `*_rel` is characteristic of Odoo's many-to-many relationship tables, and `picking_type` is a standard module entity within Odoo's inventory management system.

## Functional process 
This table supports the user interface configuration for inventory operations. It tracks which specific picking types (e.g., "Receipts", "Internal Transfers", "Delivery Orders") a user has marked as a "favorite" to appear on their dashboard or quick-access menus.

## Description
One row represents a single association between a user and a picking type, indicating that the user has favorited that specific operation type. This is a raw landing of a many-to-many join table used to manage user-specific UI preferences in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| picking_type_id | INTEGER | false | Foreign key to the picking type definition | Links to the master list of inventory operation types. |
| user_id | INTEGER | false | Foreign key to the user definition | Identifies the user who favorited the picking type. |

## Keys

- **Primary key (inferred):** The combination of `(picking_type_id, user_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `picking_type_id` → `picking_type.id` (Inferred from Odoo naming conventions).
    - `user_id` → `res_users.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present, so it is impossible to determine when these preferences were set or updated from this table alone.
- As a staging table, it should be joined with the corresponding master tables (`picking_type` and `res_users`) to provide meaningful context for reporting.