# hr_skill

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions (`create_uid`, `write_uid`, `write_date`), the use of `JSONB` for multi-lingual fields, and the reliance on standard PostgreSQL sequences for primary keys.

## Functional process 
This table supports the Human Resources management module, specifically the tracking and categorization of employee competencies. It acts as a master reference for skill definitions, which are subsequently linked to employee profiles to manage talent acquisition, performance reviews, and training requirements.

## Description
One row in this table represents a single skill definition available within the HR system. It serves as a raw landed copy of the skill master data, capturing the skill's identity, its display name (stored as a JSON object for localization), and audit metadata for tracking record creation and modifications.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `hr_skill_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort skills in UI dropdowns or lists. |
| skill_type_id | INTEGER | false | Foreign key to skill category | Links to the parent skill type or category definition. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | JSONB | false | Skill name | Multi-lingual string storage; usually contains keys for language codes. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `skill_type_id` → `hr_skill_type.id` (Inferred based on Odoo naming patterns for category/type relationships).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** None identified; this table contains public-facing skill definitions.
- **Timestamps:** Assumed to be in UTC as per standard Odoo/PostgreSQL configurations.
- **Soft Deletes:** This table does not appear to implement soft-delete flags (e.g., `active` column); assume all records are current unless otherwise specified by the source system logic.
- **JSONB Handling:** The `name` column requires extraction (e.g., `name->>'en_US'`) to be used in standard reporting tools.
- **Data Integrity:** As a staging table, ensure that `skill_type_id` references are validated against the corresponding `hr_skill_type` table before joining.