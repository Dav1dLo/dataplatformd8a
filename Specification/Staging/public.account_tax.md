# account_tax

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for multi-lingual fields (`name`, `description`).

## Functional process 
This table supports the financial accounting and tax configuration process. It defines the tax rates, calculation methods, and application scopes (e.g., sales vs. purchase) used across the invoice-to-cash and procure-to-pay cycles.

## Description
One row in this table represents a single tax definition or tax rule configured within the accounting module. It acts as a raw landed copy of the system's tax configuration, capturing the parameters required to calculate tax amounts on financial documents.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | false | Foreign key to the owning company | Links tax to a specific legal entity. |
| sequence | INTEGER | false | Display/processing order | Used to determine priority of tax application. |
| tax_group_id | INTEGER | false | Foreign key to tax group | Groups related taxes for reporting. |
| cash_basis_transition_account_id | INTEGER | true | Account for cash basis accounting | Used if tax is recognized on payment. |
| country_id | INTEGER | false | Foreign key to country | Defines the jurisdiction for the tax. |
| create_uid | INTEGER | true | User ID who created the record | Reference to system user. |
| write_uid | INTEGER | true | User ID who last updated the record | Reference to system user. |
| type_tax_use | VARCHAR | false | Tax usage scope | e.g., 'sale', 'purchase', 'none'. |
| tax_scope | VARCHAR | true | Scope of tax application | e.g., 'service', 'consu'. |
| amount_type | VARCHAR | false | Calculation method | e.g., 'percent', 'fixed', 'division'. |
| price_include_override | VARCHAR | true | Price inclusion behavior | Overrides default tax inclusion settings. |
| tax_exigibility | VARCHAR | true | Tax exigibility rule | e.g., 'on_invoice', 'on_payment'. |
| name | JSONB | false | Tax name | Multi-lingual field. |
| description | JSONB | true | Tax description | Multi-lingual field. |
| invoice_label | JSONB | true | Label for invoice printout | Multi-lingual field. |
| invoice_legal_notes | TEXT | true | Legal disclosure text | Specific legal requirements for the tax. |
| amount | NUMERIC | false | Tax rate or fixed amount | Interpretation depends on `amount_type`. |
| active | BOOLEAN | true | Soft-delete flag | True if the tax is currently enabled. |
| include_base_amount | BOOLEAN | true | Include in base amount | Whether this tax affects the base for others. |
| is_base_affected | BOOLEAN | true | Is base affected | Flag for cascading tax calculations. |
| analytic | BOOLEAN | true | Analytic accounting flag | Whether tax is tracked in analytic accounts. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture)
    - `tax_group_id` → `account_tax_group.id` (Groups taxes for reporting)
    - `country_id` → `res_country.id` (Geographic jurisdiction)
- **Natural keys (inferred):** 
    - None confidently inferable; Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, though `create_uid` and `write_uid` link to user identities.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = true` to retrieve current configurations.
- **JSONB Fields:** Fields like `name` and `description` contain JSON objects (e.g., `{"en_US": "VAT 20%"}`); downstream consumers must parse these based on the required locale.
- **Precision:** `amount` is `NUMERIC` without specified scale; verify if this requires rounding for specific financial calculations.