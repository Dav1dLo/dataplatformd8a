# website_visitor

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys (`nextval('"public".website_visitor_id_seq'::regclass)`).

## Functional process 
This table supports the web analytics and visitor tracking process within the Odoo website module. It tracks individual visitor sessions, their geographic and linguistic context, and their interaction frequency with the platform.

## Description
One row in this table represents a unique visitor session or profile identified by an access token. It serves as a raw landing copy of visitor metadata, capturing the state of a user's connection to the website at the grain of a single visitor entity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| website_id | INTEGER | true | Foreign key to the website | Links to the specific site visited. |
| partner_id | INTEGER | true | Foreign key to the partner | Links to the registered customer/partner record. |
| country_id | INTEGER | true | Foreign key to the country | Geographic location of the visitor. |
| lang_id | INTEGER | true | Foreign key to the language | Preferred language of the visitor. |
| visit_count | INTEGER | true | Total number of visits | Counter incremented per session. |
| create_uid | INTEGER | true | User ID who created the record | Internal Odoo user reference. |
| write_uid | INTEGER | true | User ID who last updated the record | Internal Odoo user reference. |
| access_token | VARCHAR | false | Unique session identifier | Used for tracking visitor state. |
| timezone | VARCHAR | true | Visitor timezone | String representation (e.g., 'UTC'). |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| last_connection_datetime | TIMESTAMP | true | Last activity timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Inferred from Odoo standard naming).
    - `partner_id` → `res_partner.id` (Inferred from Odoo standard naming).
    - `country_id` → `res_country.id` (Inferred from Odoo standard naming).
    - `lang_id` → `res_lang.id` (Inferred from Odoo standard naming).
- **Natural keys (inferred):** `access_token`

## Caveats for downstream consumers

- **Sensitive Data:** The `access_token` should be treated as a session secret and masked if exposed in reporting.
- **Timestamps:** All timestamps (`create_date`, `last_connection_datetime`, `write_date`) are stored in UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all records are active unless otherwise specified by business logic.
- **Data Quality:** `website_id`, `partner_id`, `country_id`, and `lang_id` are nullable, suggesting that anonymous visitors or incomplete session data may exist.