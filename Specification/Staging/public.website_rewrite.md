# website_rewrite

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of sequence-based primary keys (`nextval` on `_id_seq`).

## Functional process 
This table supports the website management and routing configuration process. It tracks URL redirection rules for the web platform, allowing administrators to map legacy or specific source URLs (`url_from`) to new destination URLs (`url_to`) to maintain SEO and user navigation integrity.

## Description
One row in this table represents a single URL rewrite or redirection rule configured for a specific website. This is a raw landing table in the staging layer, capturing the current state of redirection configurations as defined in the source ERP system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by database sequence. |
| website_id | INTEGER | true | Foreign key to the website | Links to the specific website instance. |
| route_id | INTEGER | true | Foreign key to the route | Links to the associated routing configuration. |
| sequence | INTEGER | true | Display or processing order | Lower numbers typically indicate higher priority. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| name | VARCHAR | false | Descriptive name of the rule | Human-readable label for the rewrite. |
| url_from | VARCHAR | true | Source URL path | The incoming URL pattern to be redirected. |
| url_to | VARCHAR | true | Destination URL path | The target URL path for the redirect. |
| redirect_type | VARCHAR | true | HTTP redirect status code | e.g., '301' (permanent) or '302' (temporary). |
| active | BOOLEAN | true | Soft-delete flag | If false, the rule is ignored by the application. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Guess: links to a master website definition table).
    - `route_id` → `route.id` (Guess: links to a master routing table).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless auditing deleted configurations.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Quality:** `url_from` and `url_to` may contain relative or absolute paths; ensure consistent parsing logic when building downstream URL maps.
- **Sensitivity:** No direct PII is present, but `create_uid` and `write_uid` link to internal user identities.