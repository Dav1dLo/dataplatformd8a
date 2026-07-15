# account_fiscal_position_res_country_state_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `account_fiscal_position` and `res_country_state` is characteristic of Odoo's many-to-many relationship join tables, which are automatically generated to link fiscal positions to specific geographic states.

## Functional process 
This table supports the tax mapping and fiscal configuration process. It defines which fiscal positions (tax rules) are applicable to specific country states, allowing the system to automatically apply correct tax rates or accounting treatments based on the customer's or transaction's location.

## Description
This table represents a many-to-many relationship mapping between fiscal positions and geographic states. Each row acts as a link, indicating that a specific fiscal position is valid for a given state. It serves as a raw landing copy of the Odoo relational join table, used to resolve tax logic in downstream transformations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_fiscal_position_id | INTEGER | false | Foreign key to the fiscal position definition. | Links to the primary key of the fiscal position table. |
| res_country_state_id | INTEGER | false | Foreign key to the country state definition. | Links to the primary key of the country state table. |

## Keys

- **Primary key (inferred):** The composite key of (`account_fiscal_position_id`, `res_country_state_id`).
- **Foreign keys (inferred):** 
    - `account_fiscal_position_id` → `account_fiscal_position.id`: This column references the parent fiscal position record.
    - `res_country_state_id` → `res_country_state.id`: This column references the specific state record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no surrogate primary key; queries should join on both columns to ensure uniqueness.
- As a staging table, it reflects the raw state of the Odoo database; ensure that downstream joins handle potential orphans if the source system has referential integrity gaps.