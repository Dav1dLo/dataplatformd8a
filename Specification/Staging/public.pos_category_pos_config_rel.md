# pos_category_pos_config_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link two entities—in this case, Point of Sale (POS) configurations and POS product categories.

## Functional process 
This table supports the Point of Sale configuration process by defining the relationship between specific POS configurations and the product categories available within those configurations. It acts as a mapping table to control which categories are visible or selectable in a given POS interface.

## Description
One row represents a single association between a POS configuration and a product category. It is a raw, landed copy of a join table used to resolve a many-to-many relationship, serving as the foundation for downstream dimension modeling of POS menu structures.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Links to the primary POS setup entity. |
| pos_category_id | INTEGER | false | Foreign key to the product category | Links to the specific category allowed in the config. |

## Keys

- **Primary key (inferred):** Not confidently inferable. This table likely uses a composite primary key consisting of both `pos_config_id` and `pos_category_id`.
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id` (Guess: standard Odoo naming pattern for POS configuration links).
    - `pos_category_id` → `pos_category.id` (Guess: standard Odoo naming pattern for category links).
- **Natural keys (inferred):** 
    - The combination of (`pos_config_id`, `pos_category_id`) acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure that downstream joins handle the potential for duplicate pairs if the source system allows re-assignment of the same category to the same config.