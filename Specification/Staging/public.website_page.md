# website_page

## Source system
The table likely originates from Odoo (formerly OpenERP), an open-source ERP system. This is evidenced by the specific naming conventions such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit columns in Odoo's ORM, as well as the use of `nextval` sequences for primary keys.

## Functional process 
This table supports the website content management process, specifically tracking the configuration and publication status of individual web pages within a multi-website environment. It manages page-level metadata, including visual styling (header/footer visibility and colors) and indexing status for search engines.

## Description
One row in this table represents a single page configuration within a website instance. It acts as a raw landed copy of the source system's page registry, capturing both structural identifiers and UI-specific display settings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `website_page_id_seq`. |
| website_id | INTEGER | true | Foreign key to the website | Identifies which website this page belongs to. |
| view_id | INTEGER | false | Reference to the view definition | Links to the underlying QWeb view template. |
| create_uid | INTEGER | true | Creator user ID | Audit column for the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Audit column for the user who last updated the record. |
| theme_template_id | INTEGER | true | Theme template reference | Links to the specific theme template applied. |
| url | VARCHAR | false | Page URL path | The relative URL path for the page. |
| header_color | VARCHAR | true | Header background color | CSS color value for the page header. |
| header_text_color | VARCHAR | true | Header text color | CSS color value for the header text. |
| is_published | BOOLEAN | true | Publication status | Indicates if the page is live on the site. |
| website_indexed | BOOLEAN | true | SEO indexing flag | Indicates if the page should be indexed by search engines. |
| is_new_page_template | BOOLEAN | true | Template flag | Indicates if this page serves as a template for new pages. |
| header_overlay | BOOLEAN | true | Header overlay toggle | Whether the header overlays the page content. |
| header_visible | BOOLEAN | true | Header visibility | Whether the header is rendered. |
| footer_visible | BOOLEAN | true | Footer visibility | Whether the footer is rendered. |
| date_publish | TIMESTAMP | true | Publication timestamp | The date/time the page was published. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Record last modification time in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Guess: Standard Odoo multi-website architecture).
    - `view_id` → `ir_ui_view.id` (Guess: Standard Odoo view registry).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: Standard Odoo user registry).
- **Natural keys (inferred):** 
    - `url` (In the context of a specific `website_id`).

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid` which link to internal user records; ensure these are handled according to internal access policies.
- **Timestamps:** Assumed to be in UTC, consistent with Odoo's standard database storage.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are active unless filtered by `is_published`.
- **Data Integrity:** `website_id` is nullable, which may imply global pages or legacy data migration artifacts.