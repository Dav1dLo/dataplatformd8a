# portal_share

## Source system
The table likely originates from an Odoo ERP system. The naming convention (`res_id`, `res_model`, `create_uid`, `write_uid`, `write_date`) and the use of Postgres sequences (`nextval('"public".portal_share_id_seq'::regclass)`) are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the "Document Sharing" or "Portal Access" business process. It tracks instances where specific records (identified by `res_model` and `res_id`) are shared via the portal, often used to manage external user access to internal documents like invoices, quotations, or projects.

## Description
One row in this table represents a single share configuration or access link generated for a specific record within the system. It acts as a raw landing record in the staging layer, capturing the metadata of the sharing event, including the target record, the user who initiated the share, and any associated notes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `portal_share_id_seq`. |
| res_id | INTEGER | false | ID of the target record | References the primary key of the model defined in `res_model`. |
| create_uid | INTEGER | true | User ID who created the share | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the share | References `res_users.id`. |
| res_model | VARCHAR | false | Technical name of the target model | e.g., 'sale.order', 'account.move'. |
| note | TEXT | true | Optional description for the share | Free-text field for context. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Polymorphism:** The `res_id` column is polymorphic; its meaning depends entirely on the value in `res_model`. Queries joining this table must filter by `res_model` to avoid incorrect joins.
- **Soft Deletes:** This table does not appear to have an explicit `active` flag; assume rows are hard-deleted if they disappear from the source.
- **PII:** The `note` field may contain unstructured data; ensure compliance checks if sharing this data with downstream reporting layers.