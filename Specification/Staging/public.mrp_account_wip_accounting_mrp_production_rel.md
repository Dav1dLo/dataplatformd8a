# mrp_account_wip_accounting_mrp_production_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the naming convention `mrp_account_wip_accounting_mrp_production_rel`. The `_rel` suffix is a standard pattern used by the Odoo ORM to represent a many-to-many relationship table between two entities.

## Functional process 
This table supports the manufacturing accounting process, specifically linking Work-in-Progress (WIP) accounting entries to specific manufacturing production orders. It facilitates the traceability of financial costs associated with ongoing production cycles.

## Description
One row in this table represents a single association between a WIP accounting record and a manufacturing production order. It serves as a raw junction table in the staging layer, maintaining the many-to-many relationship required to reconcile production activities with their corresponding financial WIP accounts.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_account_wip_accounting_id | INTEGER | false | Foreign key to the WIP accounting record. | Links to the primary key of the WIP accounting table. |
| mrp_production_id | INTEGER | false | Foreign key to the manufacturing production order. | Links to the primary key of the production order table. |

## Keys

- **Primary key (inferred):** The composite key of (`mrp_account_wip_accounting_id`, `mrp_production_id`).
- **Foreign keys (inferred):** 
    - `mrp_account_wip_accounting_id` → `mrp_account_wip_accounting.id`: Evidence is the column name prefix matching the target table.
    - `mrp_production_id` → `mrp_production.id`: Evidence is the column name prefix matching the target table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this with both the WIP accounting and production order tables to retrieve meaningful business attributes.
- No soft-delete flags are present; assume this table represents the current state of relationships as captured from the source system.
- Ensure that joins are performed on both columns to maintain the integrity of the many-to-many relationship.