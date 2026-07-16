# mrp_account_wip_accounting_line

## Source system
This table originates from an Odoo ERP environment, evidenced by the naming convention (`mrp_account_wip_accounting_line`), the use of `create_uid`/`write_uid` audit columns, and the standard sequence-based primary key pattern (`nextval` on `_id_seq`).

## Functional process 
This table supports the manufacturing accounting process, specifically tracking Work-in-Progress (WIP) accounting entries. It records the individual line items associated with WIP accounting events, likely mapping manufacturing costs to specific general ledger accounts and currencies.

## Description
One row represents a single accounting line entry within a WIP accounting transaction. This is a raw landing table in the staging layer, capturing the state of manufacturing accounting records as they exist in the source ERP system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| account_id | INTEGER | true | Foreign key to the general ledger account | Links to the chart of accounts. |
| currency_id | INTEGER | true | Foreign key to the currency table | Defines the transaction currency. |
| wip_accounting_id | INTEGER | true | Foreign key to the parent WIP accounting header | Links line items to the main transaction. |
| create_uid | INTEGER | true | ID of the user who created the record | References the users table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the users table. |
| label | VARCHAR | true | Description or memo for the accounting line | Free-text field. |
| debit | NUMERIC | true | Debit amount | Monetary value; precision not specified in DDL. |
| credit | NUMERIC | true | Credit amount | Monetary value; precision not specified in DDL. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Record last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account.id` (Standard Odoo naming convention for GL accounts).
    - `currency_id` → `res_currency.id` (Standard Odoo naming convention for currencies).
    - `wip_accounting_id` → `mrp_account_wip_accounting.id` (Parent-child relationship inferred from naming).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit columns).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Precision:** The `debit` and `credit` columns lack explicit precision in the source DDL; verify if these are `NUMERIC(16,2)` or similar before performing aggregations.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Audit:** `create_uid` and `write_uid` should be joined against the `res_users` table to resolve human-readable usernames.