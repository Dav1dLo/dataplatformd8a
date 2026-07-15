# hr_departure_reason

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for the `name` field, which is characteristic of Odoo's multi-language field storage.

## Functional process 
This table supports the Human Resources offboarding process by maintaining a standardized list of reasons for employee departures. These reasons are likely used in HR reporting and analytics to categorize turnover trends.

## Description
One row in this table represents a single defined reason for an employee's departure from the organization. It serves as a reference or lookup table within the staging layer, providing descriptive labels for departure codes used in broader HR modules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `hr_departure_reason_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort reasons in UI dropdowns. |
| reason_code | INTEGER | true | Business-level reason identifier | Likely maps to a legacy or external system code. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| name | JSONB | false | Departure reason label | Stores localized strings (e.g., {"en_US": "Resignation"}). |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` column contains localized data. Query writers must extract the relevant language key (e.g., `name->>'en_US'`) to retrieve human-readable text.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal system user IDs; they do not contain PII directly but link to the user management module.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all rows are active unless otherwise specified by business logic.