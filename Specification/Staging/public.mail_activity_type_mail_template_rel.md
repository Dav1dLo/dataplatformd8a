# mail_activity_type_mail_template_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `_rel` combined with the specific pairing of `mail_activity_type` and `mail_template` is characteristic of Odoo's many-to-many relational join tables used to link activity types (e.g., "Email", "Call") to specific email templates.

## Functional process 
This table supports the automated communication and CRM workflow process. It defines which email templates are available or associated with specific activity types, ensuring that when a user triggers a specific activity, the correct template is presented or used for correspondence.

## Description
One row in this table represents a single association between a mail activity type and a mail template. It acts as a junction table to resolve a many-to-many relationship between these two entities. As a staging table, it provides a raw, direct copy of the link records as they exist in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_activity_type_id | INTEGER | false | Foreign key to the mail activity type definition. | Links to the primary key of the activity type table. |
| mail_template_id | INTEGER | false | Foreign key to the mail template definition. | Links to the primary key of the mail template table. |

## Keys

- **Primary key (inferred):** The combination of `(mail_activity_type_id, mail_template_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `mail_activity_type_id` → `mail_activity_type.id`: This column references the definition of the activity type.
    - `mail_template_id` → `mail_template.id`: This column references the specific email template content.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this table reflects the current state of associations in the source system.
- Ensure joins to parent tables handle the potential for orphaned records if referential integrity is not strictly enforced in the source system.