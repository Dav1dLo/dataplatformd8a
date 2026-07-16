# stock_rules_report_stock_warehouse_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `*_rel` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link two entities—in this case, stock reporting rules and warehouse definitions.

## Functional process 
This table supports the inventory management and logistics configuration process. It defines the many-to-many relationship between stock reporting rules (which dictate how stock levels are monitored or replenished) and specific warehouses, ensuring that reporting logic is correctly scoped to the relevant physical or logical storage locations.

## Description
One row in this table represents a single association between a stock rules report and a warehouse. It serves as a raw junction table in the staging layer, facilitating the mapping of reporting configurations to warehouse entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_rules_report_id | INTEGER | false | Foreign key to the stock rules report entity. | Links to the parent report configuration. |
| stock_warehouse_id | INTEGER | false | Foreign key to the warehouse entity. | Identifies the warehouse associated with the report. |

## Keys

- **Primary key (inferred):** The combination of `(stock_rules_report_id, stock_warehouse_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `stock_rules_report_id` → `stock_rules_report.id` (Inferred based on Odoo naming patterns).
    - `stock_warehouse_id` → `stock_warehouse.id` (Inferred based on Odoo naming patterns).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; incremental loading logic should rely on upstream source system change-tracking if available.
- Ensure joins to parent tables handle potential orphans if referential integrity is not strictly enforced at the database level in the source system.