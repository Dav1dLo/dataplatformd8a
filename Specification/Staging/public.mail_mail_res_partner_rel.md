# mail_mail_res_partner_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `mail_mail_res_partner_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link the core messaging system (`mail_mail`) to the partner directory (`res_partner`).

## Functional process 
This table supports the communication and notification tracking process. It serves as a junction table to manage the distribution list for outgoing emails, mapping specific email records to the individual partners (customers, vendors, or internal users) intended to receive them.

## Description
One row in this table represents a single association between an email record and a partner record, indicating that a specific partner is a recipient of a specific email. As a staging table, it provides a raw, normalized link between the messaging module and the partner directory, facilitating the reconstruction of email delivery logs.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_mail_id | INTEGER | false | Foreign key to the mail_mail table | Represents the unique identifier of the email message. |
| res_partner_id | INTEGER | false | Foreign key to the res_partner table | Represents the unique identifier of the partner receiving the email. |

## Keys

- **Primary key (inferred):** The composite key `(mail_mail_id, res_partner_id)` is the inferred primary key, as this is a standard junction table structure.
- **Foreign keys (inferred):** 
    - `mail_mail_id` → `mail_mail.id`: This column references the primary email record.
    - `res_partner_id` → `res_partner.id`: This column references the partner record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or status flags present in this table; delivery status must be joined via the `mail_mail` table.
- As a staging table, it is expected to be truncated and reloaded or incrementally updated based on the source Odoo database's sync logic.
- Ensure joins to `res_partner` are handled carefully, as partners may be merged or archived in the source system.