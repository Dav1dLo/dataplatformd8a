# mail_template_ir_actions_report_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific association of `mail_template` and `ir_actions_report` is characteristic of Odoo's many-to-many relationship join tables, which are automatically generated to link email templates to report actions.

## Functional process 
This table supports the document reporting and notification process. It facilitates the association between specific email templates and report actions, allowing the system to determine which report (e.g., an invoice or purchase order PDF) should be attached or referenced when a specific email template is triggered.

## Description
This table represents a many-to-many join relationship between email templates and report actions. Each row maps a single `mail_template` to an `ir_actions_report`, enabling the system to associate multiple reports with a single template or vice versa. It serves as a raw landing copy of the Odoo relational link table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_template_id | INTEGER | false | Foreign key to the mail template definition | References the primary key of the `mail_template` table. |
| ir_actions_report_id | INTEGER | false | Foreign key to the report action definition | References the primary key of the `ir_actions_report` table. |

## Keys

- **Primary key (inferred):** The composite key of (`mail_template_id`, `ir_actions_report_id`).
- **Foreign keys (inferred):** 
    - `mail_template_id` → `mail_template.id`: This column links to the email template configuration.
    - `ir_actions_report_id` → `ir_actions_report.id`: This column links to the report action configuration.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes, only relational identifiers.
- There are no timestamps or soft-delete flags; this table reflects the current state of associations in the source system.
- Ensure joins to the parent tables handle the `INTEGER` types correctly to avoid implicit casting issues in downstream transformations.