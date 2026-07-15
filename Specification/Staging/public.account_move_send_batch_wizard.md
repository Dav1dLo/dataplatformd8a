# account_move_send_batch_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention `account_move_send_batch_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's transient model architecture used for UI-driven batch processing.

## Functional process 
This table supports the "Accounts Receivable/Payable" billing process, specifically the batch processing of accounting entries (invoices or payments). It acts as a temporary state holder for the wizard interface that allows users to select multiple account moves to be sent (e.g., via email or print) in a single operation.

## Description
One row represents a single execution instance of the batch sending wizard for accounting moves. It serves as a raw landed copy of the transient state data used during the user's interaction with the batch processing interface in the Odoo application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the wizard session. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the wizard state. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of when the wizard session was initialized. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification to the wizard session. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table represents a "transient" model in Odoo; data here is often short-lived and may be purged by the application after the wizard process completes.
- Timestamps (`create_date`, `write_date`) are stored in UTC by default in Odoo.
- No PII is explicitly present in these columns, but downstream joins to `res_users` may expose user identity information.
- The table does not contain the actual business data (the account moves themselves); it only tracks the metadata of the wizard session.