# res_country_group_pricelist_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_country_group_pricelist_rel` is characteristic of Odoo's automated many-to-many relationship tables, where `res` refers to the "Resource" module (containing core entities like countries and groups) and `rel` indicates a join table.

## Functional process 
This table supports the pricing and localization engine by mapping specific pricelists to country groups. This allows the system to apply region-specific pricing strategies (e.g., "EU Zone" or "North America") to customers based on their location, ensuring that the correct currency and price list are selected during the checkout or quotation process.

## Description
Each row represents a single association between a specific pricelist and a country group. It acts as a bridge table to resolve a many-to-many relationship, enabling a single pricelist to be assigned to multiple country groups and vice versa. As a staging table, it provides a raw, normalized view of these associations as they exist in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pricelist_id | INTEGER | false | Foreign key to the pricelist definition | Links to the primary pricelist entity. |
| res_country_group_id | INTEGER | false | Foreign key to the country group definition | Links to the grouping of countries. |

## Keys

- **Primary key (inferred):** The combination of `(pricelist_id, res_country_group_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `pricelist_id` → `product_pricelist.id` (Inferred from Odoo standard naming conventions).
    - `res_country_group_id` → `res_country_group.id` (Inferred from Odoo standard naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when these relationships were created or modified from this table alone.
- Ensure that joins to target tables handle potential missing records if the source system has referential integrity gaps.