# account_analytic_plan

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`account_analytic_plan`), the use of `JSONB` for translatable fields (`name`, `default_applicability`), and the standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the Analytical Accounting module, specifically the configuration of analytic plans used for cost center tracking and budget allocation. It manages the hierarchical structure of analytic plans, allowing organizations to define multi-dimensional reporting structures for financial analysis.

## Description
One row represents a single analytic plan or sub-plan within the organization's analytical accounting structure. It acts as a raw landed copy of the Odoo configuration entity, capturing the plan's hierarchy, display properties, and applicability rules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| parent_id | INTEGER | true | Self-referencing foreign key to parent plan | Defines the hierarchy level. |
| color | INTEGER | true | UI color index | Used for visual grouping in the Odoo interface. |
| sequence | INTEGER | true | Sort order | Determines display order in lists. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| parent_path | VARCHAR | true | Materialized path for hierarchy | Used for efficient tree traversal queries. |
| complete_name | VARCHAR | true | Full hierarchical name | Concatenated path of names for display. |
| name | JSONB | false | Plan name | Multi-language support; contains localized strings. |
| default_applicability | JSONB | true | Default application rules | Configuration for how this plan applies to accounts. |
| description | TEXT | true | Detailed description | Optional notes regarding the plan's purpose. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `public.account_analytic_plan.id`: Links a sub-plan to its parent plan to form a tree structure.
    - `create_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking record creation.
    - `write_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking record updates.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` and `default_applicability` columns contain JSONB data. Consumers must use PostgreSQL JSON operators (e.g., `->>`) to extract values.
- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Hierarchy:** The `parent_path` column is a materialized path (e.g., "1/5/12"). Use this for recursive tree queries rather than self-joining on `parent_id` for performance.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically hard-deleted in Odoo unless an `active` boolean column is present (which is absent here).