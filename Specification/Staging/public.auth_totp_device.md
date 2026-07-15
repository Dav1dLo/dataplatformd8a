# auth_totp_device

## Source system
This table originates from an internal authentication or identity management service, likely a custom-built application or a framework-integrated module (such as Supabase Auth or a similar PostgreSQL-based identity provider) that manages multi-factor authentication (MFA) devices for users.

## Functional process 
This table supports the MFA management process, specifically tracking time-based one-time password (TOTP) devices registered to user accounts. It facilitates the verification of authentication tokens during the login flow by storing the shared secret keys and device metadata required to validate user-provided codes.

## Description
One row in this table represents a single registered TOTP MFA device associated with a specific user. It serves as a raw landed copy of the authentication device configuration, used to verify identity during the login process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| name | VARCHAR | false | Human-readable device name | Assigned by the user to identify the device. |
| user_id | INTEGER | false | Foreign key to user | Links the device to the owner. |
| scope | VARCHAR | true | Authentication scope | Defines the permissions or context for the device. |
| expiration_date | TIMESTAMP | true | Device expiry timestamp | The date/time when the device registration expires. |
| index | VARCHAR(8) | true | Device index/identifier | Short identifier for the device, often used in UI. |
| key | VARCHAR | true | Shared secret key | The base32 encoded secret used to generate TOTP codes. |
| create_date | TIMESTAMP | true | Record creation timestamp | Defaults to UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `public.users.id` (Guess: standard naming convention for user-linked tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `key` column contains the shared secret for MFA; this must be masked or restricted to authorized security services only.
- **Timezone:** `create_date` is explicitly set to UTC. Assume `expiration_date` is also stored in UTC, but verify against application logic.
- **Data Integrity:** The `key` column is nullable, which may indicate devices that are pending setup or have been disabled.
- **Soft Deletes:** There is no explicit `is_deleted` or `deleted_at` column; assume rows are physically removed if they disappear from the source.