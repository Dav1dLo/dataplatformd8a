# pos_order

## Source system
This table originates from an Odoo ERP system, indicated by the characteristic naming conventions such as `pos_order`, `partner_id`, `account_move`, `fiscal_position_id`, and the use of `create_uid`/`write_uid` for audit tracking.

## Functional process 
This table supports the Point of Sale (POS) retail operations, specifically the "Order-to-Cash" process. It captures the header-level details of transactions processed at a physical or digital point of sale, including financial totals, customer identification, session tracking, and invoice status.

## Description
One row represents a single Point of Sale order header. It captures the financial summary, customer context, and state of a transaction at the grain of an individual order. This table serves as the raw landed staging entity for POS transactions within the data platform.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| user_id | INTEGER | true | ID of the user who created the order | Reference to res.users. |
| company_id | INTEGER | false | ID of the company | Multi-company context. |
| pricelist_id | INTEGER | true | ID of the applied pricelist | Determines pricing logic. |
| partner_id | INTEGER | true | ID of the customer | Reference to res.partner. |
| sequence_number | INTEGER | true | Order sequence number | Often resets per session. |
| session_id | INTEGER | false | ID of the POS session | Links to pos.session. |
| config_id | INTEGER | true | ID of the POS configuration | Defines POS settings. |
| account_move | INTEGER | true | ID of the related accounting entry | Links to account.move. |
| procurement_group_id | INTEGER | true | ID of the procurement group | Used for inventory fulfillment. |
| nb_print | INTEGER | true | Number of times printed | Receipt print count. |
| sale_journal | INTEGER | true | ID of the sales journal | Accounting journal reference. |
| fiscal_position_id | INTEGER | true | ID of the fiscal position | Tax mapping logic. |
| create_uid | INTEGER | true | Creator user ID | Audit field. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field. |
| access_token | VARCHAR | true | Security token for web access | Used for public order links. |
| name | VARCHAR | false | Order reference name | Human-readable order ID. |
| last_order_preparation_change | VARCHAR | true | Preparation change log | Kitchen/prep status. |
| state | VARCHAR | true | Order status | e.g., 'draft', 'paid', 'done'. |
| floating_order_name | VARCHAR | true | Temporary order name | Used for split/merge. |
| pos_reference | VARCHAR | true | External POS reference | System-generated reference. |
| ticket_code | VARCHAR | true | Unique ticket identifier | Used for customer lookup. |
| uuid | VARCHAR | true | Global unique identifier | Sync/integration key. |
| email | VARCHAR | true | Customer email address | PII. |
| mobile | VARCHAR | true | Customer mobile number | PII. |
| shipping_date | DATE | true | Scheduled shipping date | For delivery orders. |
| general_note | TEXT | true | Order-level comments | Free-text field. |
| amount_difference | NUMERIC | true | Discrepancy amount | Payment/total variance. |
| amount_tax | NUMERIC | false | Total tax amount | Currency units. |
| amount_total | NUMERIC | false | Total order amount | Currency units. |
| amount_paid | NUMERIC | false | Total amount paid | Currency units. |
| amount_return | NUMERIC | false | Change returned to customer | Currency units. |
| currency_rate | NUMERIC | true | Exchange rate at time of order | Used for multi-currency. |
| tip_amount | NUMERIC | true | Tip amount | Currency units. |
| to_invoice | BOOLEAN | true | Invoice requested flag | Triggers invoicing process. |
| is_tipped | BOOLEAN | true | Tip applied flag | Indicates if tip exists. |
| has_deleted_line | BOOLEAN | true | Deleted line indicator | Audit for order edits. |
| date_order | TIMESTAMP | true | Order timestamp | Transaction time. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit field. |
| write_date | TIMESTAMP | true | Record modification timestamp | Audit field. |
| employee_id | INTEGER | true | ID of the employee | POS staff reference. |
| cashier | VARCHAR | true | Cashier name | Display name of staff. |
| next_online_payment_amount | NUMERIC | true | Pending online payment | For hybrid payments. |
| crm_team_id | INTEGER | true | ID of the CRM team | Sales attribution. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `partner_id` → `res_partner.id` (Likely reference to customer master data)
    - `session_id` → `pos_session.id` (Links order to a specific POS session)
    - `company_id` → `res_company.id` (Links to organizational structure)
- **Natural keys (inferred):**
    - `name` (The human-readable order reference)
    - `uuid` (The system-wide unique identifier for synchronization)

## Caveats for downstream consumers

- **PII:** The `email` and `mobile` columns contain personal identifiable information and should be masked or restricted based on data governance policies.
- **Timestamps:** All timestamps (`date_order`, `create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a standard `active` flag; assume all rows are current unless the `state` column indicates a cancelled status.
- **Precision:** `NUMERIC` fields do not specify scale/precision in the metadata; assume standard currency precision (e.g., 2 decimal places) but verify against source samples.