# mrp_workcenter_productivity_loss

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`mrp_workcenter_productivity_loss`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of `JSONB` for translatable fields (`name`).

## Functional process 
This table supports the Manufacturing (MRP) module, specifically tracking productivity losses at work centers. It categorizes reasons for downtime or efficiency loss, allowing production managers to analyze performance bottlenecks and equipment availability.

## Description
One row represents a specific type of productivity loss definition used to categorize work center downtime or inefficiency. It serves as a raw landing copy of the Odoo configuration entity, capturing both system-defined and user-defined loss reasons.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mrp_workcenter_productivity_loss_id_seq`. |
| sequence | INTEGER | true | Display order index | Used for UI sorting in the Odoo interface. |
| loss_id | INTEGER | true | Reference to loss category | Likely links to a parent loss category or grouping entity. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to `res_users`. |
| loss_type | VARCHAR | true | Classification of loss | e.g., 'productive', 'performance', 'availability'. |
| name | JSONB | false | Loss reason label | Multilingual label; requires extraction for reporting. |
| manual | BOOLEAN | true | Manual entry flag | Indicates if this loss is manually logged by operators. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC timestamp. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC timestamp. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern)
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` column contains JSONB data; ensure your SQL dialect's JSON extraction functions are used (e.g., `name->>'en_US'`) to retrieve human-readable labels.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `active` or `deleted` flag; assume all records are current unless otherwise specified by Odoo business logic.
- **Audit Columns:** `create_date` and `write_date` are standard audit fields; use `write_date` for incremental loading strategies.