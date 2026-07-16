# theme_ir_attachment

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `ir_attachment` (Internal Resource Attachment), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value pattern common in Odoo's PostgreSQL backend.

## Functional process 
This table supports the document and file management process within the ERP. It acts as a central registry for binary files, images, or external links associated with various business entities (such as products, invoices, or website themes), tracking both the metadata and the location or reference of the attached content.

## Description
One row in this table represents a single file attachment or external resource reference linked to an object within the system. As a staging table, it serves as a raw, landed copy of the Odoo `ir_attachment` model, capturing the state of file metadata at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `theme_ir_attachment_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users.id`. |
| name | VARCHAR | false | Display name of the attachment | Often the filename or a descriptive label. |
| key | VARCHAR | false | Unique identifier or path key | Used for internal resource lookup. |
| url | VARCHAR | true | External URL for the attachment | Populated if the attachment is a link rather than a binary file. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming conventions for audit fields).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming conventions for audit fields).
- **Natural keys (inferred):** 
    - `key` (In Odoo, the `key` field often acts as a unique business identifier for system-level attachments).

## Caveats for downstream consumers

- **Sensitive Data:** The `name` column may contain filenames that reveal internal project names or sensitive document titles.
- **Timezone:** Timestamps (`create_date`, `write_date`) are stored in the database's local time, which is typically configured to UTC in Odoo environments; verify against system settings.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are assumed to be current unless otherwise specified by the upstream Odoo `active` field (which is absent here).
- **Data Completeness:** As a staging table, this may contain records that have been deleted in the source system if the ingestion process is an append-only load.