# calendar_attendee

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date` is highly characteristic of Odoo's ORM framework, which tracks record lifecycle metadata in this specific format.

## Functional process 
This table supports the scheduling and meeting management process, specifically tracking the participation status of partners (contacts/users) in calendar events. It links external entities to specific meetings and manages their RSVP status, availability, and access permissions.

## Description
One row in this table represents a single attendee's participation record for a specific calendar event. It acts as a raw landing copy of the association between a calendar event and a partner, capturing the attendee's current status and metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.calendar_attendee_id_seq`. |
| event_id | INTEGER | false | Foreign key to the event | Links to the parent calendar event. |
| partner_id | INTEGER | false | Foreign key to the partner | Links to the contact or user attending the event. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| common_name | VARCHAR | true | Attendee display name | The name of the attendee as shown in the event. |
| access_token | VARCHAR | true | Security token | Used for external calendar synchronization or guest access. |
| state | VARCHAR | true | RSVP status | e.g., 'needsAction', 'accepted', 'declined', 'tentative'. |
| availability | VARCHAR | true | Time slot availability | Indicates if the attendee is 'busy' or 'free' during the event. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone unspecified. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone unspecified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `event_id` → `calendar_event.id` (Inferred from standard Odoo naming patterns).
    - `partner_id` → `res_partner.id` (Inferred from standard Odoo naming patterns).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** `access_token` should be treated as a secret and masked in reporting environments.
- **Timezones:** Timestamps (`create_date`, `write_date`) are provided as `TIMESTAMP` without timezone information; assume UTC unless source system configuration dictates otherwise.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are currently active unless filtered by business logic.
- **Data Quality:** The `state` and `availability` columns are `VARCHAR` and likely contain free-text or system-defined string constants; validate against distinct values before building business logic.