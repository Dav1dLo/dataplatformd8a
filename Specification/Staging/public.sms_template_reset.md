# sms_template_reset

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` on a `_seq` sequence are characteristic of the Odoo ORM framework's standard audit and tracking columns.

## Functional process 
This table supports the management of SMS template resets or configuration overrides within the communication module. It tracks the lifecycle and administrative modifications of specific SMS template settings, likely used to revert or manage template versions during customer engagement or notification workflows.

## Description
One row in this table represents a single configuration record or reset event for an SMS template. It serves as a raw landed copy of the Odoo database table, capturing the audit trail of who created or modified the record and when these actions occurred.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res_users` table. |
| create_date | TIMESTAMP | true | Creation timestamp | Inferred UTC based on Odoo standards. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: This column typically links to the user who performed the creation.
    - `write_uid` → `res_users.id`: This column typically links to the user who performed the last update.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` are internal system IDs; ensure they are joined against the appropriate user dimension to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by business logic.
- **Data Integrity:** As a staging table, this may contain duplicates or partial updates if the ingestion process is not idempotent.