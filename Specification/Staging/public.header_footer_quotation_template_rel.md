# header_footer_quotation_template_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular business management system. The naming convention `_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link core business entities (quotations) to configuration templates (header/footer layouts).

## Functional process 
This table supports the document generation and sales quotation management process. It manages the association between specific quotation documents and the header/footer templates used for their visual layout or branding, ensuring that the correct document formatting is applied during the print or PDF generation phase of the lead-to-cash pipeline.

## Description
This table represents a many-to-many join relationship between quotation documents and sales order templates. It serves as a raw landing staging entity, capturing the direct link between a document ID and its assigned template ID to facilitate relational lookups in downstream transformation layers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| quotation_document_id | INTEGER | false | Foreign key to the quotation document entity | Represents the unique identifier of the quotation. |
| sale_order_template_id | INTEGER | false | Foreign key to the sales order template entity | Represents the unique identifier of the layout template. |

## Keys

- **Primary key (inferred):** Not confidently inferable. This table likely uses a composite primary key consisting of both `quotation_document_id` and `sale_order_template_id`.
- **Foreign keys (inferred):** 
    - `quotation_document_id` → `quotation_document.id`: Links to the parent quotation record.
    - `sale_order_template_id` → `sale_order_template.id`: Links to the template configuration record.
- **Natural keys (inferred):** The combination of `(quotation_document_id, sale_order_template_id)` acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This is a link table; expect no descriptive attributes other than the two foreign keys.
- There is no audit or timestamp information available in this table; it represents the current state of the relationship.
- Ensure inner joins are used when filtering for active templates, as orphaned IDs may exist if the source system does not enforce strict referential integrity at the database level.