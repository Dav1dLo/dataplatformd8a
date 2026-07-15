# account_move_purchase_order_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the association of `purchase_order` and `account_move` (the Odoo internal term for journal entries/invoices) is characteristic of Odoo's many-to-many relational link tables.

## Functional process 
This table supports the Procure-to-Pay (P2P) process by maintaining the link between purchase orders and their corresponding financial journal entries (vendor bills). It allows the system to track which financial transactions are associated with specific procurement commitments.

## Description
One row in this table represents a single association between a purchase order and an account move (invoice/bill). It acts as a join table to resolve a many-to-many relationship between procurement records and financial accounting records in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| purchase_order_id | INTEGER | false | Foreign key to the purchase order | Links to the primary key of the purchase order table. |
| account_move_id | INTEGER | false | Foreign key to the account move | Links to the primary key of the account move (invoice) table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(purchase_order_id, account_move_id)`.
- **Foreign keys (inferred):** 
    - `purchase_order_id` → `purchase_order.id`: Links to the source purchase order record.
    - `account_move_id` → `account_move.id`: Links to the source financial journal entry record.
- **Natural keys (inferred):** The combination of `(purchase_order_id, account_move_id)` acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when the relationship was created or modified from this table alone.
- Ensure that joins to the target tables handle potential orphaned records if referential integrity is not strictly enforced in the source system.