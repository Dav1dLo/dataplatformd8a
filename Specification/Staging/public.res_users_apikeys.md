# res_users_apikeys

## Source system
This table originates from an Odoo ERP system, as evidenced by the `res_users` naming convention and the use of standard Odoo sequence generators (`nextval('"public".res_users_apikeys_id_seq'::regclass)`).

## Functional process 
This table supports the authentication and security management process, specifically tracking API keys issued to users for programmatic access to the ERP platform. It manages the lifecycle of these keys, including their scope of access and expiration constraints.

## Description
One row in this table represents a single API key associated with a specific user account. It serves as a raw landing record in the staging layer, capturing the metadata, permissions, and validity period for external integrations or automated services.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| name | VARCHAR | false | Descriptive name for the API key | Often used to identify the integration or service. |
| user_id | INTEGER | false | Foreign key to the user | Links the key to a specific system user. |
| scope | VARCHAR | true | Access permissions | Defines the functional scope of the API key. |
| expiration_date | TIMESTAMP | true | Expiration timestamp | The date/time after which the key is invalid. |
| index | VARCHAR(8) | true | Key index or prefix | Likely a short identifier for key management. |
| key | VARCHAR | true | The API key value | Sensitive data; likely a hash or masked value. |
| create_date | TIMESTAMP | true | Record creation timestamp | Defaults to UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id`: This column links the API key to the user account that owns it.
- **Natural keys (inferred):** 
    - Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `key` column contains security credentials and should be masked or excluded from general-purpose reporting.
- **Timezone:** `create_date` is stored in UTC; assume `expiration_date` follows the same convention unless otherwise specified by application logic.
- **Data Integrity:** This is a staging table; verify if the source system performs soft deletes or if records are purged upon key revocation.
- **Type Precision:** `VARCHAR` columns without explicit length (e.g., `name`, `scope`, `key`) are defined as unbounded in the source; downstream consumers should allocate sufficient buffer space for these fields.