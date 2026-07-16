# purchase_bill_union

## Source system
The table likely originates from an ERP system such as Odoo, given the naming conventions like `partner_id`, `company_id`, and the specific combination of `vendor_bill_id` and `purchase_order_id`. The "union" suffix suggests this is a consolidated view or staging table merging multiple bill-related data sources into a single schema.

## Functional process 
This table supports the Procure-to-Pay (P2P) business process. It tracks financial obligations to vendors, linking specific purchase orders to their corresponding vendor bills to facilitate accounts payable reconciliation and spend analysis.

## Description
One row in this table represents a single purchase bill or invoice record associated with a vendor transaction. It serves as a raw landed staging entity, capturing the financial and relational metadata required to link procurement activities with accounting entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely an internal database ID. |
| name | VARCHAR | true | Document identifier | Often a human-readable invoice number (e.g., "BILL/2023/001"). |
| reference | VARCHAR | true | External reference | Vendor-provided invoice number or internal memo. |
| partner_id | INTEGER | true | Vendor identifier | Foreign key to the partner/vendor master table. |
| date | DATE | true | Transaction date | The accounting date of the bill. |
| amount | NUMERIC | true | Total bill amount | Monetary value; check for currency precision. |
| currency_id | INTEGER | true | Currency identifier | Foreign key to the currency master table. |
| company_id | INTEGER | true | Company identifier | Identifies the legal entity within the ERP. |
| vendor_bill_id | INTEGER | true | Vendor bill reference | Link to the specific vendor bill record. |
| purchase_order_id | INTEGER | true | Purchase order reference | Link to the originating purchase order. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo/ERP pattern for vendor links).
    - `currency_id` → `res_currency.id` (Standard Odoo/ERP pattern for currency links).
    - `company_id` → `res_company.id` (Standard Odoo/ERP pattern for multi-company setups).
- **Natural keys (inferred):** 
    - `name` (Assuming it acts as a unique document number within the company).

## Caveats for downstream consumers

- **PII/Sensitivity:** The `name` and `reference` columns may contain vendor-specific details; ensure compliance with data privacy policies.
- **Nullability:** Many columns are marked nullable; verify if this indicates incomplete ingestion or optional fields in the source system.
- **Data Integrity:** As a "union" table, ensure that `id` values are globally unique across the source systems being merged, or expect potential collisions if the source systems are disparate.
- **Timestamps:** The `date` column is a `DATE` type; assume no time component is present.