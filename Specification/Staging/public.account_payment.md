# account_payment

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `move_id`, `journal_id`, `partner_id`, `create_uid`) and the specific structure of payment-related fields are characteristic of the Odoo accounting and POS modules.

## Functional process 
This table supports the accounts receivable and accounts payable processes, including internal transfers and Point of Sale (POS) payment tracking. It captures the lifecycle of a payment from initiation to reconciliation, linking financial transactions to specific journals, partners, and accounting moves.

## Description
One row in this table represents a single payment record, which may be a customer payment, a vendor payment, or an internal transfer. It acts as a raw landing copy of the Odoo `account.payment` model, capturing the financial amount, status, and associated accounting entities at the grain of an individual payment transaction.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_payment_id_seq`. |
| message_main_attachment_id | INTEGER | true | Link to primary attachment | Foreign key to `ir_attachment`. |
| move_id | INTEGER | true | Associated accounting entry | Foreign key to `account_move`. |
| journal_id | INTEGER | false | Payment journal | Foreign key to `account_journal`. |
| company_id | INTEGER | false | Owning company | Foreign key to `res_company`. |
| partner_bank_id | INTEGER | true | Bank account used | Foreign key to `res_partner_bank`. |
| paired_internal_transfer_payment_id | INTEGER |