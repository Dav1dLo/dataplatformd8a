# website_page_properties

## Source system
This table likely originates from an Odoo ERP or a similar modular business application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` is a signature pattern for Odoo's ORM-managed tables, which track record creation and modification metadata automatically.

## Functional process 
This table supports the website content management process, specifically tracking metadata and URL history for pages within a multi-site environment. It links specific page properties to a `website_id` and tracks the evolution of page URLs, likely used for SEO redirection or audit trails.

## Description
One row in this table represents a set of configuration properties or historical URL metadata for a specific website page. It serves as a raw staging entity, capturing the state of page properties as they exist in the source system to facilitate downstream reporting on website structure and content changes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for this record. |
| target_model_id | INTEGER | true | Reference to the target model | Likely a foreign key to a content or page model definition. |
| website_id | INTEGER | false | Website identifier | Links the property to a specific website instance. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Modifier user ID | ID of the user who last updated this record. |
| old_url | VARCHAR | true | Previous URL | Stores the historical URL path, useful for 301 redirects. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation; timezone unspecified. |
| write_date | TIMESTAMP | true | Modification timestamp | Timestamp of last update; timezone unspecified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Guess: standard Odoo pattern for multi-site scoping).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user audit trails).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are provided in the source system's local time; verify if the source is configured for UTC before performing time-series analysis.
- **Data Sensitivity:** `create_uid` and `write_uid` link to user tables; ensure access controls are applied if these IDs are joined to PII-containing user tables.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are currently active unless otherwise specified by the source system logic.
- **Precision:** `VARCHAR` length is not explicitly defined in the metadata; downstream consumers should handle potential truncation if mapping to fixed-width fields.