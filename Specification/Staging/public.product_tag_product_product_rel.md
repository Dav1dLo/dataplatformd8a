# product_tag_product_product_rel

## Source system
The table likely originates from an Odoo or Django-based ERP/CMS system. The naming convention `[app]_[model]_[related_model]_rel` is a standard pattern used by the Django ORM to manage many-to-many relationship tables in the underlying database.

## Functional process 
This table supports the product categorization and tagging process. It acts as a bridge table to facilitate a many-to-many relationship between products and their associated descriptive tags, allowing a single product to have multiple tags and a single tag to be applied to multiple products.

## Description
One row in this table represents a single association between a specific product and a specific tag. It is a raw landing of a junction table, serving as the primary source for resolving many-to-many relationships between the product catalog and tag taxonomy in downstream models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_product_id | INTEGER | false | Foreign key to the product entity | Links to the primary product table. |
| product_tag_id | INTEGER | false | Foreign key to the tag entity | Links to the product tag definition table. |

## Keys

- **Primary key (inferred):** The composite of (`product_product_id`, `product_tag_id`).
- **Foreign keys (inferred):** 
    - `product_product_id` → `product_product.id` (Inferred from standard Django/Odoo naming conventions).
    - `product_tag_id` → `product_tag.id` (Inferred from standard Django/Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- Expect high cardinality and frequent joins; ensure indexes are maintained on both columns for query performance.
- As a raw staging table, it may contain orphaned references if referential integrity is not strictly enforced at the source database level.