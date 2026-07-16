# pos_config_product_pricelist_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `pos_config_product_pricelist_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link Point of Sale (POS) configurations to available product pricelists.

## Functional process 
This table supports the Point of Sale (POS) configuration process by defining the mapping between specific POS terminals or shop settings and the pricelists they are authorized to use. It ensures that when a cashier processes a sale, the system knows which pricing rules apply based on the active POS configuration.

## Description
One row in this table represents a single association between a POS configuration and a product pricelist. It acts as a join table to resolve a many-to-many relationship, allowing a POS configuration to support multiple pricelists and a pricelist to be assigned to multiple POS configurations. This is a raw landed copy of the association table from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Links to the primary key of the POS configuration table. |
| product_pricelist_id | INTEGER | false | Foreign key to the product pricelist | Links to the primary key of the product pricelist table. |

## Keys

- **Primary key (inferred):** The composite of (`pos_config_id`, `product_pricelist_id`).
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id` (Inferred from Odoo naming conventions).
    - `product_pricelist_id` → `product_pricelist.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic should rely on the source system's replication metadata if available.
- Ensure inner joins are used when filtering by configuration or pricelist to avoid orphaned records if the source system has referential integrity gaps.