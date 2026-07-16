# theme_website_page

## Source system
This table originates from Odoo (OpenERP), as evidenced by the naming convention of columns like `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo ORM, as well as the `theme_website_page` table name structure common to Odoo's website module.

## Functional process 
This table supports the website content management process, specifically tracking the configuration and publication status of individual web pages within the Odoo website builder. It manages page-level metadata such as URL routing, indexing preferences, and UI component visibility (headers/footers).

## Description
One row in this table represents a single web page configuration within the Odoo website module. It serves as a raw landing copy of the page metadata, capturing the state of page templates and published content at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `theme_website_page_id_seq`. |
| view_id | INTEGER | false | Reference to the underlying QWeb view | Links to the technical view definition. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| url | VARCHAR | true | Relative URL path for the page | e.g., '/contactus'. |
| header_color | VARCHAR | true | CSS color code for the header | Format may vary (hex/rgba). |
| website_indexed | BOOLEAN | true | SEO indexing flag | If true, search engines are permitted to index. |
| is_published | BOOLEAN | true | Publication status | Determines if the page is live to the public. |
| is_new_page_template | BOOLEAN | true | Template flag | Indicates if this is a reusable page template. |
| header_overlay | BOOLEAN | true | Header overlay setting | If true, the header sits on top of page content. |
| header_visible | BOOLEAN | true | Header visibility toggle | Controls if the header is rendered. |
| footer_visible | BOOLEAN | true | Footer visibility toggle | Controls if the footer is rendered. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id` (Likely links to the view definition).
    - `create_uid` → `res_users.id` (Standard Odoo audit link).
    - `write_uid` → `res_users.id` (Standard Odoo audit link).
- **Natural keys (inferred):** 
    - `url` (Assuming unique paths per website instance).

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column), so it likely contains only currently active records or requires filtering by `is_published`.
- **Data Quality:** `url` may contain leading/trailing slashes; standardise before joining.
- **Sensitivity:** No direct PII, though `create_uid`/`write_uid` link to internal user identities.