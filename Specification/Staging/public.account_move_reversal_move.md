# account_move_reversal_move

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `account_move_reversal_move`, which is a standard join table used in Odoo's accounting module to link original journal entries with their corresponding reversal entries.

## Functional process 
This table supports the accounting audit trail and financial correction process. It maintains the relationship between an original journal entry (`move_id`) and the entry created to reverse or cancel it (`reversal_id`), ensuring that financial records can be traced back to their