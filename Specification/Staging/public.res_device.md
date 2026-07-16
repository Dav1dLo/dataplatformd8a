# res_device

## Source system
The naming convention `res_device` and the presence of audit columns like `create_uid`, `write_uid`, `create_date`, and `write_date` strongly suggest this table originates from an Odoo ERP system. These patterns are characteristic of Odoo's internal ORM structure for tracking user session devices.

## Functional process 
This table supports the user authentication and security monitoring process. It tracks active or historical device sessions associated with user accounts, enabling the system to manage multi-device logins, enforce security policies, and provide audit trails for user access patterns.

## Description
One row in this table represents a unique device or browser session associated with a specific user account. It serves as a raw landed staging entity, capturing technical metadata about the client environment (IP, browser, platform) and the temporal lifecycle of the session.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely auto-incrementing integer. |
| user_id | INTEGER | true | Foreign key to the user | Links to the user account owning this device session. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| session_identifier | VARCHAR | true | Unique session token | Identifier for the specific login session. |
| platform | VARCHAR | true | Operating system | The OS platform (e.g., Windows, iOS, Linux). |
| browser | VARCHAR | true | Browser name | The web browser used for the session. |
| ip_address | VARCHAR | true | Client IP address | The source IP from which the session originated. |
| country | VARCHAR | true | Geolocation country | Country inferred from the IP address. |
| city | VARCHAR | true | Geolocation city | City inferred from the IP address. |
| device_type | VARCHAR | true | Device category | Classification of the hardware (e.g., mobile, desktop). |
| revoked | BOOLEAN | true | Revocation status | Indicates if the session has been explicitly invalidated. |
| first_activity | TIMESTAMP | true | Session start time | Timestamp of the first recorded activity for this device. |
| last_activity | TIMESTAMP | true | Session end/last time | Timestamp of the most recent activity for this device. |
| create_date | TIMESTAMP | true | Record creation time | Audit timestamp for record insertion. |
| write_date | TIMESTAMP | true | Record modification time | Audit timestamp for last record update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Standard Odoo pattern for linking session devices to user accounts).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `session_identifier` (Likely unique within the context of the application session management).

## Caveats for downstream consumers

- **PII:** The `ip_address` column is considered PII and should be masked or handled according to data privacy policies.
- **Timezone:** Timestamps are typically stored in UTC in Odoo; verify against system configuration.
- **Soft Deletes:** This table does not appear to use a `deleted_at` flag; however, the `revoked` boolean acts as a functional soft-delete for session validity.
- **Data Quality:** As a staging table, expect potential nulls in geolocation fields (`country`, `city`) if IP lookup fails.