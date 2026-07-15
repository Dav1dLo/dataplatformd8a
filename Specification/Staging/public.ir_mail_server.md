# ir_mail_server

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the `ir_mail_server` naming convention, which follows the standard Odoo internal registry (`ir`) naming pattern for system configuration objects.

## Functional process 
This table supports the system's outbound email infrastructure. It stores the configuration details for SMTP servers used by the application to send transactional emails, notifications, and reports. It manages authentication, encryption, and connection parameters for various mail providers, including support for OAuth2-based Gmail integration.

## Description
One row in this table represents a single configured SMTP mail server account. This is a raw landed copy of the Odoo configuration entity, capturing the technical settings required for the application to interface with external mail transfer agents.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| smtp_port | INTEGER | true | SMTP server port | Typically 25, 465, or 587. |
| sequence | INTEGER | true | Display order | Used for UI sorting. |
| create_uid | INTEGER | true | Creator user ID | Reference to res_users. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to res_users. |
| name | VARCHAR | false | Server name | Descriptive label for the server. |
| from_filter | VARCHAR | true | Email filter | Regex to restrict which 'From' addresses use this server. |
| smtp_host | VARCHAR | true | SMTP server hostname | The address of the mail server. |
| smtp_authentication | VARCHAR | false | Auth method | e.g., 'none', 'login', 'plain', 'oauth'. |
| smtp_user | VARCHAR | true | SMTP username | Username for authentication. |
| smtp_pass | VARCHAR | true | SMTP password | Sensitive: contains credentials. |
| smtp_encryption | VARCHAR | false | Encryption protocol | e.g., 'none', 'tls', 'ssl'. |
| smtp_debug | BOOLEAN | true | Debug mode flag | Enables verbose logging if true. |
| active | BOOLEAN | true | Soft-delete flag | If false, the server is disabled. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| max_email_size | DOUBLE PRECISION | true | Max allowed email size | Units in bytes. |
| smtp_ssl_certificate | BYTEA | true | SSL certificate | Binary blob. |
| smtp_ssl_private_key | BYTEA | true | SSL private key | Binary blob. |
| google_gmail_access_token_expiration | INTEGER | true | Token expiry epoch | Unix timestamp. |
| google_gmail_authorization_code | VARCHAR | true | OAuth2 auth code | Used for initial token exchange. |
| google_gmail_refresh_token | VARCHAR | true | OAuth2 refresh token | Used to renew access tokens. |
| google_gmail_access_token | VARCHAR | true | OAuth2 access token | Short-lived credential. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail column).
- **Natural keys (inferred):** 
    - `name` (In Odoo, the server name is typically unique within the configuration context).

## Caveats for downstream consumers

- **Sensitive Data:** This table contains highly sensitive credentials, including `smtp_pass`, `google_gmail_refresh_token`, and `smtp_ssl_private_key`. These columns must be masked or excluded from non-privileged environments.
- **Timestamps:** `create_date` and `write_date` are stored in the application's configured timezone (typically UTC in Odoo deployments).
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` to retrieve currently valid configurations.
- **Binary Data:** `smtp_ssl_certificate` and `smtp_ssl_private_key` are stored as `BYTEA` and may be large; avoid `SELECT *` if these are not required.