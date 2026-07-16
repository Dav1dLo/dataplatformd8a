# purchase_order

## Source system
This table originates from an Odoo ERP system, evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `partner_ref`, and the use of `picking_type_id` and `fiscal_position_id` which are standard Odoo modules for procurement and accounting.

## Functional process 
This table supports the "Procure-to-Pay" (P2P) business process. It tracks the lifecycle of purchase orders from initial creation and approval through to receipt of goods and invoice reconciliation, managing financial commitments, currency conversions, and vendor-specific terms.

## Description
One row represents a single purchase order header, capturing the high-level metadata, financial totals, and status of a procurement request. As a staging table, it serves as a raw, direct reflection of the Odoo `purchase.order` model, providing the base grain for downstream procurement analytics and spend reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| partner_id | INTEGER | false | Vendor identifier | Foreign key to partner/vendor table. |
| dest_address_id | INTEGER | true | Delivery address identifier | Location for goods receipt. |
| currency_id | INTEGER | false | Currency identifier | Reference to currency master data. |
| invoice_count | INTEGER | true | Number of linked invoices | Used for reconciliation tracking. |
| fiscal_position_id | INTEGER | true | Tax/Fiscal mapping identifier | Determines tax rules applied. |
| payment_term_id | INTEGER | true | Payment terms identifier | Defines due dates and discounts. |
| incoterm_id | INTEGER | true | Incoterms identifier | International commercial terms. |
| user_id | INTEGER | true | Responsible user identifier | Internal employee managing the PO. |
| company_id | INTEGER | false | Company identifier | Multi-company support. |
| create_uid | INTEGER | true | Creator user identifier | Audit trail for creation. |
| write_uid | INTEGER | true | Last modifier user identifier | Audit trail for updates. |
| access_token | VARCHAR | true | Public access token | Used for external portal links. |
| name | VARCHAR | false | Purchase order number | The human-readable PO reference. |
| priority | VARCHAR | true | Urgency level | e.g., '0', '1', '2'. |
| origin | VARCHAR | true | Source document reference | e.g., linked Sales Order or Requisition. |
| partner_ref | VARCHAR | true | Vendor's reference number | The PO number provided by the vendor. |
| state | VARCHAR | true | Lifecycle status | e.g., 'draft', 'sent', 'purchase', 'done'. |
| invoice_status | VARCHAR | true | Billing status | e.g., 'to invoice', 'invoiced'. |
| notes | TEXT | true | Internal/External notes | Free-text field. |
| amount_untaxed | NUMERIC | true | Subtotal before tax | Monetary value. |
| amount_tax | NUMERIC | true | Total tax amount | Monetary value. |
| amount_total | NUMERIC | true | Grand total | Monetary value. |
| amount_total_cc | NUMERIC | true | Total in company currency | Normalized total. |
| currency_rate | NUMERIC | true | Exchange rate | Rate at time of transaction. |
| mail_reminder_confirmed | BOOLEAN | true | Reminder status | Flag for vendor confirmation. |
| mail_reception_confirmed | BOOLEAN | true | Reception status | Flag for receipt confirmation. |
| mail_reception_declined | BOOLEAN | true | Declined status | Flag for rejected receipt. |
| date_order | TIMESTAMP | false | Order date | The date the PO was confirmed. |
| date_approve | TIMESTAMP | true | Approval date | Timestamp of manager approval. |
| date_planned | TIMESTAMP | true | Expected delivery date | Scheduled arrival. |
| date_calendar_start | TIMESTAMP | true | Calendar start date | Used for scheduling/resource planning. |
| create_date | TIMESTAMP | true | Record creation timestamp | System audit field. |
| write_date | TIMESTAMP | true | Record modification timestamp | System audit field. |
| project_id | INTEGER | true | Linked project identifier | For project-based procurement. |
| picking_type_id | INTEGER | false | Picking type identifier | Defines warehouse operation flow. |
| group_id | INTEGER | true | Procurement group identifier | Links related supply chain docs. |
| incoterm_location | VARCHAR | true | Incoterm location details | Specific port/place for Incoterm. |
| receipt_status | VARCHAR | true | Goods receipt status | e.g., 'pending', 'received'. |
| effective_date | TIMESTAMP | true | Actual completion date | When the order was finalized. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Vendor reference)
    - `currency_id` → `res_currency.id` (Currency reference)
    - `user_id` → `res_users.id` (Responsible employee)
    - `company_id` → `res_company.id` (Multi-company context)
- **Natural keys (inferred):** 
    - `name` (The unique PO number assigned by the system)

## Caveats for downstream consumers

- **Timestamps:** All timestamps are assumed to be in UTC as per standard Odoo PostgreSQL configurations.
- **Soft Deletes:** Odoo typically does not use soft deletes; records are usually hard-deleted or archived via a boolean flag (not present here).
- **Sensitive Data:** `customer_email` (if present in related tables) or internal notes may contain PII; ensure access controls are applied.
- **Precision:** `NUMERIC` types do not specify scale/precision in the metadata; assume standard financial precision (e.g., 18,2) but verify against source DDL if performing exact balance reconciliations.
- **Denormalization:** The `amount_total_cc` is likely a denormalized field for reporting convenience; always prefer calculating totals from line items if high precision is required.