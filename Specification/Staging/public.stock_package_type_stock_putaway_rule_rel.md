# stock_package_type_stock_putaway_rule_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the two foreign key columns is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link two distinct entities.

## Functional process 
This table supports the warehouse management and inventory putaway process. It defines the relationship between specific stock putaway rules (which dictate where items should be stored) and package types (which define the physical containers used for storage), allowing the system to restrict or prioritize certain putaway rules based on the packaging used.

## Description
One row in this table represents a single association between a stock putaway rule and a stock package type. It acts as a join table in the staging layer, providing a raw, normalized link between the two entities to enable many-to-many mapping in downstream models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_putaway_rule_id | INTEGER | false | Foreign key to the stock putaway rule entity. | Links to the primary key of the putaway rule definition. |
| stock_package_type_id | INTEGER | false | Foreign key to the stock package type entity. | Links to the primary key of the package type definition. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both `stock_putaway_rule_id` and `stock_package_type_id`.
- **Foreign keys (inferred):** 
    - `stock_putaway_rule_id` → `stock_putaway_rule.id` (Inferred from Odoo naming convention).
    - `stock_package_type_id` → `stock_package_type.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** The combination of `(stock_putaway_rule_id, stock_package_type_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this against the parent `stock_putaway_rule` and `stock_package_type` tables to retrieve meaningful attributes.
- There are no timestamps or audit columns present; it is impossible to determine when these relationships were created or modified from this table alone.
- This table contains no PII or sensitive financial data.
- As a staging table, it reflects the raw state of the Odoo database; ensure downstream models handle potential orphaned records if referential integrity is not strictly enforced in the source.