# mail_gateway_allowed

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the email communication security process, specifically managing allowlists for the mail gateway. It defines which email addresses or domains are permitted to interact with the system's automated email processing, preventing unauthorized or spam-related inbound traffic.

## Description
One row in this table represents a single entry in the mail gateway allowlist, identifying an email address authorized to communicate with the system. As a staging table, it serves as a raw, direct copy of the Odoo database record, intended for use in downstream security auditing or communication routing logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.mail_gateway_allowed_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| email | VARCHAR | false | The email address or domain allowed | The primary business identifier. |
| email_normalized | VARCHAR | true | Normalized version of the email | Used for case-insensitive matching. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit field pattern).
- **Natural keys (inferred):** 
    - `email` (The business-level identifier for the allowlist entry).

## Caveats for downstream consumers

- **PII:** The `email` column contains personally identifiable information; ensure appropriate masking in downstream reporting layers.
- **Timestamps:** Timestamps are stored in the database server's local time (typically UTC in Odoo deployments), but verify against the application server configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely physically deleted from the source.
- **Data Quality:** `email_normalized` may be null if the ingestion process or the source system failed to normalize the input string.