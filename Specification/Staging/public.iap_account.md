# iap_account

## Source system
This table originates from an Odoo ERP environment, as evidenced by the characteristic `create_uid`, `write_uid`, `create_date`, and `write_date` audit columns, alongside the use of `nextval` sequences for primary keys.

## Functional process 
This table supports the In-App Purchase (IAP) management process, tracking account-level credentials, credit balances, and service status for integrated third-party services. It acts as the central registry for linking internal service instances to external IAP service providers.

## Description
One row in this table represents a single IAP account configuration associated with a specific service. It serves as a raw landed copy of the IAP account state, capturing authentication tokens, current balances, and operational status flags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `iap_account_id_seq`. |
| service_id | INTEGER | false | Foreign key to the service definition | Links to the specific IAP service. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user table. |
| name | VARCHAR | true | Account display name | Human-readable identifier. |
| account_token | VARCHAR(43) | true | Authentication token | Sensitive credential; requires masking. |
| balance | VARCHAR | true | Current account balance | Stored as VARCHAR; check for numeric formatting. |
| state | VARCHAR | true | Operational status of the account | Likely categorical (e.g., 'active', 'suspended'). |
| service_locked | BOOLEAN | true | Lock status flag | Indicates if the service is restricted. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |
| warning_threshold | DOUBLE PRECISION | true | Credit alert threshold | Used for balance notifications. |
| sender_name | VARCHAR | true | Sender identity for IAP services | Often used for SMS or email gateway services. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `service_id` → `iap_service.id` (Guess: links to the parent service definition).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `account_token` column contains authentication credentials and must be masked or excluded from non-privileged reporting.
- **Data Types:** The `balance` column is stored as a `VARCHAR` despite representing a numeric value; ensure explicit casting to `NUMERIC` or `DECIMAL` before performing arithmetic.
- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with standard Odoo deployment practices.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal system user IDs; these will require a join to the `res_users` table to resolve to human-readable names.