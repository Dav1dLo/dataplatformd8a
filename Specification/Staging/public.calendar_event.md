# calendar_event

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the characteristic naming conventions such as `res_id`, `res_model`, `create_uid`, and `write_uid`, which are standard patterns for Odoo's ORM-based data structures.

## Functional process 
This table supports the scheduling and resource management process, likely within a CRM or project management module. It tracks calendar events, including meetings, video calls, and their associations with other business objects (like opportunities or specific models) via the `res_id` and `res_model` fields.

## Description
One row in this table represents a single calendar event or appointment, including its temporal boundaries, location, and privacy settings. It serves as a raw landed copy of the Odoo `calendar.event` model, capturing both standalone events and instances within a recurring series.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| user_id | INTEGER | true | Owner user ID | References the user who owns the event. |
| videocall_channel_id | INTEGER | true | Video call channel ID | Link to external video conferencing platform. |
| res_id | INTEGER | true | Related resource ID | ID of the record this event is linked to. |
| res_model_id | INTEGER | true | Related model ID | ID of the Odoo model this event is linked to. |
| recurrence_id | INTEGER | true | Recurrence group ID | Links events belonging to the same recurring series. |
| create_uid | INTEGER | true | Creator user ID | User who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | User who last updated the record. |
| name | VARCHAR | false | Event title | The subject or title of the event. |
| location | VARCHAR | true | Physical location | Physical address or room name. |
| videocall_location | VARCHAR | true | Virtual meeting URL | URL for virtual meetings. |
| access_token | VARCHAR | true | Security token | Token for external calendar sharing. |
| privacy | VARCHAR | true | Privacy level | e.g., 'public', 'private', 'confidential'. |
| show_as | VARCHAR | false | Availability status | e.g., 'busy', 'free'. |
| res_model | VARCHAR | true | Related model name | Technical name of the related Odoo model. |
| start_date | DATE | true | Start date | Used for all-day events. |
| stop_date | DATE | true | End date | Used for all-day events. |
| description | TEXT | true | Event details | Rich text or plain text description. |
| active | BOOLEAN | true | Soft-delete flag | False if the event is archived. |
| allday | BOOLEAN | true | All-day event flag | Indicates if the event spans the full day. |
| recurrency | BOOLEAN | true | Recurring flag | Indicates if the event repeats. |
| follow_recurrence | BOOLEAN | true | Follow recurrence flag | Logic flag for recurring event handling. |
| start | TIMESTAMP | false | Start datetime | Start time of the event. |
| stop | TIMESTAMP | false | End datetime | End time of the event. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit timestamp. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit timestamp. |
| duration | DOUBLE PRECISION | true | Duration | Event duration, usually in hours. |
| opportunity_id | INTEGER | true | Opportunity ID | Link to a specific CRM opportunity. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Standard Odoo user reference)
    - `opportunity_id` → `crm_lead.id` (Standard Odoo CRM reference)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `description` and `name` fields may contain PII or sensitive business information.
- **Timezones:** Timestamps (`start`, `stop`) are typically stored in UTC in Odoo, but verify against the application server configuration.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE`.
- **Data Types:** `VARCHAR` lengths are not specified in the source; downstream systems should handle variable-length strings appropriately.