# website_controller_page

## Source system
The table likely originates from an Odoo ERP or a similar Python-based web framework (e.g., Odoo's `website.controller.page` model). The presence of `create_uid`, `write_uid`, and `_seq` default values for the primary key are characteristic patterns of the Odoo ORM framework.

## Functional process 
This table supports the website content management process, specifically tracking the configuration and routing of dynamic pages within a web application. It manages how specific views are mapped to URLs and their associated layout configurations.

## Description
One row in this table represents a single website page configuration, defining its name, slug, and layout properties. As a staging table, it serves as a raw, direct copy of the source system's page controller definitions, intended for downstream transformation into a unified web content dimension.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `website_controller_page_id_seq`. |
| website_id | INTEGER | true | Foreign key to the website | Links to the specific website instance. |
| view_id | INTEGER | false | Foreign key to the view definition | The base template or view associated with this page. |
| record_view_id | INTEGER | true | Foreign key to a specific record view | Optional override for specific record-based views. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Page display name | The human-readable title of the page. |
| name_slugified | VARCHAR | true | URL-friendly page identifier | The slug used in the URL path. |
| record_domain | VARCHAR | true | Domain filter | The filter criteria used to identify records for this page. |
| default_layout | VARCHAR | true | Layout template name | The default UI layout applied to this page. |
| is_published | BOOLEAN | true | Publication status | Flag indicating if the page is live on the website. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the source system. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Guess: links to a parent website configuration table).
    - `view_id` → `ir_ui_view.id` (Guess: standard Odoo pattern for linking to view definitions).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** 
    - `name_slugified` (Assuming the slug is unique within the context of a `website_id`).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, but verify against the source system's `timezone` configuration.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are active unless otherwise specified by the source system logic.
- **Data Quality:** `name_slugified` may be null for legacy records or system-generated pages that do not follow standard routing.
- **PII:** No direct PII is present, though `create_uid` and `write_uid` link to user identities in the source system.