# account_reconcile_model

## Source system
This table originates from Odoo (ERP), as evidenced by the naming convention (`account_reconcile_model`), the use of `create_uid`/`write_uid` for audit tracking, and the `JSONB` type for the `name` column, which is characteristic of Odoo's multi-language field storage.

## Functional process 
This table supports the automated bank and account reconciliation process. It defines the rules and criteria used by the system to automatically match bank statement lines against open invoices or journal entries, reducing manual accounting workload.

## Description
One row represents a single reconciliation rule or model configured within the accounting module. It defines the logic for matching criteria (such as labels, amounts, or transaction types) and the associated tolerances for automatic reconciliation. This is a raw landed copy of the Odoo configuration table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | false | Execution order | Determines priority of rule application. |
| company_id | INTEGER | false | Company identifier | Foreign key to the owning company. |
| past_months_limit | INTEGER | true | Lookback window | Number of months to search for matches. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the rule. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the rule. |
| rule_type | VARCHAR | false | Rule category | Defines if the rule is for 'writeoff' or 'invoice_matching'. |
| matching_order | VARCHAR | false | Matching strategy | Defines the order of operations for matching. |
| counterpart_type | VARCHAR | true | Counterpart account type | Type of account for reconciliation entries. |
| match_nature | VARCHAR | false | Matching criteria type | Logic for matching (e.g., 'amount_between'). |
| match_amount | VARCHAR | true | Amount matching logic | Specific logic for amount comparison. |
| match_label | VARCHAR | true | Label matching logic | Logic for matching transaction labels. |
| match_label_param | VARCHAR | true | Label parameter | Value used for label matching. |
| match_note | VARCHAR | true | Note matching logic | Logic for matching transaction notes. |
| match_note_param | VARCHAR | true | Note parameter | Value used for note matching. |
| match_transaction_type | VARCHAR | true | Transaction type logic | Logic for matching transaction types. |
| match_transaction_type_param | VARCHAR | true | Transaction type parameter | Value used for transaction type matching. |
| payment_tolerance_type | VARCHAR | false | Tolerance type | 'percentage' or 'amount'. |
| decimal_separator | VARCHAR | true | Decimal separator | Character used for amount parsing. |
| name | JSONB | false | Rule name | Multi-language label for the rule. |
| active | BOOLEAN | true | Active status | Soft-delete flag. |
| auto_reconcile | BOOLEAN | true | Auto-reconcile flag | If true, system attempts auto-matching. |
| to_check | BOOLEAN | true | Review flag | If true, marks matched items for manual review. |
| match_text_location_label | BOOLEAN | true | Search in label | Whether to search in transaction labels. |
| match_text_location_note | BOOLEAN | true | Search in note | Whether to search in transaction notes. |
| match_text_location_reference | BOOLEAN | true | Search in reference | Whether to search in transaction references. |
| match_same_currency | BOOLEAN | true | Currency constraint | If true, requires matching currencies. |
| allow_payment_tolerance | BOOLEAN | true | Tolerance enabled | Whether payment tolerance is allowed. |
| match_partner | BOOLEAN | true | Partner matching | Whether to enforce partner matching. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Modification timestamp | UTC timestamp of last update. |
| match_amount_min | DOUBLE PRECISION | true | Minimum amount | Lower bound for amount matching. |
| match_amount_max | DOUBLE PRECISION | true | Maximum amount | Upper bound for amount matching. |
| payment_tolerance_param | DOUBLE PRECISION | true | Tolerance value | Numerical value for tolerance. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but contains configuration logic that may reveal internal accounting processes.
- **Timestamps:** Assumed to be in UTC as per Odoo standard behavior.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should typically filter by `WHERE active = TRUE`.
- **JSONB:** The `name` column is a `JSONB` object; use `name->>'en_US'` or similar to extract specific language values.
- **Precision:** `match_amount_min`/`max` and `payment_tolerance_param` are `DOUBLE PRECISION`; be aware of potential floating-point arithmetic issues when comparing currency values.