# mail_ice_server

## Source system
This table likely originates from an Odoo ERP or a similar Python-based framework, evidenced by the `create_uid`, `write_uid`, `create_date`, and `write_date` audit column pattern, as well as the use of `nextval` sequences for primary keys.

## Functional process 
This table supports the configuration of STUN/TURN servers used for WebRTC signaling in communication modules. It stores the connection details required for clients to establish peer-to-peer media streams, such as those used in integrated chat or video conferencing features.

## Description
One row represents a single STUN or TURN server configuration available for use by the application. This is a raw staging table containing the direct configuration parameters, including authentication credentials and server endpoints, used to facilitate real-time communication.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.mail_ice_server_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the system user table. |
| server_type | VARCHAR | false | Type of ICE server (e.g., 'stun', 'turn') | Determines the protocol handling. |
| uri | VARCHAR | false | The URI of the ICE server | The network address of the server. |
| username | VARCHAR | true | Username for TURN authentication | Nullable if the server does not require auth. |
| credential | VARCHAR | true | Password or secret for TURN authentication | Sensitive data; should be masked. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo-style audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo-style audit column).
- **Natural keys (inferred):** 
    - `uri` (Assuming a unique server address per configuration).

## Caveats for downstream consumers

- **Sensitive Data:** The `credential` column contains plaintext or obfuscated secrets; ensure this is masked or encrypted in downstream reporting layers.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to have an `active` or `deleted_at` flag; assume all rows are currently active unless otherwise specified by business logic.
- **Data Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; downstream systems should be prepared for variable-length strings.