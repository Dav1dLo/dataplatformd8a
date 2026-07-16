# res_country_res_country_group_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the `res_country_res_country_group_rel` naming convention, which is the standard pattern Odoo uses for many-to-many relationship tables linking countries to country groups.

## Functional process 
This table supports the management of geographical groupings, such as trade zones, tax regions, or shipping areas. It facilitates the association of multiple countries into specific country groups, enabling the application of business rules (e.g., pricing, tax rates, or shipping restrictions) to entire groups rather than individual countries.

## Description
One row in this table represents a single association between a country and a country group. It serves as a junction table in the staging layer, providing a raw, normalized link between the `res_country` and `res_country_group` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| res_country_id | INTEGER | false | Foreign key to the country record | Links to the primary key of the country table. |
| res_country_group_id | INTEGER | false | Foreign key to the country group record | Links to the primary key of the country group table. |

## Keys

- **Primary key (inferred):** The composite key `(res_country_id, res_country_group_id)`.
- **Foreign keys (inferred):** 
    - `res_country_id` → `res_country.id`: Links to the specific country entity.
    - `res_country_group_id` → `res_country_group.id`: Links to the specific country group entity.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; it represents the current state of the relationship.
- Ensure that joins to this table are performed on both columns to maintain the integrity of the many-to-many relationship.