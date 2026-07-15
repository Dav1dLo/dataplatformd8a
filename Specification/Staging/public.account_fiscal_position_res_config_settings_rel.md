# account_fiscal_position_res_config_settings_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `res_config_settings` and `account_fiscal_position` is characteristic of Odoo's automated many-to-many relationship tables generated for ORM models.

## Functional process 
This table supports the configuration of fiscal positions within the accounting module. It maps specific fiscal position definitions to configuration settings, likely determining which fiscal rules are active or enabled within a specific company or system configuration context.

## Description
One row represents a single association between a configuration setting record and a fiscal position record. This is a junction table used to resolve a many-to-many relationship between the two entities. It serves as a raw landing copy of the link table from the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| res_config_settings_id | INTEGER | false | Foreign key to the configuration settings table. | Links to the parent configuration record. |
| account_fiscal_position_id | INTEGER | false | Foreign key to the fiscal position definition table. | Links to the specific fiscal position being configured. |

## Keys

- **Primary key (inferred):** The combination of (`res_config_settings_id`, `account_fiscal_position_id`) is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `res_config_settings_id` → `res_config_settings.id`: This column references the primary key of the configuration settings table.
    - `account_fiscal_position_id` → `account_fiscal_position.id`: This column references the primary key of the fiscal position table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no timestamps or audit columns; it is a pure join table.
- There is no soft-delete flag; if a record is missing, the relationship has been removed in the source system.
- Ensure joins to parent tables handle the `INTEGER` types correctly to avoid implicit casting issues if the target tables use `BIGINT`.