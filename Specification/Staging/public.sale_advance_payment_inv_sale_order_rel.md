# sale_advance_payment_inv_sale_order_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `sale_advance_payment_inv` and `sale_order` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link advance payment invoices to their corresponding sales orders.

## Functional process 
This table supports the order-to-cash process, specifically tracking the relationship between advance payment invoices (down payments) and the underlying sales orders. It ensures that financial records of partial payments are correctly associated with the specific sales order they are intended to satisfy.

## Description
One row in this table represents a single association between an advance payment invoice and a sales order. It serves as a raw landing junction table in the staging layer, facilitating the reconstruction of many-to-many relationships that are normalized in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_advance_payment_inv_id | INTEGER | false | Foreign key to the advance payment invoice record | Links to the primary key of the invoice table. |
| sale_order_id | INTEGER | false | Foreign key to the sales order record | Links to the primary key of the sales order table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of `(sale_advance_payment_inv_id, sale_order_id)`.
- **Foreign keys (inferred):** 
    - `sale_advance_payment_inv_id` → `sale_advance_payment_inv.id` (Inferred from naming convention).
    - `sale_order_id` → `sale_order.id` (Inferred from naming convention).
- **Natural keys (inferred):** The combination of `(sale_advance_payment_inv_id, sale_order_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no non-key attributes.
- There is no audit timestamp or soft-delete flag present; this table reflects the current state of the relationship as captured during the last ingestion.
- Ensure joins to parent tables handle potential orphans if the source system's referential integrity is not strictly enforced.