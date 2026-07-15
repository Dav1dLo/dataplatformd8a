# mail_compose_message_ir_attachments_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_ir_attachments_rel` is characteristic of Odoo's internal relational mapping tables (Many-to-Many) used to link message composition wizards to document attachments.

## Functional process 
This table supports the document management and communication module, specifically tracking which file attachments are associated with a specific email or message draft being composed via a wizard interface.

## Description
One row represents a single association between a message composition wizard instance and an attachment record. This is a raw landing of a join table, serving as the bridge to resolve the many-to-many relationship between message drafts and their attached files.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| wizard_id | INTEGER | false | Foreign key to the message composition wizard | Links to the specific wizard session. |
| attachment_id | INTEGER | false | Foreign key to the attachment record | Links to the actual file metadata. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`wizard_id`, `attachment_id`).
- **Foreign keys (inferred):** 
    - `wizard_id` → `mail_compose_message.id` (Guess: links to the parent message composition record).
    - `attachment_id` → `ir_attachment.id` (Guess: links to the standard Odoo attachment storage table).
- **Natural keys (inferred):** None. This is a pure junction table.

## Caveats for downstream consumers

- This table is a junction table; it contains no business data other than the relationship between two entities.
- There are no timestamps or audit columns; rely on the parent tables for creation/modification context.
- Ensure joins to `ir_attachment` are handled carefully, as attachments may be deleted or orphaned if the wizard session is cleared.