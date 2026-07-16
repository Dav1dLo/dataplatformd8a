# web_tour_tour

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the specific sequence pattern used for the primary key (`"public".web_tour_tour_id_seq`).

## Functional process 
This table supports the "Guided Tour" or "Onboarding" module within the application. It stores the configuration for interactive user tours that guide users through specific UI workflows, tracking the sequence of steps, the target URL for the tour, and custom messages displayed upon completion.

## Description
One row represents a single guided tour configuration defined within the system. It acts as a raw landed copy of the tour metadata, capturing the tour's name, its associated URL, and the JSON-formatted success message (rainbow man message) shown to the user upon completion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `web_tour_tour_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort tours in the UI. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to `res_users`. |
| name | VARCHAR | false | Tour display name | Human-readable identifier for the tour. |
| url | VARCHAR | true | Target path | The relative URL where the tour is active. |
| rainbow_man_message | JSONB | true | Completion message | JSON payload containing the success message. |
| custom | BOOLEAN | true | Custom flag | Indicates if the tour is user-defined vs system-default. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `name` (Assuming tour names are unique within the application context).

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, though `rainbow_man_message` may contain user-specific content or internal system paths.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume all rows are current unless otherwise specified by the application logic.
- **JSONB:** The `rainbow_man_message` column requires `jsonb` extraction functions (e.g., `->>`) for downstream analysis.