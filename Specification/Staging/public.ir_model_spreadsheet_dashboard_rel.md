# ir_model_spreadsheet_dashboard_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `ir_model_..._rel` is a standard pattern used by the Odoo ORM to manage many-to-many relationship tables between internal registry models.

## Functional process 
This table supports the linking of spreadsheet dashboards to specific Odoo data models. It facilitates the association between analytical dashboard configurations and the underlying business objects they are intended to report on or interact with.

## Description
Each row represents a single association between a spreadsheet dashboard and an Odoo model. It acts as a join table in the staging layer, preserving the raw many-to-many relationship structure as defined in the source system's database schema.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| spreadsheet_dashboard_id | INTEGER | false | Foreign key to the spreadsheet dashboard definition. | Links to the primary key of the dashboard table. |
| ir_model_id | INTEGER | false | Foreign key to the Odoo model definition. | Links to the primary key of the `ir_model` table. |

## Keys

- **Primary key (inferred):** The combination of `(spreadsheet_dashboard_id, ir_model_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `spreadsheet_dashboard_id` → `spreadsheet_dashboard.id` (Inferred from Odoo naming conventions).
    - `ir_model_id` → `ir_model.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no surrogate primary key; queries should rely on the composite key for uniqueness.
- As a staging table, this reflects the raw state of the relationship; ensure that downstream models handle potential orphaned records if referential integrity is not strictly enforced in the source.