# mrp_workcenter_productivity

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_workcenter_productivity` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's PostgreSQL schema structure.

## Functional process 
This table supports the manufacturing execution and performance tracking process. It records productivity logs for work centers, capturing time spent on specific work orders and categorizing downtime or efficiency losses via the `loss_id` and `loss_type` fields.

## Description
One row in this table represents a single productivity or downtime event recorded against a specific manufacturing work center. It serves as a raw landing copy of the Odoo productivity log, capturing the duration, timing, and personnel associated with work center activity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| workcenter_id | INTEGER | false | Foreign key to the work center | Links to the resource performing the work. |
| company_id | INTEGER | false | Foreign key to the company | Multi-company isolation key. |
| workorder_id | INTEGER | true | Foreign key to the work order | The specific manufacturing task being performed. |
| user_id | INTEGER | true | Foreign key to the user | The operator associated with this productivity log. |
| loss_id | INTEGER | false | Foreign key to the loss reason | Defines the category of productivity loss. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| loss_type | VARCHAR | true | Category of loss | e.g., 'productive', 'availability', 'performance'. |
| description | TEXT | true | Event description | Free-text notes regarding the productivity event. |
| date_start | TIMESTAMP | false | Start timestamp | Start of the productivity/downtime event. |
| date_end | TIMESTAMP | true | End timestamp | End of the productivity/downtime event. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit timestamp. |
| write_date | TIMESTAMP | true | Last modification timestamp | Audit timestamp. |
| duration | DOUBLE PRECISION | true | Event duration | Usually measured in minutes. |
| account_move_line_id | INTEGER | true | Foreign key to accounting | Links productivity costs to the general ledger. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id` (Inferred from Odoo naming conventions)
    - `workorder_id` → `mrp_workorder.id` (Inferred from Odoo naming conventions)
    - `user_id` → `res_users.id` (Standard Odoo user reference)
    - `loss_id` → `mrp_workcenter_productivity_loss.id` (Inferred from Odoo naming conventions)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `user_id` and potentially descriptive text that may identify personnel; ensure appropriate masking if exposing to non-HR/Operations roles.
- **Timezone:** Timestamps are typically stored in UTC in Odoo; verify against the specific Odoo instance configuration.
- **Soft Deletes:** Odoo does not typically use soft-delete flags; records are usually physically deleted from the source.
- **Data Integrity:** `workorder_id` is nullable, implying some productivity logs (e.g., general maintenance or idle time) may not be tied to a specific production order.