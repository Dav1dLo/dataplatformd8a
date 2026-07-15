# ir_model_fields

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_model_fields` (where `ir` stands for "Internal Record") is a core component of the Odoo ORM metadata layer, which manages the dynamic definition of database models and their associated fields.

## Functional process 
This table supports the Odoo Metadata Management process. It acts as the central registry for all field definitions across the system's models, enabling the ORM to dynamically generate database schemas, UI forms, and API endpoints based on the configurations stored here.

## Description
One row in this table represents a single field definition for a specific Odoo model. It captures the technical attributes, data types, and behavioral flags (such as `required`, `readonly`, or `index`) for every field registered in the application. This is a raw landed copy of the system's internal metadata, used to reconstruct the data dictionary of the platform.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| relation_field_id | INTEGER | true | Foreign key to `ir_model_fields` | Links to the inverse field in a relation. |
| model_id | INTEGER | false | Foreign key to `ir_model` | Links to the parent model definition. |
| related_field_id | INTEGER | true | Foreign key to `ir_model_fields` | Reference for related fields. |
| size | INTEGER | true | Field length constraint | Used for character-based types. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| name | VARCHAR | false | Technical field name | The programmatic name used in code. |
| complete_name | VARCHAR | true | Fully qualified field name | Often model.field format. |
| model | VARCHAR | false | Model technical name | The model this field belongs to. |
| relation | VARCHAR | true | Related model name | For relational fields (Many2one, etc). |
| relation_field | VARCHAR | true | Inverse field name | Name of the field on the related model. |
| ttype | VARCHAR | false | Field data type | e.g., char, integer, boolean, many2one. |
| related | VARCHAR | true | Related field path | Dot-notation path for related fields. |
| state | VARCHAR | false | Field lifecycle state | e.g., 'base', 'manual'. |
| on_delete | VARCHAR | true | Referential integrity action | e.g., 'cascade', 'set null'. |
| domain | VARCHAR | true | Filter domain | Search criteria for relational fields. |
| relation_table | VARCHAR | true | Join table name | Used for Many2many relationships. |
| column1 | VARCHAR | true | Join column 1 | First column in join table. |
| column2 | VARCHAR | true | Join column 2 | Second column in join table. |
| depends | VARCHAR | true | Dependency list | Fields that trigger re-computation. |
| currency_field | VARCHAR | true | Currency reference field | For monetary fields. |
| field_description | JSONB | false | Field label | Multi-language label stored as JSON. |
| help | JSONB | true | Tooltip text | Multi-language help text. |
| compute | TEXT | true | Compute method logic | Python code string for computed fields. |
| copied | BOOLEAN | true | Copy flag | Whether field is included in record duplication. |
| required | BOOLEAN | true | Required constraint | Mandatory field flag. |
| readonly | BOOLEAN | true | Read-only constraint | UI/ORM write protection. |
| index | BOOLEAN | true | Database index flag | Whether to create a DB index. |
| translate | BOOLEAN | true | Translation flag | Whether field supports multi-language. |
| company_dependent | BOOLEAN | true | Multi-company flag | Whether value varies by company. |
| group_expand | BOOLEAN | true | Grouping behavior | Used for Kanban/List views. |
| selectable | BOOLEAN | true | Searchable flag | Whether field is available in searches. |
| store | BOOLEAN | true | Persistence flag | Whether field is stored in the DB. |
| sanitize | BOOLEAN | true | HTML sanitization | Security flag for HTML fields. |
| sanitize_overridable | BOOLEAN | true | Sanitization override | Allows per-field sanitization settings. |
| sanitize_tags | BOOLEAN | true | Allowed HTML tags | Configuration for sanitization. |
| sanitize_attributes | BOOLEAN | true | Allowed HTML attributes | Configuration for sanitization. |
| sanitize_style | BOOLEAN | true | Allowed CSS styles | Configuration for sanitization. |
| sanitize_form | BOOLEAN | true | Form sanitization | Security flag. |
| strip_style | BOOLEAN | true | CSS stripping | UI formatting flag. |
| strip_classes | BOOLEAN | true | Class stripping | UI formatting flag. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| tracking | INTEGER | true | Audit tracking level | Configuration for field history. |
| website_form_blacklisted | BOOLEAN | true | Web form blacklist | Security flag for public forms. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `model_id` → `ir_model.id` (Links the field to its parent model definition).
    - `create_uid` → `res_users.id` (Links to the user who created the field definition).
    - `write_uid` → `res_users.id` (Links to the user who last modified the field definition).
- **Natural keys (inferred):**
    - `model`, `name` (The combination of model name and field name is unique within the Odoo system).

## Caveats for downstream consumers

- **Sensitive Data:** The `compute` column may contain Python code snippets; treat as potentially sensitive.
- **Timestamps:** Timestamps are generally stored in UTC by Odoo.
- **JSONB:** `field_description` and `help` are JSONB; ensure your downstream tools can parse these for multi-language support.
- **Soft Deletes:** Odoo typically does not use soft deletes for metadata tables; records are usually hard-deleted if the field is removed from the system.
- **Computed Fields:** Fields where `store` is `false` will not exist as physical columns in the corresponding model's database table.