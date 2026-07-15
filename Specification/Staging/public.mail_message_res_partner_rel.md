# mail_message_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `mail_message_res_partner_rel` is a standard pattern used by the Odoo ORM to manage many-to-many relationships between the `mail.message` (communication logs) and `res.partner` (contacts/customers) models.

## Functional process 
This table supports the communication tracking and notification system. It maps which partners (users, customers, or vendors) are associated with specific email or internal messages, facilitating features like message threading, recipient lists, and notification routing.

## Description
One row in this table represents a single association between a specific communication message and a partner. It serves as a raw junction table in the staging layer, enabling the reconstruction of message recipient lists or message visibility for specific partners.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_message_id | INTEGER | false | Foreign key to the mail message | Links to the primary message record. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the contact or user involved in the message. |

## Keys

- **Primary key (inferred):** The combination of `(mail_message_id, res_partner_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id`: This column references the unique identifier of the message record.
    - `res_partner_id` → `res_partner.id`: This column references the unique identifier of the partner record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a many-to-many relationship between messages and partners.
- No soft-delete flags are present; this table likely reflects the current state of associations as captured by the Odoo ORM.
- Ensure joins to `mail_message` and `res_partner` are performed using inner joins if you only require records with valid, existing entities.