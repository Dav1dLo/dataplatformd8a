# portal_share

## Source system
This table likely originates from an Odoo ERP system. The naming convention (`res_id`, `res_model`, `create_uid`, `write_uid`, `write_date`) and the use of Postgres sequences for primary keys are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the "Portal Sharing" or "Document Sharing" business process, which tracks external access or shared links to internal records. It links specific records (`res_id` and `res_model`) to sharing metadata, allowing the system to manage permissions and audit who created or modified the share link.

## Description
One row in this table represents a single instance of a shared portal link or document access record. It acts as a raw landing copy of the Odoo `portal.share` model, capturing the association between a specific business object and its sharing configuration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.portal_share_id_seq`. |
| res_id | INTEGER | false | ID of the related record | The ID of the object being shared. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the share. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the share. |
| res_model | VARCHAR | false | Technical name of the model | The Odoo model name (e.g., 'sale.order'). |
| note | TEXT | true | Descriptive note | Optional text provided when creating the share. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `note` column may contain free-text user input which could potentially contain sensitive information.
- **Timestamps:** Timestamps are stored in the database's local time (typically UTC in Odoo environments), but verify against the application server configuration.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume standard CRUD behavior where rows are physically removed if deleted in the source.
- **Model Polymorphism:** The `res_model` column indicates that `res_id` is polymorphic; queries joining this table must filter by `res_model` to ensure the correct target table is joined.