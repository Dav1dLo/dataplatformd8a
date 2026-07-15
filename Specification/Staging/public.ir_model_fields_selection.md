# ir_model_fields_selection

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_model_fields_selection` (Internal Resource model fields selection) is a standard pattern used by the Odoo framework to store the selection options (dropdown values) for fields defined in the system's metadata layer.

## Functional process 
This table supports the dynamic configuration of application metadata. It stores the valid selectable options for fields that have a "selection" type, allowing the system to populate UI dropdowns and validate data inputs against a predefined set of allowed values for specific business entities.

## Description
One row in this table represents a single selectable option for a specific field within the Odoo metadata model. It acts as a raw landed copy of the system's internal configuration, mapping a technical value to a human-readable label (stored as JSONB for multi-language support).

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `ir_model_fields_selection_id_seq`. |
| field_id | INTEGER | false | Foreign key to the field definition | Links to `ir_model_fields.id`. |
| sequence | INTEGER | true | Sort order for the selection option | Used to determine the order in UI dropdowns. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| value | VARCHAR | false | The internal technical value | The value stored in the database for the field. |
| name | JSONB | false | The display label | Contains localized strings for the selection option. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `field_id` → `ir_model_fields.id`: This column links the selection option to the specific field definition it belongs to.
    - `create_uid` → `res_users.id`: Tracks the user responsible for the initial record creation.
    - `write_uid` → `res_users.id`: Tracks the user responsible for the most recent modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but contains system configuration metadata which may reveal internal business logic.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Format:** The `name` column is `JSONB`; ensure your downstream processing layer is equipped to parse JSON structures to extract the relevant language-specific labels.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.