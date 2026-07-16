# mrp_workcenter

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`mrp_workcenter`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the specific use of `analytic_distribution` (JSONB) and `resource_calendar_id` which are characteristic of Odoo's manufacturing and resource management modules.

## Functional process 
This table supports the Manufacturing Resource Planning (MRP) process by defining the physical or logical work centers where production operations occur. It tracks capacity, cost-per-hour, and efficiency metrics used to schedule production orders and calculate manufacturing costs.

## Description
One row in this table represents a single work center or production station within the manufacturing facility. This is a raw landed copy of the Odoo `mrp.workcenter` model, serving as the staging entity for downstream manufacturing analytics and capacity planning.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| resource_id | INTEGER | false | Link to resource definition | Foreign key to the shared resource table. |
| company_id | INTEGER | true | Owning company ID | Multi-company support. |
| resource_calendar_id | INTEGER | true | Working time calendar | Defines shifts and availability. |
| sequence | INTEGER | false | Display order | Used for UI sorting. |
| color | INTEGER | true | UI color index | Used for calendar/kanban views. |
| create_uid | INTEGER | true | Creator user ID | Audit field. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field. |
| name | VARCHAR | true | Work center name | Human-readable label. |
| code | VARCHAR | true | Internal code/short name | Often used for machine IDs. |
| working_state | VARCHAR | true | Operational status | e.g., 'normal', 'blocked', 'done'. |
| note | TEXT | true | Description/instructions | Free-text field. |
| active | BOOLEAN | true | Soft-delete flag | False indicates the record is archived. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| time_efficiency | DOUBLE PRECISION | true | Efficiency factor | Multiplier for production time. |
| default_capacity | DOUBLE PRECISION | true | Concurrent capacity | Number of units processed simultaneously. |
| costs_hour | DOUBLE PRECISION | true | Hourly operating cost | Currency units per hour. |
| time_start | DOUBLE PRECISION | true | Setup time | Time required to start production. |
| time_stop | DOUBLE PRECISION | true | Cleanup time | Time required after production. |
| oee_target | DOUBLE PRECISION | true | OEE target percentage | Overall Equipment Effectiveness goal. |
| expense_account_id | INTEGER | true | Accounting expense account | Link to GL account for costs. |
| analytic_distribution | JSONB | true | Analytic accounting mapping | Distribution of costs to analytic accounts. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `resource_id` → `resource_resource.id` (Inferred from Odoo architecture where work centers extend resources).
    - `company_id` → `res_company.id` (Standard Odoo multi-company link).
    - `resource_calendar_id` → `resource_calendar.id` (Standard Odoo calendar link).
    - `expense_account_id` → `account_account.id` (Standard Odoo accounting link).
- **Natural keys (inferred):** 
    - `code` (Often used as a unique business identifier for machines).

## Caveats for downstream consumers

- **Sensitive Data:** `analytic_distribution` may contain sensitive financial allocation logic.
- **Timestamps:** `create_date` and `write_date` are stored in UTC by Odoo.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` unless historical analysis is required.
- **Data Types:** `VARCHAR` lengths are not explicitly defined in the source metadata; assume standard Odoo lengths (typically 255) but validate against source DDL if performing bulk loads.
- **Precision:** `DOUBLE PRECISION` fields are used for rates and time; ensure rounding is applied consistently in downstream financial reporting.