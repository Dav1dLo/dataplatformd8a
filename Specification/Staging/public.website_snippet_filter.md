# website_snippet_filter

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized or structured naming fields, which is characteristic of the Odoo ORM's data storage patterns.

## Functional process 
This table supports the website content management and dynamic snippet configuration process. It defines filters applied to website snippets, determining which data records (e.g., products or blog posts) are displayed in specific UI components based on the criteria defined in the `filter_id` and the constraints set by the `limit` and `field_names` columns.

## Description
Each row represents a specific configuration filter applied to a website snippet, defining how data is retrieved and presented on the front end. This table serves as a raw landing copy of the configuration entity, capturing the relationship between websites, action servers, and the specific filtering logic applied to content snippets.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| website_id | INTEGER | true | Foreign key to the website | Links the filter to a specific website instance. |
| action_server_id | INTEGER | true | Foreign key to action server | Identifies the server-side action associated with the filter. |
| filter_id | INTEGER | true | Foreign key to filter definition | References the underlying filter logic/definition. |
| limit | INTEGER | false | Result set limit | Maximum number of records to return for the snippet. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified the record. |
| field_names | VARCHAR | false | Field selection | Comma-separated list of fields to be retrieved. |
| name | JSONB | false | Display name | Localized name or label of the filter. |
| is_published | BOOLEAN | true | Publication status | Indicates if the snippet filter is currently active/published. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Guess: standard Odoo multi-website architecture).
    - `filter_id` → `ir_filters.id` (Guess: standard Odoo filter reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the database's local time (typically UTC in Odoo environments), but verify against the application server configuration.
- **JSONB:** The `name` column contains `JSONB` data; ensure your downstream transformation layer handles JSON parsing (e.g., `name->>'en_US'`) to extract human-readable labels.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if they disappear from the source.
- **PII:** While this table contains configuration data, `create_uid` and `write_uid` link to user tables which may contain PII; ensure appropriate access controls are applied when joining to user directories.