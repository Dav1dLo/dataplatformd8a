# ir_config_parameter

## Source system
This table originates from an Odoo ERP system, as evidenced by the `ir_` (Internal Resource) prefix and the specific pattern of `create_uid`, `write_uid`, and `*_date` audit columns which are standard in Odoo's ORM layer.

## Functional process 
This table supports the application configuration management process. It stores global system parameters and settings that dictate the behavior of the ERP instance, such as system URLs, report settings, or feature flags, allowing administrators to modify application behavior without changing source code.

## Description
One row in this table represents a single configuration key-value pair used by the application runtime. It serves as a raw landed copy of the system's configuration registry, capturing the current state and audit trail for each parameter.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_config_parameter_id_seq`. |
| create_uid | INTEGER | true | User ID who created the parameter | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the parameter | References `res_users.id`. |
| key | VARCHAR | false | Unique configuration parameter name | The lookup key used by the application code. |
| value | TEXT | false | Configuration value | Stores the actual setting; may contain JSON or serialized data. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Tracks the user responsible for the initial record creation.
    - `write_uid` → `res_users.id`: Tracks the user responsible for the most recent modification.
- **Natural keys (inferred):** 
    - `key`: The configuration parameter name is unique within the system.

## Caveats for downstream consumers

- **Timestamps:** Values are stored in the server's local time; verify the server timezone configuration if performing cross-system time analysis.
- **Data format:** The `value` column is `TEXT` and may contain complex strings, serialized objects, or JSON blobs depending on the specific configuration parameter.
- **Soft deletes:** This table does not implement soft deletes; records are typically hard-deleted or updated in place.
- **Sensitive data:** Be aware that some configuration parameters may store API keys, tokens, or internal system URLs; ensure appropriate masking if exposing this data to non-admin users.