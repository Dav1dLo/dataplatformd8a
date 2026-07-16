# onboarding_onboarding

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns like `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo models, and the use of `JSONB` for localized fields.

## Functional process 
This table supports the user interface onboarding and guided tour configuration process. It tracks the sequence and configuration of onboarding panels or steps presented to users within the application, including the routing and completion text associated with each step.

## Description
One row in this table represents a single step or panel within an onboarding workflow. It serves as a raw landed copy of the onboarding configuration metadata, capturing the order, associated actions, and localized display names for the onboarding process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.onboarding_onboarding_id_seq`. |
| sequence | INTEGER | true | Display order index | Determines the order in which steps appear. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the users table. |
| route_name | VARCHAR | false | Internal route identifier | The unique path or action name for the step. |
| text_completed | VARCHAR | true | Completion message | Text displayed when the step is finished. |
| panel_close_action_name | VARCHAR | true | Close action identifier | The name of the action triggered when closing the panel. |
| name | JSONB | true | Localized display name | Contains multi-language strings for the step name. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for record creation tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for record modification tracking).
- **Natural keys (inferred):** 
    - `route_name` (Likely acts as the unique business identifier for the onboarding step).

## Caveats for downstream consumers

- **Sensitive Data:** The `create_uid` and `write_uid` columns link to user identity; ensure appropriate access controls are applied.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **JSONB:** The `name` column contains structured data; downstream consumers will need to use PostgreSQL `->>` or `->` operators to extract specific language keys.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all records are currently active unless otherwise specified by business logic.