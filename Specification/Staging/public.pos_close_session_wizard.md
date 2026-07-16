# pos_close_session_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based defaults for the primary key.

## Functional process 
This table supports the Point of Sale (POS) session management process, specifically the wizard used to close a cash register session. It captures the state of the closing operation, including any discrepancies in the balance (`amount_to_balance`) and audit metadata for the user performing the action.

## Description
One row represents a single instance of a POS session closing wizard execution. It serves as a transient staging record used to facilitate the reconciliation of cash balances before finalizing a POS session in the ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `pos_close_session_wizard_id_seq`. |
| account_id | INTEGER | true | Foreign key to the accounting account | Likely references `account.account`. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res.users`. |
| message | TEXT | true | Closing summary or error message | May contain free-text notes regarding the session. |
| account_readonly | BOOLEAN | true | Read-only flag for the account | Indicates if the account field is locked. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed; Odoo standard. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed; Odoo standard. |
| amount_to_balance | DOUBLE PRECISION | true | Discrepancy amount | The difference between expected and actual cash. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account.id` (Inferred from naming convention common in Odoo).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are stored in UTC by the Odoo framework.
- **Data Sensitivity:** `create_uid` and `write_uid` link to user identities; ensure access control is applied if joining with `res_users`.
- **Soft Deletes:** This table does not implement soft deletes; records are typically transient or permanent logs of wizard activity.
- **Precision:** `amount_to_balance` uses `DOUBLE PRECISION`, which may introduce floating-point rounding errors; cast to `NUMERIC` for financial reporting.