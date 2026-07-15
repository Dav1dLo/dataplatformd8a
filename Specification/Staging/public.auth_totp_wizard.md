# auth_totp_wizard

## Source system
This table originates from an Odoo ERP instance, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the multi-factor authentication (MFA) setup process for users. It tracks the temporary state of a TOTP (Time-based One-Time Password) configuration wizard, storing the secret key, the generated URL for authenticator apps, and the binary QR code image before the user successfully validates the setup.

## Description
One row represents a single active or historical TOTP setup session initiated by a user. It serves as a raw landing staging table capturing the transient data required to synchronize a user's account with an authenticator application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.auth_totp_wizard_id_seq`. |
| user_id | INTEGER | false | Foreign key to the user | Links to the system user performing the MFA setup. |
| create_uid | INTEGER | true | Creator user ID | The ID of the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | The ID of the user who last updated the record. |
| secret | VARCHAR | false | TOTP secret key | The base32 encoded secret used to generate codes. |
| url | VARCHAR | true | Provisioning URI | The `otpauth://` URL used to configure authenticator apps. |
| code | VARCHAR(7) | true | Verification code | The temporary code entered by the user to validate setup. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time. |
| qrcode | BYTEA | true | QR code image | Binary representation of the QR code for the authenticator app. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: Standard Odoo pattern for user-linked records).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `secret` column contains raw TOTP secrets and must be masked or restricted in downstream environments.
- **Timezone:** Timestamps are stored in server local time; verify the database timezone setting (`SHOW timezone`) to convert to UTC.
- **Data Lifecycle:** This table contains transient wizard data; rows may be deleted or purged after the MFA setup is completed or abandoned.
- **Binary Data:** The `qrcode` column contains large binary objects (BYTEA); avoid `SELECT *` queries to prevent performance degradation.