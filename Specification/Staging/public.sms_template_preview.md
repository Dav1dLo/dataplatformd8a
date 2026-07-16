# sms_template_preview

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the communication and notification module, specifically the previewing of SMS templates before they are sent to recipients. It tracks the generation of template previews associated with specific language settings and resource references, likely used to verify content personalization before mass mailing or automated SMS triggers.

## Description
One row in this table represents a single generated preview of an SMS template, capturing the state of the template at the time of preview. It serves as a raw staging record, maintaining the audit trail of who created or modified the preview and the language context in which it was generated.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sms_template_preview_id_seq`. |
| sms_template_id | INTEGER | false | Foreign key to the SMS template | Links to the parent template definition. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| lang | VARCHAR | true | Language code | e.g., 'en_US', 'fr_FR'. |
| resource_ref | VARCHAR | true | Reference to the source object | Often a string like 'model.name,id' identifying the context. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sms_template_id` → `sms_template.id` (Inferred from standard Odoo naming conventions).
    - `create_uid` → `res_users.id` (Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `resource_ref` may contain identifiers for sensitive business objects (e.g., specific customer or order records).
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Precision:** `VARCHAR` columns do not have explicit lengths defined in the metadata; downstream consumers should handle variable-length strings accordingly.