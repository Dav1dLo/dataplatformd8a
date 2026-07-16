# mail_message_res_partner_starred_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `mail_message` and `res_partner` is characteristic of Odoo's automated many-to-many relationship tables used to track message-specific flags.

## Functional process 
This table supports the internal communication and notification system within the ERP. It specifically tracks which users (represented by `res_partner`) have "starred" or "favorited" specific system messages (`mail_message`), facilitating the "Starred" filter functionality in the user's inbox or notification center.

## Description
Each row represents a single association between a message and a partner, indicating that the partner has marked the message as starred. This is a raw landing table representing a many-to-many join relationship in the source database, used to maintain the state of user-specific message flags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_message_id | INTEGER | false | Foreign key to the mail message | Links to the primary message record. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Identifies the user/partner who starred the message. |

## Keys

- **Primary key (inferred):** The combination of `(mail_message_id, res_partner_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id`: Links to the specific message being starred.
    - `res_partner_id` → `res_partner.id`: Links to the partner who performed the action.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no timestamps or status flags, only the existence of the relationship.
- There is no surrogate primary key; queries should join or filter using the composite key `(mail_message_id, res_partner_id)`.
- The table does not contain PII directly, but it links sensitive communication records to specific partners.
- As a staging table, it reflects the raw state of the Odoo database; if a user un-stars a message, the row is typically deleted from this table.