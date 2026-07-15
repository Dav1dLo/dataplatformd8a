# account_move_line

## Source system
This table originates from Odoo ERP. The naming convention (`account_move_line`, `move_id`, `partner_id`, `analytic_distribution`) and the specific structure of accounting entries are characteristic of the Odoo accounting module.

## Functional process 
This table supports the General Ledger and sub-ledger accounting processes. It records the individual line items that constitute an accounting entry (`move_id`), tracking debits, credits, balances, and tax implications across various accounts, partners, and products.

## Description
One row represents a single accounting entry line within a journal entry. It captures the financial impact of a transaction at the most granular level, including currency details, tax calculations, and reconciliation status. This is a raw landed copy of the Odoo database table, serving as the primary source for financial reporting and ledger analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| move_id | INTEGER | false | Foreign key to account_move | Links to the parent journal entry. |
| journal_id | INTEGER | true | Foreign key to account_journal | The journal this line belongs to. |
| company_id | INTEGER | true | Foreign key to res_company | The company associated with the entry. |
| company_currency_id | INTEGER | true | Foreign key to res_currency | The base currency of the company. |
| sequence | INTEGER | true | Display sequence | Used for ordering lines within a move. |
| account_id | INTEGER | true | Foreign key to account_account | The GL account affected. |
| currency_id | INTEGER | false | Foreign key to res_currency | The transaction currency. |
| partner_id | INTEGER | true | Foreign key to res_partner | The customer or vendor involved. |
| reconcile_model_id | INTEGER | true | Foreign key to account_reconcile_model | Model used for auto-reconciliation. |
| payment_id | INTEGER | true | Foreign key to account_payment | Links to a specific payment record. |
| statement_line_id | INTEGER | true | Foreign key to account_bank_statement_line | Links to bank statement line. |
| statement_id | INTEGER | true | Foreign key to account_bank_statement | Links to bank statement header. |
| group_tax_id | INTEGER | true | Foreign key to account_tax_group | Tax group identifier. |
| tax_line_id | INTEGER | true | Foreign key to account_tax | Specific tax line reference. |
| tax_group_id | INTEGER | true | Foreign key to account_tax_group | Grouping for tax reporting. |
| tax_repartition_line_id | INTEGER | true | Foreign key to account_tax_repartition_line | Tax repartition logic. |
| full_reconcile_id | INTEGER | true | Foreign key to account_full_reconcile | Links to a full reconciliation set. |
| product_id | INTEGER | true | Foreign key to product_product | The product involved in the transaction. |
| product_uom_id | INTEGER | true | Foreign key to uom_uom | Unit of measure. |
| create_uid | INTEGER | true | Creator user ID | Reference to res_users. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to res_users. |
| move_name | VARCHAR | true | Move display name | Human-readable move identifier. |
| parent_state | VARCHAR | true | Status of parent move | e.g., 'draft', 'posted'. |
| ref | VARCHAR | true | Reference | User-provided reference string. |
| name | VARCHAR | true | Line description | Label or description of the line. |
| matching_number | VARCHAR | true | Reconciliation matching code | Identifier for reconciled items. |
| display_type | VARCHAR | false | Line type | e.g., 'product', 'tax', 'line'. |
| date | DATE | true | Accounting date | The date the entry is effective. |
| invoice_date | DATE | true | Invoice date | Date of the associated invoice. |
| date_maturity | DATE | true | Maturity date | Due date for payment. |
| discount_date | DATE | true | Discount date | Date for early payment discount. |
| analytic_distribution | JSONB | true | Analytic distribution | JSON mapping for analytic accounts. |
| debit | NUMERIC | true | Debit amount | Amount in company currency. |
| credit | NUMERIC | true | Credit amount | Amount in company currency. |
| balance | NUMERIC | true | Net balance | Calculated as debit - credit. |
| amount_currency | NUMERIC | true | Amount in transaction currency | Value in foreign currency. |
| tax_base_amount | NUMERIC | true | Tax base amount | Amount used to calculate tax. |
| amount_residual | NUMERIC | true | Residual amount | Remaining balance to be paid. |
| amount_residual_currency | NUMERIC | true | Residual amount in currency | Remaining balance in foreign currency. |
| quantity | NUMERIC | true | Quantity | Number of units. |
| price_unit | NUMERIC | true | Unit price | Price per unit. |
| price_subtotal | NUMERIC | true | Subtotal | Line total before tax. |
| price_total | NUMERIC | true | Total price | Line total including tax. |
| discount | NUMERIC | true | Discount percentage | Percentage applied. |
| discount_amount_currency | NUMERIC | true | Discount amount in currency | Absolute discount value. |
| discount_balance | NUMERIC | true | Discount balance | Discount in company currency. |
| is_imported | BOOLEAN | true | Import flag | True if record was imported. |
| tax_tag_invert | BOOLEAN | true | Tax tag inversion | Used for tax reporting logic. |
| reconciled | BOOLEAN | true | Reconciliation status | True if fully reconciled. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| purchase_line_id | INTEGER | true | Foreign key to purchase_order_line | Links to purchase order line. |
| is_downpayment | BOOLEAN | true | Downpayment flag | Indicates if line is a downpayment. |
| cogs_origin_id | INTEGER | true | COGS origin ID | Links to cost of goods sold source. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `move_id` → `account_move.id` (Links to the parent accounting entry).
    - `account_id` → `account_account.id` (Links to the general ledger account).
    - `partner_id` → `res_partner.id` (Links to the business partner).
    - `product_id` → `product_product.id` (Links to the product catalog).
- **Natural keys (inferred):**
    - Not confidently inferable; Odoo relies on internal surrogate IDs for relational integrity.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `partner_id` and potentially PII in the `name` or `ref` fields.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC.
- **Soft Deletes:** Odoo typically does not use soft deletes in this table; records are usually immutable once posted.
- **Precision:** `NUMERIC` fields are used for financial accuracy; ensure downstream systems maintain this precision to avoid rounding errors.
- **JSONB:** `analytic_distribution` requires specific PostgreSQL JSONB handling for extraction.