# bill_to_po_wizard

## Source system
The table likely originates from an Odoo ERP system. The naming convention (e.g., `_id`, `_uid`, `_date`), the use of `nextval` sequences for primary keys, and the specific pattern of `create_uid`/`write_uid` audit columns are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the "Procure-to-Pay" or "Vendor Billing" business process. It acts as a transient wizard or state-management table used when converting or linking vendor bills to existing purchase orders, facilitating the reconciliation of incoming invoices against authorized procurement documents.

## Description
One row represents a single execution instance or session of a "Bill to Purchase Order" wizard. It captures the association between a specific partner and a purchase order during the document creation process. As a staging table, it serves as a raw, landed copy of the wizard's state data before it is processed into permanent accounting or procurement records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `bill_to_po_wizard_id_seq`. |
| purchase_order_id | INTEGER | true | Foreign key to the purchase order | Links to the target PO being billed. |
| partner_id | INTEGER | true | Foreign key to the partner/vendor | The vendor associated with the billing wizard. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the wizard. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC; records when the wizard was opened. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC; records the last interaction with the wizard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `purchase_order_id` → `purchase_order.id` (Inferred from naming convention common in Odoo).
    - `partner_id` → `res_partner.id` (Inferred from standard Odoo partner relationship patterns).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to identify individuals.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo server configurations.
- **Data Lifecycle:** As a "wizard" table, this data may be transient or ephemeral; rows might be deleted or truncated after the billing process is completed.
- **Nullability:** Most fields are nullable, suggesting that a wizard session might be initialized before all associations (like `purchase_order_id`) are fully populated.