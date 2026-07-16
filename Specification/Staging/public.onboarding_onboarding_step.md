# onboarding_onboarding_step

## Source system
This table originates from an Odoo ERP instance, as evidenced by the naming convention (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for translatable fields, and the specific sequence naming pattern (`nextval('"public".onboarding_onboarding_step_id_seq'::regclass)`).

## Functional process 
This table supports the "User Onboarding" or "Guided Setup" process within the application. It defines the individual steps presented to users during initial configuration, managing the sequence, UI elements (icons, images), and localized text content for each step.

## Description
One row in this table represents a single configuration step within an onboarding workflow. It acts as a raw landed copy of the application's step definition metadata, capturing both the structural sequence and the localized content required to render the step in the user interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| sequence | INTEGER | true | Display order | Determines the order in which steps appear. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the step. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the step. |
| done_icon | VARCHAR | true | Icon identifier | Name or path of the icon displayed when the step is completed. |
| step_image_filename | VARCHAR | true | Image file name | Filename of the visual asset associated with the step. |
| panel_step_open_action_name | VARCHAR | true | Action trigger | The name of the system action triggered when the step is opened. |
| title | JSONB | true | Localized title | Multi-language title content. |
| description | JSONB | true | Localized description | Multi-language descriptive text. |
| button_text | JSONB | false | Localized button label | Multi-language text for the primary action button. |
| done_text | JSONB | true | Localized completion text | Multi-language text displayed upon step completion. |
| step_image_alt | JSONB | true | Localized alt text | Multi-language accessibility text for the step image. |
| is_per_company | BOOLEAN | true | Multi-tenancy flag | Indicates if the step configuration is specific to a company. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB content:** The `title`, `description`, `button_text`, `done_text`, and `step_image_alt` columns contain JSONB data, likely structured as `{"en_US": "...", "fr_FR": "..."}`. You will need to use the `->>` operator to extract specific language values.
- **Timestamps:** Timestamps are stored in the database server's local time (typically UTC in Odoo environments), but verify against the application settings.
- **Soft deletes:** This table does not appear to implement a soft-delete flag; assume all records are active unless otherwise specified by business logic.
- **Audit fields:** `create_uid` and `write_uid` refer to internal system user IDs and may not be present in the `res_users` table if the user has been deleted.