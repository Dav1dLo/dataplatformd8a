# mail_guest

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `mail_guest`, `create_uid`, `write_uid`, `write_date`) and the use of Postgres sequences for primary keys are characteristic of the Odoo framework's internal data model for managing guest users in communication channels.

## Functional process 
This table supports the "Communication and Collaboration" module, specifically managing guest identities for external users participating in discussions or chat channels without a registered account. It tracks guest metadata such as language preferences and timezones to facilitate localized communication.

## Description
One row in this table represents a single guest user identity within the system. It serves as a raw landing copy of the guest entity, capturing the state of the guest record as it exists in the source Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mail_guest_id_seq`. |
| country_id | INTEGER | true | Foreign key to country | Links to the guest's associated country. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| name | VARCHAR | false | Guest display name | The name assigned to the guest. |
| access_token | VARCHAR | false | Security token | Unique token used for guest authentication/access. |
| lang | VARCHAR | true | Language code | ISO language code (e.g., 'en_US'). |
| timezone | VARCHAR | true | Timezone identifier | IANA timezone string (e.g., 'UTC'). |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `country_id` → `res_country.id` (Guess: standard Odoo pattern for country references).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit trails).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit trails).
- **Natural keys (inferred):** `access_token` (Likely acts as the unique identifier for the guest session).

## Caveats for downstream consumers

- The `access_token` should be treated as sensitive; it provides access to the guest's communication context.
- Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo, but verify against the source system configuration.
- This table does not implement soft deletes; records are typically hard-deleted in the source Odoo environment.
- The `lang` and `timezone` columns may contain null values if not explicitly set during guest initialization.