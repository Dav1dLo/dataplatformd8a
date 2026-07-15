# crm_stage

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo models, and the use of `JSONB` for the `name` field, which is common in Odoo's multi-language field implementation.

## Functional process 
This table supports the Sales Pipeline management process. It defines the various stages (e.g., "New", "Qualified", "Proposition", "Won") that a lead or opportunity progresses through within a CRM module. The `is_won` flag indicates terminal success stages, while `fold` suggests UI-level configuration for hiding stages in a Kanban view.

## Description
One row represents a single stage configuration within a CRM sales pipeline. It acts as a raw landed copy of the stage definition metadata, capturing the sequence, ownership, and functional properties of each pipeline step.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_stage_id_seq`. |
| sequence | INTEGER | true | Display order index | Determines the order of stages in the UI. |
| team_id | INTEGER | true | Foreign key to sales team | Links the stage to a specific sales team. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this stage. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this stage. |
| name | JSONB | false | Stage name | Likely contains localized strings (e.g., `{"en_US": "Won"}`). |
| requirements | TEXT | true | Stage requirements | Instructions or criteria for moving to this stage. |
| is_won | BOOLEAN | true | Success indicator | True if this stage represents a won opportunity. |
| fold | BOOLEAN | true | Kanban fold status | If true, the stage is collapsed in the Kanban view. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone unknown. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone unknown. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `team_id` → `crm_team.id` (Guess: standard Odoo relationship to sales teams).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory for PII masking if required.
- **Timezones:** Timestamps (`create_date`, `write_date`) are stored as `TIMESTAMP` without timezone; assume UTC unless otherwise specified by the source Odoo configuration.
- **JSONB Handling:** The `name` column is a `JSONB` object; downstream SQL queries will require extraction (e.g., `name->>'en_US'`) to retrieve human-readable text.
- **Data Integrity:** This is a raw staging table; it may contain historical versions or duplicates if the ingestion process is not idempotent.