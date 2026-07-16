# scheduled_message_attachment_rel

## Source system
The table likely originates from a custom-built application or a messaging platform backend. The naming convention `_rel` strongly suggests a junction table used to manage a many-to-many relationship between scheduled messages and their associated file attachments within a relational database.

## Functional process 
This table supports the message scheduling and delivery pipeline. It acts as a bridge to associate multiple media or document attachments with a single scheduled message, ensuring that when the message is triggered, the correct assets are retrieved and attached to the outgoing communication.

## Description
One row in this table represents a single association between a specific scheduled message and a specific attachment. It serves as a raw landing copy of the join table, maintaining the link between the message entity and the file entity at the grain of one row per unique relationship.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| scheduled_message_id | INTEGER | false | Foreign key to the scheduled message. | Links to the parent message record. |
| attachment_id | INTEGER | false | Foreign key to the attachment record. | Links to the specific file or asset record. |

## Keys

- **Primary key (inferred):** Composite key of (`scheduled_message_id`, `attachment_id`).
- **Foreign keys (inferred):** 
    - `scheduled_message_id` → `scheduled_messages.id` (inferred as the parent entity for the message).
    - `attachment_id` → `attachments.id` (inferred as the parent entity for the file/asset).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume that the removal of a row in this table represents the permanent deletion of the association in the source system.
- Ensure that joins to parent tables handle potential orphaned records if referential integrity is not strictly enforced at the source.