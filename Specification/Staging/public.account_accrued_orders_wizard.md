# account_accrued_orders_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`_wizard`, `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys.

## Functional process 
This table supports the "Accrued Orders" financial process, specifically acting as a transient wizard or configuration state for generating accrual journal entries. It captures the parameters required to calculate and post accruals, such as the target account, journal, currency, and the specific dates for the accrual and its subsequent reversal.

## Description
One row represents a single configuration instance or "wizard" session used to define the parameters for an accrued order entry. As a staging table, it serves as a raw, landed copy of the wizard's state before the data is processed into permanent accounting journal entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the legal entity for the accrual. |
| journal_id | INTEGER | false | Foreign key to the journal | The accounting journal where the entry will be posted. |
| currency_id | INTEGER | true | Foreign key to the currency | The currency associated with the accrual amount. |
| account_id | INTEGER | false | Foreign key to the account | The general ledger account to be accrued. |
| create_uid | INTEGER | true | User ID who created the record | References the system user. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user. |
| date | DATE | false | Accrual date | The effective date for the accrual entry. |
| reversal_date | DATE | false | Reversal date | The date on which the accrual is expected to be reversed. |
| amount | NUMERIC | true | Accrual amount | The monetary value of the accrual. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo pattern for multi-company isolation).
    - `journal_id` → `account_journal.id` (Required for posting financial entries).
    - `currency_id` → `res_currency.id` (Standard Odoo currency reference).
    - `account_id` → `account_account.id` (Required for general ledger mapping).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against user tables to resolve names.
- **Timestamps:** Assumed to be in UTC; verify against system configuration if precision to the second is required for audit.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume all records are current unless otherwise specified by business logic.
- **Wizard Nature:** As a "wizard" table, data here may be ephemeral or intended for short-term storage; ensure downstream processes handle potential duplicates or abandoned wizard sessions.