# calendar_provider_config

## Source system
This table originates from an Odoo ERP instance, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys (`nextval` on `id`).

## Functional process 
This table supports the integration and synchronization process between the ERP and external calendar services. It stores the authentication credentials and synchronization status flags required for the system to interface with Google Calendar and Microsoft Outlook APIs.

## Description
One row in this table represents a specific configuration profile for an external calendar provider linked to the ERP. It serves as a raw landing copy of the configuration settings, including OAuth client identifiers and secrets, used to manage the state of calendar synchronization.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user table. |
| external_calendar_provider | VARCHAR | true | Name of the calendar provider | e.g., 'google', 'outlook'. |
| cal_client_id | VARCHAR | true | OAuth client ID for general calendar | Used for API authentication. |
| cal_client_secret | VARCHAR | true | OAuth client secret for general calendar | Sensitive: contains credentials. |
| microsoft_outlook_client_identifier | VARCHAR | true | Microsoft-specific OAuth client ID | Used for Outlook API authentication. |
| microsoft_outlook_client_secret | VARCHAR | true | Microsoft-specific OAuth client secret | Sensitive: contains credentials. |
| cal_sync_paused | BOOLEAN | true | Sync status for general calendar | True if synchronization is disabled. |
| microsoft_outlook_sync_paused | BOOLEAN | true | Sync status for Outlook | True if synchronization is disabled. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** `cal_client_secret` and `microsoft_outlook_client_secret` contain plain-text credentials and must be masked or restricted in downstream reporting.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the application logic.
- **Data Quality:** As a staging table, this contains raw configuration values; verify if `VARCHAR` fields have length constraints in the source DDL if performing bulk loads.