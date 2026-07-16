# payment_transaction

## Source system
The table appears to originate from an Odoo ERP system. The naming conventions (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`), the use of `nextval` sequences for primary keys, and the structure of partner-related fields are characteristic of Odoo's ORM-based database schema.

## Functional process 
This table supports the payment processing and reconciliation pipeline. It tracks the lifecycle of financial transactions initiated through various payment providers, linking them to specific partners (customers), internal orders (e.g., `pos_order_id`), and payment methods. It serves as the audit trail for transaction states, amounts, and provider-specific references.

## Description
One row in this table represents a single payment transaction event, capturing the financial details, current status, and associated partner information. As a staging table, it acts as a raw, landed copy of the operational transaction data, intended to be cleaned and integrated into downstream financial reporting or accounting models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `payment_transaction_id_seq`. |
| provider_id | INTEGER | false | ID of the payment provider | Foreign key to provider configuration. |
| company_id | INTEGER | true | ID of the company | Multi-company context identifier. |
| payment_method_id | INTEGER | false | ID of the payment method | Links to payment method definition. |
| currency_id | INTEGER | false | ID of the currency | Links to currency master data. |
| token_id | INTEGER | true | ID of the payment token | Used for recurring or saved payment methods. |
| source_transaction_id | INTEGER | true | ID of the parent transaction | Used for refunds or follow-up operations. |
| partner_id | INTEGER | false | ID of the partner | Links to the customer/partner record. |
| partner_state_id | INTEGER | true | ID of the partner state/province | Geographic region of the partner. |
| partner_country_id | INTEGER | true | ID of the partner country | ISO-like country identifier. |
| create_uid | INTEGER | true | User ID who created the record | Audit trail for record creation. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit trail for record modification. |
| reference | VARCHAR | false | Internal transaction reference | Unique identifier within the ERP. |
| provider_reference | VARCHAR | true | External provider reference | Transaction ID from the payment gateway. |
| state | VARCHAR | false | Current transaction state | e.g., 'draft', 'pending', 'done', 'error'. |
| operation | VARCHAR | true | Type of operation | e.g., 'online_direct', 'validation'. |
| landing_route | VARCHAR | true | URL or route of the landing page | Context for web-based payments. |
| partner_name | VARCHAR | true | Partner display name | Denormalized copy of partner name. |
| partner_lang | VARCHAR | true | Partner language code | e.g., 'en_US'. |
| partner_email | VARCHAR | true | Partner email address | PII. |
| partner_address | VARCHAR | true | Partner street address | PII. |
| partner_zip | VARCHAR | true | Partner postal code | |
| partner_city | VARCHAR | true | Partner city | |
| partner_phone | VARCHAR | true | Partner phone number | PII. |
| state_message | TEXT | true | Detailed state/error message | Often contains gateway response logs. |
| amount | NUMERIC | false | Transaction amount | Precision not specified; check source DDL. |
| is_post_processed | BOOLEAN | true | Post-processing flag | Indicates if accounting entries were created. |
| tokenize | BOOLEAN | true | Tokenization request flag | Whether to save payment details. |
| last_state_change | TIMESTAMP | true | Timestamp of last state update | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Record last update timestamp | |
| payment_id | INTEGER | true | ID of the linked payment record | Links to the accounting payment entry. |
| is_donation | BOOLEAN | true | Donation flag | Indicates if transaction is a donation. |
| pos_order_id | INTEGER | true | ID of the POS order | Links to Point of Sale transactions. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo partner link)
    - `currency_id` → `res_currency.id` (Standard Odoo currency link)
    - `pos_order_id` → `pos_order.id` (Links to point of sale orders)
- **Natural keys (inferred):** 
    - `reference` (The internal ERP transaction code)

## Caveats for downstream consumers

- **Sensitive Data:** This table contains PII (`partner_email`, `partner_address`, `partner_phone`). Ensure appropriate masking or access control is applied.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are hard-deleted if removed from the source.
- **Denormalization:** Several columns (e.g., `partner_name`, `partner_email`) are denormalized from the `res_partner` table. These may become stale if the partner record is updated after the transaction occurs.