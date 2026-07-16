# mail_template_mail_template_reset_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables (link tables) between two entities, in this case, `mail_template` and `mail_template_reset`.

## Functional process 
This table supports the email notification and password reset management process. It maintains the association between specific email templates and the reset configurations or triggers they are linked to, ensuring the correct template is utilized when a system-generated reset email is dispatched.

## Description
One row in this table represents a single association between a mail template and a reset configuration. It is a raw landing copy of a join table, serving as the bridge to resolve the many-to-many relationship between the two entities in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_template_reset_id | INTEGER | false | Foreign key to the reset configuration | Links to the primary key of the reset entity. |
| mail_template_id | INTEGER | false | Foreign key to the mail template | Links to the primary key of the mail template entity. |

## Keys

- **Primary key (inferred):** The composite of (`mail_template_reset_id`, `mail_template_id`).
- **Foreign keys (inferred):**
    - `mail_template_reset_id` → `mail_template_reset.id`: Guessed based on the column name suffix matching the target table.
    - `mail_template_id` → `mail_template.id`: Guessed based on the column name suffix matching the target table.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a link table; queries should expect to join this with both `mail_template` and `mail_template_reset` to retrieve meaningful business data.
- No audit timestamps or soft-delete flags are present; this table reflects the current state of associations as captured during the last ingestion.
- As a join table, it contains no PII, but it should be treated as sensitive metadata regarding system configuration.