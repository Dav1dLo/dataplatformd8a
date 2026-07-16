# website_robots

## Source system
The table likely originates from an Odoo ERP or a similar Python-based web framework application, as indicated by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, which are standard audit fields in Odoo models.

## Functional process 
This table supports the management of website configuration, specifically the `robots.txt` file content used to instruct web crawlers on which parts of the site should not be indexed. It tracks the content of these instructions and the administrative users responsible for creating or updating them.

## Description
One row in this table represents a specific configuration entry for a website's robots exclusion protocol. It serves as a raw landed copy of the configuration record, capturing the text content and the audit trail of who modified the settings and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.website_robots_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system's user table. |
| content | TEXT | true | The actual text content of the robots.txt file | Contains the directives for web crawlers. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC; verify against application server settings if precision is required.
- The `content` column may contain large text blocks; ensure downstream systems handle `TEXT` types appropriately.
- This table does not appear to implement soft-delete; assume rows are hard-deleted if they disappear from the source.
- No PII is immediately obvious, but `content` should be audited for sensitive path disclosures.