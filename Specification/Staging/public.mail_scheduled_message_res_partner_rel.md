# mail_scheduled_message_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `mail_scheduled_message` and `res_partner` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link messaging objects to business partners.

## Functional process 
This table supports the communication and notification management process. It acts as a junction table to track which business partners (contacts, customers, or vendors) are associated with specific scheduled email or message records, likely for tracking recipients or distribution lists.

## Description
One row in this table represents a single association between a scheduled message and a partner. It serves as a raw landing copy of the relationship mapping, facilitating the resolution of many-to-many links between the messaging module and the partner directory.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_scheduled_message_id | INTEGER | false | Foreign key to the scheduled message record | Links to the primary message entity. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the contact/partner entity. |

## Keys

- **Primary key (inferred):** The combination of (`mail_scheduled_message_id`, `res_partner_id`) is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `mail_scheduled_message_id` → `mail_scheduled_message.id`: This column references the parent message record.
    - `res_partner_id` → `res_partner.id`: This column references the partner/contact record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect high cardinality and frequent joins to the parent tables.
- There is no surrogate primary key; ensure joins use both columns to maintain uniqueness.
- As a staging table, this may contain orphaned records if the parent `mail_scheduled_message` or `res_partner` records have been purged without cascading deletes.