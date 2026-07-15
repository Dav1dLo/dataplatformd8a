# account_tax_repartition_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`account_tax_repartition_line`), the use of `create_uid`/`write_uid` for audit tracking, and the specific sequence-based primary key generation pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the financial accounting and tax configuration process. It defines how tax amounts are distributed or repartitioned across different general ledger accounts, specifically determining the percentage of a tax base that should be allocated to a specific account during invoice or journal entry validation.

## Description
One row in this table represents a single repartition line for a tax, defining the percentage factor and the target account for a specific tax component. This is a raw landing of the Odoo configuration entity, serving as the base for downstream tax reporting and accounting integration models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_tax_repartition_line_id_seq`. |
| account_id | INTEGER | true | Foreign key to the target GL account | Links to the account where the tax amount is posted. |
| tax_id | INTEGER | true | Foreign key to the parent tax definition | Links to the tax record this line belongs to. |
| company_id | INTEGER | true | Foreign key to the owning company | Identifies the multi-company context. |
| sequence | INTEGER | true | Display or processing order | Used to sort lines when calculating tax distributions. |
| create_uid | INTEGER | true | User ID who created the record | Reference to the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | Reference to the `res_users` table. |
| repartition_type | VARCHAR | false | Type of repartition | Likely 'base' or 'tax' to distinguish distribution logic. |
| document_type | VARCHAR | false | Scope of the repartition | Defines if this applies to invoices, refunds, etc. |
| factor_percent | NUMERIC | false | Percentage factor | The multiplier applied to the tax base. |
| use_in_tax_closing | BOOLEAN | true | Tax closing flag | Indicates if this line is included in periodic tax reports. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed based on standard Odoo patterns. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed based on standard Odoo patterns. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `account_id` → `account_account.id` (Inferred from Odoo standard schema)
    - `tax_id` → `account_tax.id` (Inferred from Odoo standard schema)
    - `company_id` → `res_company.id` (Inferred from Odoo standard schema)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC; Odoo typically stores all system timestamps in UTC.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume standard Odoo behavior where records are either present or removed.
- **Data Integrity:** `account_id` and `tax_id` are nullable, which may occur if a tax repartition is partially configured or in a draft state.
- **Precision:** `factor_percent` is `NUMERIC` without defined scale; verify if downstream calculations require rounding to specific decimal places (e.g., 2 or 4).