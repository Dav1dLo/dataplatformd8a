# mail_activity_plan_template

## Source system
This table originates from Odoo (OpenERP), as evidenced by the naming convention (`mail_activity_plan_template`), the use of `create_uid`/`write_uid` audit columns, and the sequence-based primary key pattern typical of the Odoo ORM.

## Functional process 
This table supports the "Activity Planning" process within the Odoo Marketing or CRM modules. It defines the structure of activity plans, which are templates used to automate the creation of follow-up tasks or communications (activities) associated with a specific business object, such as a lead or an opportunity.

## Description
One row represents a single step or activity definition within a predefined activity plan template. It specifies the type of activity, the timing (delay), and the responsible party for that specific step. This table serves as a raw landed copy of the Odoo configuration data in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_activity_plan_template_id_seq`. |
| plan_id | INTEGER | false | Foreign key to the parent plan | Links to the header record of the activity plan. |
| sequence | INTEGER | true | Display order | Determines the order of activities in the plan. |
| activity_type_id | INTEGER | false | Activity type identifier | Links to the definition of the activity (e.g., Email, Call). |
| delay_count | INTEGER | true | Time offset value | Numeric value for the delay duration. |
| responsible_id | INTEGER | true | User ID of the responsible party | The user assigned to perform this activity. |
| create_uid | INTEGER | true | Creator user ID | Audit column for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit column for record updates. |
| delay_unit | VARCHAR | false | Time unit for delay | e.g., 'days', 'weeks', 'months'. |
| delay_from | VARCHAR | false | Reference point for delay | e.g., 'current_date', 'before_deadline'. |
| summary | VARCHAR | true | Activity summary/title | Short description of the activity. |
| responsible_type | VARCHAR | false | Responsibility assignment type | Defines how the user is assigned (e.g., 'user', 'manager'). |
| note | TEXT | true | Detailed instructions | Rich text or plain text notes for the activity. |
| create_date | TIMESTAMP | true | Creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `plan_id` → `mail_activity_plan.id` (Likely parent container for the plan template).
    - `activity_type_id` → `mail_activity_type.id` (Defines the nature of the activity).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** Odoo typically performs hard deletes on configuration tables; however, verify if `active` flags exist in related tables if filtering is required.
- **Sensitive Data:** `create_uid` and `write_uid` link to user tables which may contain PII; ensure appropriate access controls are applied when joining to user-related dimensions.
- **Data Integrity:** `delay_unit` and `delay_from` are critical for calculating due dates; ensure these are validated against expected business logic strings before use in downstream transformations.