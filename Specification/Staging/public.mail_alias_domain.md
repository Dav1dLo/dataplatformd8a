# mail_alias_domain

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequences for primary keys are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the email routing and domain configuration process within the Odoo mail module. It manages the mapping of email domains to specific alias configurations, such as bounce handling, catch-all addresses, and default sender identities, facilitating the automated processing of incoming emails.

## Description
One row in this table represents a single email domain configuration used by the mail server to route incoming messages. It acts as a raw landed copy of the Odoo `mail.alias.domain` model, capturing the domain-level settings required for email integration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_alias_domain_id_seq`. |
| sequence | INTEGER | true | Display order index | Used for UI sorting. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to `res_users`. |
| name | VARCHAR | false | Domain name | The actual email domain (e.g., 'example.com'). |
| bounce_alias | VARCHAR | false | Bounce email alias | Local part of the bounce address. |
| catchall_alias | VARCHAR | false | Catch-all email alias | Local part of the catch-all address. |
| default_from | VARCHAR | true | Default sender address | The default 'From' email address for this domain. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: References the user who created the record.
    - `write_uid` → `res_users.id`: References the user who last modified the record.
- **Natural keys (inferred):** 
    - `name`: The domain name is expected to be unique within the system.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's standard storage format.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely physically deleted if removed from the source.
- **Data Integrity:** The `VARCHAR` columns do not have explicit length constraints defined in the metadata; downstream consumers should handle arbitrary string lengths.
- **PII:** While this table contains email-related configurations, it primarily stores system-level routing aliases rather than individual user PII, though `default_from` could potentially contain sensitive email addresses.