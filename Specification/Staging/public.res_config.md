# res_config

## Source system
This table originates from an Odoo ERP system. The naming convention `res_config` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of the Odoo `res` (resource) module, which manages system-wide configuration settings.

## Functional process 
This table supports the system configuration and settings management process. It acts as a central repository for application-level parameters that dictate the behavior of the ERP instance, such as feature toggles, integration endpoints, or global business rules.

## Description
One row in this table represents a specific configuration record or a set of system parameters within the Odoo environment. It serves as a raw landed copy of the configuration state, capturing the audit trail of who modified the settings and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `res_config_id_seq` for auto-incrementing values. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC; records when the config was initialized. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC; records the last update to the config. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the database server's local time (typically UTC in Odoo deployments), but verify against the application server settings.
- **Audit columns:** `create_uid` and `write_uid` may be null if the record was created via system migration or automated scripts without a linked user context.
- **Data volatility:** This table is frequently updated; downstream processes should handle potential race conditions if reading while the application is actively modifying settings.
- **Sensitivity:** While this table contains configuration, it may contain sensitive API keys or integration secrets depending on the specific Odoo modules installed.