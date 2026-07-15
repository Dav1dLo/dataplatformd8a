# mail_activity_plan_mail_activity_schedule_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular business application. The naming convention `_rel` combined with the two foreign key columns is characteristic of Odoo's automated many-to-many relationship tables, which link activity plans to their respective scheduling configurations.

## Functional process 
This table supports the "Marketing Automation" or "Email Campaign Management" process. It acts as a join table to associate specific email activity plans with their defined scheduling rules, ensuring that automated communications are triggered according to the correct timing parameters.

## Description
One row in this table represents a single association between a mail activity plan and a mail activity schedule. It serves as a raw landing copy of the join table from the source system, maintaining the many-to-many relationship between the two entities at the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_activity_schedule_id | INTEGER | false | Foreign key to the mail activity schedule definition. | Links to the schedule configuration. |
| mail_activity_plan_id | INTEGER | false | Foreign key to the mail activity plan definition. | Links to the parent activity plan. |

## Keys

- **Primary key (inferred):** The combination of `mail_activity_schedule_id` and `mail_activity_plan_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `mail_activity_schedule_id` → `mail_activity_schedule.id`: This column references the schedule entity definition.
    - `mail_activity_plan_id` → `mail_activity_plan.id`: This column references the activity plan entity definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume this table reflects the current state of relationships as captured during the last ingestion.
- Ensure that joins to parent tables handle potential orphaned records if referential integrity is not strictly enforced in the source system.