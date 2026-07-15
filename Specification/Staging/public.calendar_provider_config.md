# calendar_provider_config

## Source system
The table likely originates from an Odoo ERP or a similar modular business application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of a sequence-based default for the `id` column, is highly characteristic of the Odoo framework's ORM metadata patterns.

## Functional process 
This table supports the configuration and integration management of external calendar services (such as Google Calendar or Microsoft Outlook) within the platform. It stores the necessary API credentials and synchronization status flags required to facilitate bidirectional calendar event syncing between the internal system and external providers.

## Description
One row in this table represents a specific configuration profile for an external calendar integration. It acts as a raw landed copy of the system's integration settings, storing authentication tokens and operational state flags used by the synchronization engine.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created this config. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated this config. |
| external_calendar_provider | VARCHAR | true | Provider name | Identifier for the calendar service (e.g., 'google', 'outlook'). |
| cal_client_id | VARCHAR | true | OAuth Client ID | Client identifier for general calendar API. |
| cal_client_secret | VARCHAR | true | OAuth Client Secret | Secret key for general calendar API. |
| microsoft_outlook_client_identifier | VARCHAR | true | MS Outlook Client ID | Specific client ID for Microsoft Outlook integration. |
| microsoft_outlook_client_secret | VARCHAR | true | MS Outlook Client Secret | Specific client secret for Microsoft Outlook integration. |
| cal_sync_paused | BOOLEAN | true | Sync status flag | Indicates if general calendar sync is paused. |
| microsoft_outlook_sync_paused | BOOLEAN | true | Outlook sync status flag | Indicates if Outlook-specific sync is paused. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains `cal_client_secret` and `microsoft_outlook_client_secret`. These columns contain credentials and must be masked or restricted in downstream reporting environments.
- **Timezone:** Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo-based systems, but verify against the application server configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column), which is unusual for Odoo; assume rows are hard-deleted if they disappear.
- **Data Precision:** `VARCHAR` types do not specify length; assume standard variable length but verify against source DDL if performing bulk loads.