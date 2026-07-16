# sale_pdf_form_field

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the document management and sales automation process, specifically tracking the configuration or mapping of fields within PDF forms used for sales documentation. It likely facilitates the dynamic population of sales-related PDFs by defining where specific data points should be placed within a document template.

## Description
One row in this table represents a single field definition or mapping entry within a PDF form template. It acts as a raw landing copy of the configuration metadata, allowing the system to associate specific data attributes with document paths or types.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.sale_pdf_form_field_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res.users`. |
| name | VARCHAR | false | Name of the form field | Likely the internal identifier for the field. |
| document_type | VARCHAR | false | Category or type of the PDF document | Used to group fields by document purpose. |
| path | VARCHAR | true | File path or location of the PDF template | May contain relative or absolute storage paths. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with user tables to resolve names.
- **Timestamps:** Assumed to be in UTC; verify against Odoo system configuration if local time offsets are observed.
- **Soft Deletes:** This table does not appear to have an `active` or `deleted_at` flag; assume all records are current unless otherwise specified by business logic.
- **Data Precision:** `VARCHAR` lengths are not explicitly defined in the source; downstream systems should handle variable-length strings accordingly.