# sale_order_tag_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular relational system. The naming convention `_rel` is a standard pattern in Odoo for join tables that manage many-to-many relationships between core entities (in this case, sales orders and tags).

## Functional process 
This table supports the categorization and metadata tagging process for sales orders. It enables the association of multiple descriptive tags (e.g., "Priority", "Wholesale", "International") with individual sales orders, facilitating downstream reporting, filtering, and workflow automation.

## Description
One row represents a single association between a sales order and a specific tag. It acts as a junction table to resolve a many-to-many relationship between the `sale_order` and `tag` entities. As a staging table, it provides a raw, normalized link between these two entities for downstream transformation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| order_id | INTEGER | false | Foreign key to the sales order | Links to the primary key of the sales order table. |
| tag_id | INTEGER | false | Foreign key to the tag definition | Links to the primary key of the tag lookup table. |

## Keys

- **Primary key (inferred):** The combination of `(order_id, tag_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `order_id` → `sale_order.id`: This column identifies the specific order being tagged.
    - `tag_id` → `tag.id`: This column identifies the specific tag being applied to the order.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only the relationship link.
- There are no timestamps or audit columns present; incremental loading logic must rely on the upstream source's change data capture (CDC) or full-table replacement.
- Ensure inner joins are used when filtering by tag, as an order without tags will not appear in this table.