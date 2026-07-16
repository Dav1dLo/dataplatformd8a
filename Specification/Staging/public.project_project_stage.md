# project_project_stage

## Source system
This table originates from Odoo ERP, as evidenced by the characteristic naming convention (`project_project_stage`), the use of `JSONB` for multi-language fields (`name`), and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the Project Management module's workflow configuration. It defines the various stages (e.g., "To Do", "In Progress", "Done") that a project can transition through, managing the visual layout of project boards via the `sequence` and `fold` attributes, and linking automated communication triggers via `mail_template_id` and `sms_template_id`.

## Description
One row in this table represents a single project stage definition within the project management system. It serves as a raw landed staging entity, capturing the configuration and state of project stages as defined in the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.project_project_stage_id_seq`. |
| sequence | INTEGER | true | Display order index | Determines the horizontal position of the stage in a Kanban view. |
| mail_template_id | INTEGER | true | Foreign key to email template | Links to an automated email template triggered at this stage. |
| company_id | INTEGER | true | Foreign key to company | Multi-company scoping identifier. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this stage record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this stage record. |
| name | JSONB | false | Stage name | Localized name stored as a JSON object; requires parsing for specific locales. |
| active | BOOLEAN | true | Soft-delete flag | If false, the stage is hidden from the UI. |
| fold | BOOLEAN | true | UI state flag | Indicates if the stage column is collapsed in the Kanban view. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the source system. |
| sms_template_id | INTEGER | true | Foreign key to SMS template | Links to an automated SMS template triggered at this stage. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_template_id` → `mail_template.id` (Guess: links to Odoo email templates)
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link)
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo user audit trail)
    - `sms_template_id` → `sms_template.id` (Guess: links to Odoo SMS templates)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII/Sensitive Data:** No direct PII, but `create_uid` and `write_uid` link to user identity tables.
- **Timezones:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` unless historical analysis of inactive stages is required.
- **JSONB Parsing:** The `name` column is `JSONB`. Downstream consumers must use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract human-readable text.