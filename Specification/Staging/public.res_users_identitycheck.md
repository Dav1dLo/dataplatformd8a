# res_users_identitycheck

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `res_users_*` (a standard Odoo module pattern) and the use of `create_uid` and `write_uid` columns, which are characteristic of Odoo's internal audit tracking system.

## Functional process 
This table supports the user authentication and identity verification process. It tracks specific identity check requests, the authentication methods employed, and associated metadata for user security events within the platform.

## Description
One row in this table represents a single identity verification or authentication check event performed for a user. It serves as a raw landing record in the staging layer, capturing the state of security-related requests as they were recorded in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `res_users_identitycheck_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users.id`. |
| request | VARCHAR | true | The specific identity check request details | Likely contains JSON or structured text. |
| auth_method | VARCHAR | true | The authentication method used | e.g., 'password', 'totp', 'oauth'. |
| password | VARCHAR | true | Encrypted or hashed password string | Sensitive data; handle with extreme caution. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo audit field referencing the creator.
    - `write_uid` → `res_users.id`: Standard Odoo audit field referencing the modifier.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `password` column contains authentication credentials. This column should be masked or excluded from all non-privileged reporting environments.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** As a staging table, this data is a direct reflection of the source. It may contain incomplete records or transient states depending on the frequency of the ingestion job.
- **Soft Deletes:** Odoo typically does not use soft-delete flags; records are usually physically deleted from the source, though this table may accumulate history depending on the source system's retention policy.