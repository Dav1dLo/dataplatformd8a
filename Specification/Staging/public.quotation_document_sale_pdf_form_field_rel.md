# quotation_document_sale_pdf_form_field_rel

## Source system
Unknown — insufficient evidence. The table name suggests a relationship between quotation documents and PDF form fields, which is common in document management or e-commerce quoting systems, but the naming convention does not map clearly to a specific major ERP or CRM vendor.

## Functional process 
This table supports the mapping of specific form fields to quotation documents, likely used to populate dynamic PDF templates with data during the quotation generation process. It acts as a bridge table to manage the many-to-many relationship between document instances and the form fields they contain.

## Description
One row in this table represents a single association between a specific quotation document and a PDF form field. It serves as a raw landing copy of a join table, capturing the structural link required to render or extract data from generated PDF quotations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| quotation_document_id | INTEGER | false | Foreign key to the quotation document | Links to the parent document entity. |
| sale_pdf_form_field_id | INTEGER | false | Foreign key to the PDF form field definition | Identifies the specific field being mapped. |

## Keys

- **Primary key (inferred):** The combination of `quotation_document_id` and `sale_pdf_form_field_id` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `quotation_document_id` → `quotation_document.id`: This column likely references the primary key of the quotation document table.
    - `sale_pdf_form_field_id` → `sale_pdf_form_field.id`: This column likely references the primary key of the PDF form field definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; expect high cardinality and frequent joins to the parent entities.
- There are no timestamps or audit columns present; it is impossible to determine the creation or modification time of these relationships from this table alone.
- As a staging table, this may contain orphaned records if referential integrity is not strictly enforced in the source system.