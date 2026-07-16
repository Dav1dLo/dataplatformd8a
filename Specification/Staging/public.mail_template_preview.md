# mail_template_preview

## Source system
This table originates from an Odoo ERP system. The naming convention (`mail_template_preview`), the presence of `create_uid`, `write_uid`, `create_date`, and `write_date` audit columns, and the use of PostgreSQL sequence-based IDs are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the email communication and notification module, specifically managing the preview generation for email templates. It tracks the context in which a template is being previewed, including the target language and the specific resource (e.g., a sales order or invoice) being referenced for the preview.

## Description
One row in this table represents a single preview instance of an email template generated for a specific resource and language. It serves as a raw landing copy of the preview metadata, capturing the state of the template generation process at a specific point in time.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the preview record. |
| mail_template_id | INTEGER | false | Foreign key to the mail template | Links to the source template definition. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the preview. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the preview record. |
| resource_ref | VARCHAR | true | Resource reference | A string reference (e.g., "sale.order,123") identifying the object being previewed. |
| lang | VARCHAR | true | Language code | ISO language code (e.g., 'en_US') used for the template rendering. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the preview record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the preview record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_template_id` → `mail_template.id` (Inferred from standard Odoo naming conventions for template relations).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for user-tracking columns).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for user-tracking columns).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `resource_ref` may contain internal object references that could be considered sensitive depending on the business context.
- **Timestamps:** Timestamps are stored in the database server's local time (typically UTC in Odoo deployments), but verify against the application configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely hard-deleted by the application.
- **Data Integrity:** As a staging table, this may contain transient data; ensure joins to `mail_template` handle potential orphans if the source system performs cleanup.