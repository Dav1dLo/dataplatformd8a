# account_automatic_entry_wizard_account_move_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific wizard-to-move-line relationship is characteristic of Odoo's ORM-generated many-to-many join tables.

## Functional process 
This table supports the automated accounting entry process, specifically linking wizard instances used for adjusting entries (such as deferred revenue or expense recognition) to the specific accounting move lines being processed. It facilitates the batching of multiple move lines into a single automated adjustment operation.

## Description
One row represents a single association between an automated entry wizard instance and a specific accounting move line. It serves as a raw junction table in the staging layer, maintaining the many-to-many relationship required for the wizard to track which ledger entries are included in a specific adjustment batch.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_automatic_entry_wizard_id | INTEGER | false | Foreign key to the wizard instance | Links to the primary record of the adjustment wizard. |
| account_move_line_id | INTEGER | false | Foreign key to the accounting move line | Identifies the specific ledger entry being processed by the wizard. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(account_automatic_entry_wizard_id, account_move_line_id)`.
- **Foreign keys (inferred):**
    - `account_automatic_entry_wizard_id` → `account_automatic_entry_wizard.id` (Inferred from Odoo naming convention).
    - `account_move_line_id` → `account_move_line.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** The combination of `(account_automatic_entry_wizard_id, account_move_line_id)` acts as the unique business identifier for this relationship.

## Caveats for downstream consumers

- This is a join table; it contains no business data other than the relationship itself.
- There are no timestamps or soft-delete flags; records are typically created when the wizard is initialized and may be purged or orphaned depending on the Odoo version's cleanup logic.
- Ensure joins to `account_move_line` are handled carefully, as this table does not contain the actual financial values, only the link to them.