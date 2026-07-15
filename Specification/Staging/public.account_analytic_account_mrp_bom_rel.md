# account_analytic_account_mrp_bom_rel

## Source system
This table originates from an Odoo ERP environment, as indicated by the naming convention `account_analytic_account_mrp_bom_rel`. The `_rel` suffix is a standard pattern used by Odoo's ORM to denote a many-to-many join table between two entities: analytic accounts and Manufacturing Resource Planning (MRP) Bills of Materials (BOM).

## Functional process 
This table supports the integration between cost accounting and manufacturing processes. It maps specific analytic accounts (used for tracking costs and revenues) to Bills of Materials, allowing the system to associate manufacturing costs or production activities with specific analytical dimensions or projects.

## Description
One row in this table represents a single association between an analytic account and a Bill of Materials. It acts as a link table (junction table) to facilitate a many-to-many relationship, ensuring that production costs defined by a BOM can be attributed to the correct analytical accounting entity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_analytic_account_id | INTEGER | false | Foreign key to the analytic account | Links to the primary key of the analytic account table. |
| mrp_bom_id | INTEGER | false | Foreign key to the MRP Bill of Materials | Links to the primary key of the mrp_bom table. |

## Keys

- **Primary key (inferred):** The composite of (`account_analytic_account_id`, `mrp_bom_id`).
- **Foreign keys (inferred):** 
    - `account_analytic_account_id` → `account_analytic_account.id`: This column references the analytic account entity.
    - `mrp_bom_id` → `mrp_bom.id`: This column references the manufacturing bill of materials entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes or timestamps.
- There is no surrogate primary key; queries should join on both columns to ensure uniqueness.
- As a staging table, it reflects the raw state of the relationship; ensure that downstream models handle potential orphaned records if referential integrity is not enforced at the database level in the source system.