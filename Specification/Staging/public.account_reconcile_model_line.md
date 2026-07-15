# account_reconcile_model_line

## Source system
This table originates from Odoo (ERP), as evidenced by the naming convention (`account_reconcile_model_line`), the use of `create_uid`/`write_uid` audit columns, and the presence of `JSONB` fields for flexible configuration like `analytic_distribution` and `label`.

## Functional process 
This table supports the automated bank reconciliation process. It defines the specific accounting lines (e.g., tax adjustments, fee deductions, or analytic allocations) that should be automatically generated when a bank statement line is matched against a reconciliation model.

## Description
One row represents a single line item configuration within a bank reconciliation model. It defines how a specific portion of a transaction amount should be distributed or accounted for during the reconciliation process. This is a raw landed copy of the Odoo staging table, capturing the configuration state for automated accounting entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| model_id | INTEGER | true | Foreign key to the parent reconciliation model | Links to `account_reconcile_model`. |
| company_id | INTEGER | true | Multi-company identifier | Links to `res_company`. |
| sequence | INTEGER | false | Display/execution order | Determines priority of application. |
| account_id | INTEGER | true | Target general ledger account | Links to `account_account`. |
| journal_id | INTEGER | true | Target journal | Links to `account_journal`. |
| create_uid | INTEGER | true | Creator user ID | Links to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res_users`. |
| amount_type | VARCHAR | false | Type of amount calculation | e.g., 'fixed', 'percentage', 'regex'. |
| amount_string | VARCHAR | false | Calculation expression | Stores the value or formula for the line. |
| analytic_distribution | JSONB | true | Analytic accounting distribution | Maps amounts to analytic accounts. |
| label | JSONB | true | Default label for the entry | Often contains multi-language strings. |
| force_tax_included | BOOLEAN | true | Tax inclusion flag | Forces tax calculation logic. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| amount | DOUBLE PRECISION | true | Fixed amount value | Used when `amount_type` is fixed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `model_id` → `account_reconcile_model.id` (Parent configuration entity)
    - `company_id` → `res_company.id` (Multi-tenant isolation)
    - `account_id` → `account_account.id` (Target GL account)
    - `journal_id` → `account_journal.id` (Target journal)
    - `create_uid` / `write_uid` → `res_users.id` (Audit trail)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **JSONB:** The `analytic_distribution` and `label` columns contain nested structures; ensure your downstream transformation layer handles JSON parsing (e.g., `->>` or `jsonb_to_recordset` in PostgreSQL).
- **Soft Deletes:** This table does not appear to implement a `deleted_at` flag; standard Odoo behavior is hard deletion.
- **Data Integrity:** `amount_string` is a `VARCHAR` but may contain numeric strings or complex regex patterns depending on the `amount_type`.