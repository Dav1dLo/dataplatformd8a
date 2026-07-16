# mail_wizard_invite_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific association of `mail_wizard_invite` and `res_partner` is characteristic of Odoo's automated many-to-many relationship tables generated for ORM models.

## Functional process 
This table supports the communication and notification module, specifically tracking the association between email invitation wizards and the business partners (contacts) targeted by those invitations. It facilitates the "Invite to document" or "Mass mailing" business processes where a user triggers an invitation wizard to notify multiple partners.

## Description
One row in this table represents a single link between a specific mail invitation wizard instance and a partner record. It serves as a raw landing copy of the join table used to resolve many-to-many relationships in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_wizard_invite_id | INTEGER | false | Foreign key to the mail invitation wizard | Links to the parent invitation event. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the specific contact being invited. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`mail_wizard_invite_id`, `res_partner_id`).
- **Foreign keys (inferred):** 
    - `mail_wizard_invite_id` → `mail_wizard_invite.id` (Inferred from Odoo naming convention).
    - `res_partner_id` → `res_partner.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** The combination of (`mail_wizard_invite_id`, `res_partner_id`) acts as the natural key for this relationship.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the sequence of events from this table alone.
- Ensure inner joins are used when resolving these IDs to parent tables to avoid orphaned records if the source system has inconsistent referential integrity.