# calendar_event_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific column names `res_partner_id` and `calendar_event_id` is characteristic of Odoo's automated many-to-many relationship tables used to link calendar events to business partners (contacts).

## Functional process 
This table supports the scheduling and communication process by managing the many-to-many relationship between calendar events and business partners. It tracks which contacts are invited to or associated with specific calendar events, enabling the system to render attendee lists and sync calendars for relevant stakeholders.

## Description
One row in this table represents a single association between a calendar event and a business partner. It acts as a join table in the staging layer, providing a raw, normalized link between event records and partner records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Represents the contact or user involved in the event. |
| calendar_event_id | INTEGER | false | Foreign key to the calendar event record | Represents the specific event instance. |

## Keys

- **Primary key (inferred):** The composite key `(calendar_event_id, res_partner_id)` is the inferred primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `res_partner_id` → `res_partner.id`: This column references the primary identifier of the partner/contact table.
    - `calendar_event_id` → `calendar_event.id`: This column references the primary identifier of the calendar event table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect to join this with `res_partner` and `calendar_event` to retrieve meaningful business attributes.
- There are no audit timestamps (e.g., `created_at`) in this table; it represents the current state of the relationship as captured during the last ingestion.
- Ensure that joins handle the potential for duplicate associations if the source system allows re-adding the same partner to an event without unique constraints.