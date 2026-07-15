# account_account_tax_default_rel

## Source system
This table likely originates from an Odoo or similar ERP system, as indicated by the `_rel` suffix and the naming convention linking accounts to tax defaults, which is characteristic of Odoo's many-to-many relationship tables.

## Functional process 
This table supports the financial configuration and tax automation process. It defines the default tax rates that should be applied to specific general ledger accounts during transaction processing, ensuring consistent tax application across the accounting module.

## Description
One row in this table represents a single association between a general ledger account and a default tax rate. It serves as a raw landing copy of a many-to-many join table used to map accounts to their applicable default taxes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_id | INTEGER | false | Foreign key to the account table | Represents the GL account identifier. |
| tax_id | INTEGER | false | Foreign key to the tax table | Represents the default tax identifier. |

## Keys

- **Primary key (inferred):** The combination of `(account_id, tax_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `account_id` → `account.id`: Evidence is the naming convention and role as a GL account reference.
    - `tax_id` → `tax.id`: Evidence is the naming convention and role as a tax rate reference.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; expect no descriptive attributes other than the two foreign keys.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure referential integrity checks are performed against the source `account` and `tax` tables, as this staging table may contain orphaned records if the source system does not enforce strict constraints.