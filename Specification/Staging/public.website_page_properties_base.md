# website_page_properties_base

## Source system
This table likely originates from an Odoo ERP or a similar modular web-content management system. The naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` is highly characteristic of Odoo's ORM audit fields, and the `website_id` and `target_model_id` structure suggests a system managing metadata for dynamic web pages linked to specific business objects.

## Functional process 
This table supports the web content management and routing process. It maps specific URLs to target business models (e.g., product pages, blog posts, or category pages) within a multi-website environment, allowing the system to resolve which data object should be rendered when a user visits a specific URL.

## Description
One row represents the configuration and metadata for a single web page property or route within the system. It acts as a staging-layer record, capturing the raw state of page-to-model mappings as they exist in the source application. Its primary purpose is to provide a lookup mechanism for routing web requests to the appropriate backend data entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the record. |
| website_id | INTEGER | false | Foreign key to website | Identifies which website instance this page property belongs to. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| target_model_id | VARCHAR | false | Target model identifier | The technical name of the business model associated with this URL. |
| url | VARCHAR | false | Page URL path | The relative URL path for the page. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Guess: standard Odoo-style multi-website architecture).
    - `create_uid` → `res_users.id` (Guess: standard Odoo-style audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo-style audit field).
- **Natural keys (inferred):** 
    - `(website_id, url)`: A URL is typically unique within the scope of a specific website instance.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments, but should be verified against the source system's configuration.
- **Soft Deletes:** This table does not appear to have an `active` or `deleted_at` flag; assume all records are currently active unless otherwise specified by business logic.
- **Data Precision:** `VARCHAR` columns do not have defined lengths in the metadata; downstream consumers should implement robust error handling for potential truncation if these fields are mapped to fixed-length columns.
- **Audit Fields:** `create_uid` and `write_uid` may be null if the record was created via a system process rather than a specific user action.