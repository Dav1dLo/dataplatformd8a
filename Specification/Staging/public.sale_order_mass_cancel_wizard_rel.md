# sale_order_mass_cancel_wizard_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the naming convention `_rel` (standard for many-to-many relationship tables in Odoo) and the specific `sale_order_mass_cancel_wizard` prefix, which corresponds to an Odoo transient model used for bulk operations.

## Functional process 
This table supports the bulk cancellation of sales orders. It acts as a join table that links specific sales order records to a mass cancellation wizard session, allowing the system to track which orders are queued for cancellation within a single user-initiated process.

## Description
Each row represents a single association between a mass cancellation wizard instance and a specific sales order. It serves as a raw landing copy of the relationship table, facilitating the batch processing of order cancellations in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_mass_cancel_orders_id | INTEGER | false | Foreign key to the mass cancellation wizard session. | Links to the parent wizard record. |
| sale_order_id | INTEGER | false | Foreign key to the sales order being cancelled. | References the specific order record. |

## Keys

- **Primary key (inferred):** The combination of `sale_mass_cancel_orders_id` and `sale_order_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `sale_mass_cancel_orders_id` → `sale_mass_cancel_orders.id` (Inferred from Odoo naming conventions for wizard relations).
    - `sale_order_id` → `sale_order.id` (Standard Odoo reference to the sales order entity).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a join table; it contains no business data other than the relationship between the wizard and the orders.
- Expect high cardinality in `sale_order_id` if orders are processed through multiple cancellation attempts.
- There are no timestamps or audit columns present in this table; rely on the parent wizard table for execution context.