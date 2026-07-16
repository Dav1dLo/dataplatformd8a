# project_share_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention `res_id`, `res_model`, `create_uid`, and the use of `nextval` sequences for primary keys are characteristic of the Odoo framework's internal object-relational mapping (ORM) layer.

## Functional process 
This table supports the "Share" functionality within the Odoo platform, which allows users to generate access links or invitations for specific records. It tracks the configuration of these sharing wizards, linking them to the target record (`res_id`) and the specific business object (`res_model`) being shared.

## Description
One row represents a single instance of a "Share" wizard session initiated by a user. It acts as a staging record for the configuration of sharing permissions or notes associated with a specific entity in the system. This is a raw landed copy of the wizard state, intended for tracking user-initiated sharing activities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| res_id | INTEGER | false | ID of the target record | References the record being shared. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the share. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the wizard. |
| res_model | VARCHAR | false | Target model name | The technical name of the Odoo model (e.g., 'project.project'). |
| note | TEXT | true | Share description | Optional text provided by the user during the share process. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `note` column may contain free-text information; ensure it is scanned for PII if shared externally.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's default database configuration.
- **Data Retention:** This table tracks wizard sessions; it does not necessarily represent a permanent record of access, but rather the configuration of the share event itself.
- **Model Polymorphism:** The `res_model` column is polymorphic; queries joining against this table must filter by `res_model` to ensure the `res_id` is joined to the correct target table.