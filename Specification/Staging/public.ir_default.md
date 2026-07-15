# ir_default

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `ir_` prefix, `create_uid`, `write_uid`, `company_id`) is characteristic of the Odoo "ir" (Irregular/Internal) module, which manages system-wide configurations and default values for fields across the application.

## Functional process 
This table supports the "Default Value Management" process. It stores user-specific or company-specific default values for fields in the application, allowing the system to pre-populate forms or filter data based on the current user's preferences or the active company context.

## Description
One row in this table represents a single default value configuration for a specific field, optionally scoped to a user or company. It serves as a raw landed copy of the Odoo `ir.default` model, capturing the logic used to determine default values for UI fields.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.ir_default_id_seq`. |
| field_id | INTEGER | false | Foreign key to the field definition | References the field for which the default is set. |
| user_id | INTEGER | true | Foreign key to the user | If null, the default may be global or company-specific. |
| company_id | INTEGER | true | Foreign key to the company | Scopes the default value to a specific company. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| condition | VARCHAR | true | Filter condition | A string representation of the condition for applying this default. |
| json_value | VARCHAR | false | The default value | Stored as a JSON-encoded string; requires parsing. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `field_id` → `ir_model_fields.id` (Guess: links to the Odoo field definition table).
    - `user_id` → `res_users.id` (Guess: links to the Odoo user directory).
    - `company_id` → `res_company.id` (Guess: links to the Odoo company definition).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Data format:** The `json_value` column contains serialized data; ensure your downstream transformation layer includes a JSON parsing step (e.g., `jsonb` casting in PostgreSQL).
- **Timezones:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
- **PII:** While this table contains configuration data, `user_id` and audit columns link to user identities, which should be handled according to your organization's data privacy policies.