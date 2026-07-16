# res_users_apikeys_description

## Source system
This table originates from an Odoo ERP system. The naming convention `res_users_apikeys_description` and the use of `create_uid`/`write_uid` audit columns are characteristic of the Odoo `res` (resource) module architecture.

## Functional process 
This table supports the API key management and security authentication process. It tracks the metadata and lifecycle of API keys generated for system users, allowing administrators to monitor key usage, expiration, and ownership within the platform's security framework.

## Description
One row represents a single API key entry associated with a user, detailing its descriptive name, duration, and expiration status. As a staging table, it serves as a raw landed copy of the Odoo system's security metadata, capturing the state of API credentials at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `res_users_apikeys_description_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the key | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last modified the key | References `res.users`. |
| name | VARCHAR | false | Descriptive label for the API key | Often used to identify the service or client using the key. |
| duration | VARCHAR | false | Configured lifespan of the key | Format/units inferred from source; confirm if interval or string. |
| expiration_date | TIMESTAMP | true | Date and time when the key expires | Used for security validation. |
| create_date | TIMESTAMP | true | Timestamp of record creation | In UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record modification | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo audit pattern for record creation.
    - `write_uid` → `res_users.id`: Standard Odoo audit pattern for record modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains metadata about API keys; while it does not contain the secret keys themselves, it identifies which users have active integrations.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** Odoo typically uses `active` flags for soft deletes; since no `active` column is present, assume this table contains all records currently in the source database.
- **Data Precision:** `VARCHAR` lengths were not explicitly defined in the source DDL; downstream consumers should account for variable-length strings.