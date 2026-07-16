# pos_session

## Source system
This table originates from an Odoo ERP system, indicated by the naming convention of columns like `config_id`, `create_uid`, `write_uid`, and the use of sequence-based primary keys (`nextval`). The structure is characteristic of Odoo's Point of Sale (PoS) module, which tracks individual cash register sessions.

## Functional process 
This table supports the Point of Sale "Session Management" process. It tracks the lifecycle of a PoS session from opening to closing, including cash reconciliation, user assignment, and stock synchronization triggers. It serves as the central audit log for when a cashier opens a register, performs transactions, and closes the session.

## Description
One row in this table represents a single Point of Sale session, capturing the operational window, the responsible user, and the financial state of the cash register. As a staging table, it provides a raw, landed copy of the Odoo `pos.session` model, intended for downstream transformation into analytical facts regarding store performance and cash management.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| config_id | INTEGER | false | Foreign key to PoS configuration | Links to the specific PoS terminal/setup. |
| user_id | INTEGER | false | Foreign key to system user | The user who opened/managed the session. |
| sequence_number | INTEGER | true | Session sequence number | Used for internal audit tracking. |
| login_number | INTEGER | true | Login count | Tracks how many times the session was accessed. |
| cash_journal_id | INTEGER | true | Foreign key to accounting journal | The journal used for cash transactions. |
| move_id | INTEGER | true | Foreign key to accounting move | Links to the final journal entry for the session. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| access_token | VARCHAR | true | Security token | Used for external session authentication. |
| name | VARCHAR | false | Session identifier | Human-readable name (e.g., "POS/2023/001"). |
| state | VARCHAR | false | Session status | Current lifecycle stage (e.g., 'opening', 'opened', 'closing', 'closed'). |
| opening_notes | TEXT | true | Opening remarks | Notes entered by the user at session start. |
| closing_notes | TEXT | true | Closing remarks | Notes entered by the user at session end. |
| cash_register_balance_end_real | NUMERIC | true | Ending cash balance | Actual cash counted at session close. |
| cash_register_balance_start | NUMERIC | true | Starting cash balance | Initial cash amount in the register. |
| cash_real_transaction | NUMERIC | true | Net cash transactions | Total cash movement during the session. |
| rescue | BOOLEAN | true | Rescue flag | Indicates if the session was recovered from a crash. |
| update_stock_at_closing | BOOLEAN | true | Stock sync flag | Whether inventory is updated upon session closure. |
| start_at | TIMESTAMP | true | Session start time | Timestamp when the session was opened. |
| stop_at | TIMESTAMP | true | Session end time | Timestamp when the session was closed. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time in the database. |
| write_date | TIMESTAMP | true | Last update timestamp | Last modification time in the database. |
| employee_id | INTEGER | true | Foreign key to employee | The specific employee assigned to the session. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `config_id` → `pos_config.id` (Inferred from Odoo standard naming)
    - `user_id` → `res_users.id` (Inferred from Odoo standard naming)
    - `cash_journal_id` → `account_journal.id` (Inferred from Odoo standard naming)
    - `move_id` → `account_move.id` (Inferred from Odoo standard naming)
    - `employee_id` → `hr_employee.id` (Inferred from Odoo standard naming)
- **Natural keys (inferred):** 
    - `name` (Odoo session names are typically unique within a database instance)

## Caveats for downstream consumers

- **Sensitive Data:** Contains `user_id` and `employee_id` which may be linked to PII in other tables.
- **Timezone:** Timestamps (`start_at`, `stop_at`) are typically stored in UTC in Odoo, but verify against application settings.
- **Soft Deletes:** Odoo generally does not use soft deletes; records are usually permanent unless purged.
- **Precision:** `NUMERIC` types do not specify scale/precision in the schema; assume standard currency precision (e.g., 2 decimal places) but validate against actual data samples.