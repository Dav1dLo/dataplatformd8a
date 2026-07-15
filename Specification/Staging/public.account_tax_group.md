# account_tax_group

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions (`create_uid`, `write_uid`, `write_date`), the use of `JSONB` for multi-language fields (`name`), and the sequence-based primary key pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the financial accounting and tax configuration process. It defines groupings of tax accounts used to categorize tax liabilities and receivables, likely used to map tax rates or groups to specific general ledger accounts for reporting and compliance purposes.

## Description
One row in this table represents a specific tax group configuration, defining how tax-related transactions are mapped to accounting ledgers for a given company and country. This is a raw landed staging table, serving as a direct copy of the source Odoo `account.tax.group` model, intended for downstream transformation into analytical dimensions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `account_tax_group_id_seq`. |
| sequence | INTEGER | true | Display order | Used to sort tax groups in UI/reports. |
| company_id | INTEGER | false | Company identifier | Foreign key to the company owning this tax group. |
| tax_payable_account_id | INTEGER | true | Payable account ID | GL account for tax liabilities. |
| tax_receivable_account_id | INTEGER | true | Receivable account ID | GL account for tax credits. |
| advance_tax_payment_account_id | INTEGER | true | Advance payment account ID | GL account for prepayments. |
| country_id | INTEGER | true | Country identifier | Geographic scope of the tax group. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| pos_receipt_label | VARCHAR | true | POS label | Label used for this tax group on POS receipts. |
| name | JSONB | false | Tax group name | Multi-language string; requires parsing. |
| preceding_subtotal | JSONB | true | Subtotal configuration | JSON structure defining subtotal behavior. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Inferred from Odoo standard naming)
    - `tax_payable_account_id` → `account_account.id` (Inferred from Odoo standard naming)
    - `tax_receivable_account_id` → `account_account.id` (Inferred from Odoo standard naming)
    - `country_id` → `res_country.id` (Inferred from Odoo standard naming)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **JSONB Parsing:** The `name` and `preceding_subtotal` columns contain JSONB data. Downstream queries must use `->>` or `->` operators to extract values (e.g., `name->>'en_US'`).
- **Timestamps:** Timestamps are stored in UTC as per standard Odoo/PostgreSQL configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically hard-deleted in the source system.
- **Data Sensitivity:** Contains internal accounting configuration; no direct PII, but should be handled according to financial data governance policies.