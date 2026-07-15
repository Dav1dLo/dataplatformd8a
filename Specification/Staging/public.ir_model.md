# ir_model

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_model` (Internal Resource Model) and the presence of columns like `create_uid`, `write_uid`, and `JSONB` fields for translatable names are characteristic of the Odoo ORM metadata layer.

## Functional process 
This table supports the Odoo framework's internal metadata management, specifically the definition and configuration of data models (objects) within the system. It tracks which models are registered, their default sorting, whether they support email threading or activity tracking, and their configuration for website form integration.

## Description
One row in this table represents a single data model definition registered within the Odoo application. This is a raw landed copy of the system's internal model registry, providing the structural metadata required to understand the entities available in the database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_model_id_seq`. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to `res_users`. |
| model | VARCHAR | false | Technical model name | e.g., 'res.partner', 'sale.order'. |
| order | VARCHAR | false | Default sort order | SQL order clause for the model. |
| state | VARCHAR | true | Model state | Usually 'manual' or 'base'. |
| name | JSONB | false | Model display name | Multi-language label stored as JSON. |
| info | TEXT | true | Model description | Human-readable documentation. |
| transient | BOOLEAN | true | Transient model flag | If true, data is automatically cleared. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| is_mail_thread | BOOLEAN | true | Mail thread support | Enables chatter/email integration. |
| is_mail_activity | BOOLEAN | true | Mail activity support | Enables activity scheduling. |
| is_mail_blacklist | BOOLEAN | true | Blacklist support | Enables email blacklisting. |
| website_form_default_field_id | INTEGER | true | Default form field ID | Foreign key to `ir_model_fields`. |
| website_form_label | VARCHAR | true | Website form label | UI label for web forms. |
| website_form_key | VARCHAR | true | Website form key | Identifier for web form mapping. |
| website_form_access | BOOLEAN | true | Website form access | Flag for public form availability. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Standard Odoo audit column).
    - `website_form_default_field_id` → `ir_model_fields.id` (Links to specific field definition).
- **Natural keys (inferred):** 
    - `model` (The technical name is unique across the Odoo system).

## Caveats for downstream consumers

- **PII/Sensitivity:** Contains system configuration data; generally low risk, but `create_uid` and `write_uid` link to user tables which may contain PII.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not implement soft deletes; it reflects the current state of the system's model registry.
- **JSONB:** The `name` column is `JSONB`; downstream consumers will need to use `->>` or `jsonb_extract_path_text` to access specific language strings.
- **Data Pattern:** As a staging table, this is a direct reflection of the source schema and may contain technical artifacts (like `nextval` defaults) that should be handled during transformation.