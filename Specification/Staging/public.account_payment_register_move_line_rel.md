# account_payment_register_move_line_rel

## Source system
This table originates from Odoo (ERP), as indicated by the naming convention `account_payment_register_move_line_rel`, which is a standard pattern for many-to-many relationship tables in the Odoo ORM (Object-Relational Mapping) layer.

## Functional process 
This table supports the payment registration process, specifically linking payment wizard instances to the specific accounting move lines being reconciled or paid. It facilitates the "Account Receivable/Payable" settlement workflow by mapping a temporary registration session to the underlying ledger entries.

## Description
One row represents a single association between a payment registration wizard instance and a specific accounting move line. It serves as a raw landing copy of the join table used by the Odoo application to track which ledger lines are included in a bulk payment operation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| wizard_id | INTEGER | false | Foreign key to the payment registration wizard | Links to the parent wizard session. |
| line_id | INTEGER | false | Foreign key to the accounting move line | Links to the specific ledger entry being paid. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`wizard_id`, `line_id`).
- **Foreign keys (inferred):** 
    - `wizard_id` → `account_payment_register.id` (Guess: standard Odoo naming convention for wizard relations).
    - `line_id` → `account_move_line.id` (Guess: standard Odoo naming convention for ledger entries).
- **Natural keys (inferred):** The combination of (`wizard_id`, `line_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a technical join table; it contains no business logic or amounts, only identifiers.
- There are no timestamps or audit columns present in this table.
- As a staging table, it reflects the raw state of the Odoo database; ensure that downstream models handle potential orphaned records if the parent wizard or move line is deleted.