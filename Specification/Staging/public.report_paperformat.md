# report_paperformat

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`report_paperformat`), the use of `create_uid`/`write_uid` for audit tracking, and the specific sequence-based primary key pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the document generation and reporting engine. It defines the layout configurations (page dimensions, margins, and orientation) used by the system when rendering PDF reports or printed documents.

## Description
One row in this table represents a single paper format configuration profile used for report generation. It acts as a raw landed copy of the system's report layout settings, storing physical dimensions, margin constraints, and rendering flags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| page_height | INTEGER | true | Page height in millimeters | Units assumed to be mm based on standard Odoo patterns. |
| page_width | INTEGER | true | Page width in millimeters | Units assumed to be mm. |
| header_spacing | INTEGER | true | Header spacing in millimeters | |
| dpi | INTEGER | false | Dots per inch for rendering | |
| create_uid | INTEGER | true | ID of user who created the record | References `res_users`. |
| write_uid | INTEGER | true | ID of user who last modified the record | References `res_users`. |
| name | VARCHAR | false | Descriptive name of the format | |
| format | VARCHAR | true | Standard paper size code (e.g., A4, Letter) | |
| orientation | VARCHAR | true | Page orientation (Portrait/Landscape) | |
| default | BOOLEAN | true | Flag if this is the system default | |
| header_line | BOOLEAN | true | Flag to include a header line | |
| disable_shrinking | BOOLEAN | true | Flag to disable CSS shrinking | |
| css_margins | BOOLEAN | true | Flag to use CSS-based margins | |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record last modification timestamp | UTC assumed. |
| margin_top | DOUBLE PRECISION | true | Top margin in millimeters | |
| margin_bottom | DOUBLE PRECISION | true | Bottom margin in millimeters | |
| margin_left | DOUBLE PRECISION | true | Left margin in millimeters | |
| margin_right | DOUBLE PRECISION | true | Right margin in millimeters | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit column)
    - `write_uid` → `res_users.id` (Standard Odoo audit column)
- **Natural keys (inferred):** 
    - `name` (Likely unique within the application context)

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table contains no PII, but represents configuration data that should be treated as read-only for reporting purposes.
- There is no explicit soft-delete flag (e.g., `active`), so assume all rows are currently active unless otherwise specified by business logic.
- Units for dimensions (`page_height`, `page_width`, `margin_*`) are typically millimeters in the source system; verify if conversions are required for specific regional reporting needs.