# mail_followers_mail_message_subtype_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific join table structure between `mail_followers` and `mail_message_subtype` is characteristic of Odoo's ORM-generated many-to-many relationship tables.

## Functional process 
This table supports the notification and subscription management process within the Odoo messaging system. It defines which specific message subtypes (e.g., "Note", "Comment", "Discussions") a follower is subscribed to, allowing for granular control over which email or system notifications a user or partner receives for a specific document.

## Description
One row in this table represents a single association between a follower record and a specific message subtype. It acts as a join table to resolve a many-to-many relationship, ensuring that followers only receive notifications for the message types they have explicitly opted into. This is a raw landed copy of the Odoo relational mapping table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_followers_id | INTEGER | false | Foreign key to the mail_followers table | Represents the unique identifier of the follower subscription. |
| mail_message_subtype_id | INTEGER | false | Foreign key to the mail_message_subtype table | Represents the specific type of message the follower is subscribed to. |

## Keys

- **Primary key (inferred):** Not confidently inferable. Odoo often uses a composite primary key on the two foreign key columns for these relationship tables.
- **Foreign keys (inferred):** 
    - `mail_followers_id` → `mail_followers.id`: Links to the follower record.
    - `mail_message_subtype_id` → `mail_message_subtype.id`: Links to the definition of the message subtype.
- **Natural keys (inferred):** The combination of `(mail_followers_id, mail_message_subtype_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only relational links.
- There are no timestamps or audit columns present in this table; it reflects the current state of the relationship as captured during the last ingestion.
- Ensure that joins to this table are handled carefully to avoid fan-out if the source system has not enforced unique constraints on the pair.
- As a staging table, this should be treated as immutable; do not attempt to infer business logic beyond the existence of the relationship itself.