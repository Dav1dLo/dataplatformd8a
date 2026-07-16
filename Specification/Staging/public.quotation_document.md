# quotation_document

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `ir_attachment_id`, `create_uid`, `write_uid`, `create_date`) and the use of PostgreSQL sequence-based primary keys are characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the Sales and Quoting process, specifically managing the association between quotation records and their related binary attachments (such as PDFs, terms and conditions, or supporting documentation). It facilitates the document management lifecycle within the sales pipeline.

## Description
One row represents a single link between a quotation and an associated file attachment stored in the system. This is a staging layer table, providing a raw, direct copy of the Odoo `quotation_document` model, used to track document metadata and attachment associations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the link record. |
| ir_attachment_id | INTEGER | false | Foreign key to attachment | References the `ir_attachment` table where the actual binary file resides. |
| sequence | INTEGER | true | Display order | Used to determine the order of documents if multiple are attached. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this link record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this link record. |
| document_type | VARCHAR | false | Type of document | Categorizes the attachment (e.g., 'quote', 'terms', 'manual'). |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the document link is currently active or archived. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the system upon record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the system upon the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `ir_attachment_id` → `ir_attachment.id`: Links to the core attachment storage table.
    - `create_uid` → `res_users.id`: Links to the user who performed the creation (guess based on Odoo standard).
    - `write_uid` → `res_users.id`: Links to the user who performed the last update (guess based on Odoo standard).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column suggests a soft-delete pattern; queries should filter by `WHERE active = TRUE` unless historical analysis of deleted links is required.
- **Timestamps:** Timestamps are stored in the database server's local time (typically UTC in Odoo deployments), but verify against the application server configuration.
- **PII:** While this table contains metadata, the associated `ir_attachment` records may contain sensitive customer data or contract details; ensure appropriate access controls are applied when joining to the attachment content.
- **Data Precision:** `VARCHAR` length is not explicitly defined in the source; assume standard Odoo behavior where this may vary by version.