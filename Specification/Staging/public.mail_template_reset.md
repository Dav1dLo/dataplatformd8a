# mail_template_reset

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of standard Odoo sequence generators for the primary key.

## Functional process 
This table supports the email marketing or notification module, specifically tracking the reset or restoration state of email templates. It likely records when a system-provided email template was reverted to its default configuration or reset by a specific user.

## Description
One row represents a single reset event for an email template, capturing the audit trail of who performed the action and when. As a staging table, it serves as a raw, landed copy of the operational database's audit log for template resets.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_template_reset_id_seq` sequence. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Inferred UTC based on Odoo standards. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Inferred UTC based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Assumed to be in UTC; verify against the source system's configuration if precise timezone conversion is required.
- **Soft Deletes:** This table does not appear to contain a soft-delete flag; assume all records are active unless otherwise specified by the source system logic.
- **Data Completeness:** As a staging table, ensure that downstream models handle potential nulls in `create_uid` and `write_uid` gracefully, as these may be null for system-generated processes.