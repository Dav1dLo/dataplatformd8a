# account_bank_statement_ir_attachment_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_ir_attachment_rel` is a standard pattern used by the Odoo ORM to manage many-to-many relationship tables (link tables) between business objects (in this case, bank statements) and the internal attachment registry (`ir_attachment`).

## Functional process 
This table supports the document management process within the accounting module. It links specific bank statement records to their corresponding digital files (such as PDF scans or CSV imports) stored in the system's attachment repository.

## Description
One row in this table represents a single association between a bank statement record and an attachment record. It serves as a raw junction table in the staging layer, enabling the reconstruction of many-to-many relationships between financial documents and their supporting files.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_bank_statement_id | INTEGER | false | Foreign key to the bank statement | References the primary key of the bank statement table. |
| ir_attachment_id | INTEGER | false | Foreign key to the attachment registry | References the primary key of the `ir_attachment` table. |

## Keys

- **Primary key (inferred):** The combination of `(account_bank_statement_id, ir_attachment_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `account_bank_statement_id` → `account_bank_statement.id`: Links to the specific bank statement record.
    - `ir_attachment_id` → `ir_attachment.id`: Links to the specific file metadata record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship itself.
- Expect no soft-delete flags; in Odoo, relationship records are typically hard-deleted when the association is removed.
- Ensure joins to this table are handled as a composite key to avoid fan-out issues.