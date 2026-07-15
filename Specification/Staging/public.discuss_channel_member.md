# discuss_channel_member

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`partner_id`, `create_uid`, `write_date`) and the use of sequence-based primary keys (`nextval('"public".discuss_channel_member_id_seq'::regclass)`).

## Functional process 
This table supports the internal communication and collaboration module within the ERP. It manages the membership state of users (partners or guests) within specific communication channels, tracking read receipts, notification preferences, and UI states like fold status or muting.

## Description
One row represents a single membership association between a user (represented by `partner_id` or `guest_id`) and a communication channel (`channel_id`). This is a raw staging table containing the current state of channel memberships, including metadata for message tracking and user-specific channel configurations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| partner_id | INTEGER | true | ID of the internal user/partner | Foreign key to `res_partner`. |
| guest_id | INTEGER | true | ID of the external guest user | Foreign key to `mail_guest`. |
| channel_id | INTEGER | false | ID of the communication channel | Foreign key to `discuss_channel`. |
| fetched_message_id | INTEGER | true | Last message ID fetched by user | Used for UI message loading. |
| seen_message_id | INTEGER | true | Last message ID seen by user | Used for read receipt tracking. |
| new_message_separator | INTEGER | false | ID of the message separator | Marks the "new message" line in UI. |
| rtc_inviting_session_id | INTEGER | true | RTC session ID | Relates to active voice/video calls. |
| create_uid | INTEGER | true | User ID who created the record | Audit field. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit field. |
| custom_channel_name | VARCHAR | true | User-defined channel alias | Overrides default channel name. |
| fold_state | VARCHAR | true | UI fold status | e.g., 'open', 'folded', 'closed'. |
| custom_notifications | VARCHAR | true | Notification preference setting | e.g., 'all', 'mention', 'mute'. |
| mute_until_dt | TIMESTAMP | true | Mute expiration timestamp | UTC assumed. |
| unpin_dt | TIMESTAMP | true | Unpin timestamp | UTC assumed. |
| last_interest_dt | TIMESTAMP | true | Last interaction timestamp | UTC assumed. |
| last_seen_dt | TIMESTAMP | true | Last read/seen timestamp | UTC assumed. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo naming for partner associations).
    - `guest_id` → `mail_guest.id` (Standard Odoo naming for guest associations).
    - `channel_id` → `discuss_channel.id` (Standard Odoo naming for channel associations).
- **Natural keys (inferred):** 
    - (`channel_id`, `partner_id`) or (`channel_id`, `guest_id`) — A user/guest can only be a member of a channel once.

## Caveats for downstream consumers

- **Timestamps:** All `_dt` and `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **PII:** `partner_id` and `guest_id` link to identity tables; ensure appropriate access controls are applied when joining to user-identifiable information.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely physically removed upon leaving a channel.
- **Nullability:** `partner_id` and `guest_id` are both nullable, implying a row represents either an internal partner or an external guest, but rarely both simultaneously.