# email_template_attachment_rel

## Source system
The source system is unknown — insufficient evidence. The naming convention suggests a relational mapping table, likely originating from a custom application database or a generic content management system (CMS) that handles email notifications with file attachments.

## Functional process 
This table supports the "Email Notification Management" process. It acts as a junction table to establish a many-to-many relationship between email templates and their associated file attachments, ensuring that multiple files can be linked to a single template and vice versa.

## Description
One row in this table represents a single association between an email template and a specific file attachment. It serves as a raw landed copy of the link table from the source system, facilitating the reconstruction of email content structures during the staging process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| email_template_id | INTEGER | false | Foreign key to the email template definition. | Links to the parent template entity. |
| attachment_id | INTEGER | false | Foreign key to the file attachment entity. | Links to the specific file metadata. |

## Keys

- **Primary key (inferred):** The composite of (`email_template_id`, `attachment_id`).
- **Foreign keys (inferred):** 
    - `email_template_id` → `email_templates.id` (guess: standard naming convention for template associations).
    - `attachment_id` → `attachments.id` (guess: standard naming convention for file storage associations).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the creation or modification time of these relationships from this table alone.
- Ensure that downstream joins handle the potential for orphaned records if the parent `email_template` or `attachment` records are deleted in the source system without cascading deletes.