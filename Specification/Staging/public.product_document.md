# product_document

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `ir_attachment_id`, `create_uid`, `write_uid`, `write_date`) and the use of PostgreSQL sequences for primary keys are characteristic of Odoo's internal data model for managing document attachments linked to product records.

## Functional process 
This table supports the Product Lifecycle Management (PLM) and document management process. It tracks the association between product-related documents (stored in the `ir_attachment` system) and their visibility or relevance across different business modules, specifically manufacturing (`attached_on_mrp`) and sales (`attached_on_sale`).

## Description
One row in this table represents a single association between a document and a product context. It acts as a bridge table or configuration record that determines how and where a document is surfaced within the ERP. This is a raw landing table in the Staging layer, capturing the state of document-to-product associations as they exist in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_document_id_seq`. |
| ir_attachment_id | INTEGER | false | Foreign key to the attachment repository | Links to the actual file/binary metadata. |
| sequence | INTEGER | true | Display order index | Used for sorting documents in UI lists. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users` table. |
| active | BOOLEAN | true | Soft-delete flag | If false, the association is hidden. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| attached_on_mrp | VARCHAR | false | MRP visibility flag | Likely a boolean-as-string or category code. |
| attached_on_sale | VARCHAR | false | Sales visibility flag | Likely a boolean-as-string or category code. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `ir_attachment_id` → `ir_attachment.id` (Standard Odoo pattern for document linking).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Visibility Flags:** The columns `attached_on_mrp` and `attached_on_sale` are `VARCHAR` types; verify if these contain 'True'/'False' strings or specific status codes before filtering.
- **Timestamps:** All `_date` fields are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Soft Deletes:** The `active` column should be checked in all queries; rows where `active = false` are typically considered deleted in the source system.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal Odoo user IDs and will not resolve to meaningful names without joining to the `res_users` table.