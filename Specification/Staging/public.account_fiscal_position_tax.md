# account_fiscal_position_tax

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`account_fiscal_position_tax`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value pattern common to Odoo's PostgreSQL schema.

## Functional process 
This table supports the tax mapping process within the accounting module. It defines how taxes are substituted when a specific fiscal position (e.g., "Intra-community B2B") is applied to a transaction, mapping a source tax (`tax_src_id`) to a destination tax (`tax_dest_id`) based on the fiscal position (`position_id`).

## Description
One row represents a single tax substitution rule within a specific fiscal position. It acts as a raw landing copy of the Odoo `account.fiscal.position.tax` model, capturing the relationship between the original tax and the replacement tax required for tax reporting compliance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_fiscal_position_tax_id_seq`. |
| position_id | INTEGER | false | Foreign key to fiscal position | Links to the parent fiscal position definition. |
| company_id | INTEGER | true | Company identifier | Multi-company context; null implies global/shared. |
| tax_src_id | INTEGER | false | Original tax ID | The tax code being replaced. |
| tax_dest_id | INTEGER | true | Replacement tax ID | The tax code to be applied instead. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `position_id` → `account_fiscal_position.id` (Inferred from Odoo naming conventions).
    - `tax_src_id` → `account_tax.id` (Inferred from Odoo naming conventions).
    - `tax_dest_id` → `account_tax.id` (Inferred from Odoo naming conventions).
    - `company_id` → `res_company.id` (Standard Odoo multi-company link).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are typically stored in the server's local time; verify if the Odoo instance is configured for UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if missing from source.
- **Nullability:** `tax_dest_id` can be null, which in Odoo logic often signifies that the source tax should be removed (not replaced) when the fiscal position is applied.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs and will not resolve to human-readable names without joining to the `res_users` table.