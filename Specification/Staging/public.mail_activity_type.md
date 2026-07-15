# mail_activity_type

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `res_model`, `create_uid`, `write_uid`, `JSONB` fields for translatable strings) and the specific schema structure are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the CRM and communication management modules, specifically the "Activity" tracking system. It defines the configuration for different types of activities (e.g., "Email", "Call", "Meeting") that users can schedule against records like leads, opportunities, or partners.

## Description
One row in this table represents a single configuration definition for a mail activity type, including its scheduling logic and default values. It serves as a staging entity representing the raw metadata configuration for activity workflows within the Odoo application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order index | Used for sorting in UI dropdowns. |
| create_uid | INTEGER | true | Creator user ID | Reference to `res_users.id`. |
| delay_count | INTEGER | true | Time offset value | Numeric value for the delay duration. |
| triggered_next_type_id | INTEGER | true | Chained activity ID | Reference to `mail_activity_type.id`. |
| default_user_id | INTEGER | true | Default assigned user | Reference to `res_users.id`. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to `res_users.id`. |
| delay_unit | VARCHAR | false | Time unit | e.g., 'days', 'weeks', 'months'. |
| delay_from | VARCHAR | false | Reference date | e.g., 'current_date', 'previous_activity_deadline'. |
| icon | VARCHAR | true | UI icon identifier | FontAwesome or internal icon name. |
| decoration_type | VARCHAR | true | UI style hint | e.g., 'alert', 'success'. |
| res_model | VARCHAR | true | Target object model | The Odoo model this activity applies to. |
| chaining_type | VARCHAR | false | Chaining logic | Defines how next activities are triggered. |
| category | VARCHAR | true | Activity category | e.g., 'default', 'upload_file'. |
| name | JSONB | false | Activity type name | Translatable string. |
| summary | JSONB | true | Default summary | Translatable string. |
| default_note | JSONB | true | Default note content | Translatable string. |
| active | BOOLEAN | true | Soft-delete flag | If false, the activity type is hidden. |
| keep_done | BOOLEAN | true | Retention flag | Whether to keep the activity after completion. |
| create_date | TIMESTAMP | true | Record creation time | UTC timestamp. |
| write_date | TIMESTAMP | true | Last modification time | UTC timestamp. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field)
    - `write_uid` → `res_users.id` (Standard Odoo audit field)
    - `triggered_next_type_id` → `mail_activity_type.id` (Self-referencing link for activity chains)
    - `default_user_id` → `res_users.id` (Default assignment target)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **JSONB fields:** The `name`, `summary`, and `default_note` columns contain JSONB data, likely storing multi-language strings (e.g., `{"en_US": "Call", "fr_FR": "Appel"}`). Use `->>` operator to extract values.
- **Timestamps:** Timestamps are stored in UTC as per standard Odoo configuration.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` to retrieve only currently valid activity types.
- **Sensitivity:** No PII is expected in this configuration table, as it defines activity *types* rather than specific user-generated activity *instances*.