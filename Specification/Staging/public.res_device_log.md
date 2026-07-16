# res_device_log

## Source system
The table likely originates from an Odoo ERP instance, indicated by the naming convention of `res_` prefixing (common in Odoo's `res_` modules) and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports user session management and security auditing. It tracks device-specific access patterns, including geolocation, browser/platform metadata, and session activity timestamps, which are used to monitor user logins and enforce session revocation policies.

## Description
One row in this table represents a unique device or session entry associated with a user account. It serves as a raw landing copy of device-level activity logs, capturing the technical environment and temporal bounds of user interactions within the application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo. |
| user_id | INTEGER | true | Foreign key to the user | Links to the system user account. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| session_identifier | VARCHAR | false | Unique session token | The primary identifier for the device session. |
| platform | VARCHAR | true | Operating system | e.g., Windows, iOS, Android. |
| browser | VARCHAR | true | Browser name | e.g., Chrome, Firefox, Safari. |
| ip_address | VARCHAR | true | Source IP address | The network address of the device. |
| country | VARCHAR | true | ISO country code | Geolocation derived from IP. |
| city | VARCHAR | true | City name | Geolocation derived from IP. |
| device_type | VARCHAR | true | Device category | e.g., Desktop, Mobile, Tablet. |
| revoked | BOOLEAN | true | Revocation status | Flag indicating if the session is disabled. |
| first_activity | TIMESTAMP | true | Session start time | Timestamp of the first recorded activity. |
| last_activity | TIMESTAMP | true | Session end time | Timestamp of the most recent activity. |
| create_date | TIMESTAMP | true | Record creation date | Audit timestamp for record insertion. |
| write_date | TIMESTAMP | true | Record modification date | Audit timestamp for last update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: Standard Odoo pattern for user association).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit column).
- **Natural keys (inferred):** 
    - `session_identifier` (Likely unique per session context).

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `ip_address` column is considered PII and should be masked or handled according to GDPR/privacy policies.
- **Timezone:** Timestamps are typically stored in UTC in Odoo environments; verify against application settings.
- **Soft Deletes:** This table does not appear to use a soft-delete flag; however, the `revoked` boolean acts as a functional filter for active sessions.
- **Data Quality:** `VARCHAR` columns lack defined lengths; expect variable string sizes based on user-agent strings and network data.