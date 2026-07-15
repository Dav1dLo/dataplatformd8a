# crm_recurring_plan

## Source system
This table originates from an Odoo ERP instance, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo ORM, as well as the use of `JSONB` for translatable fields like `name`.

## Functional process 
This table supports the subscription or recurring billing management process. It defines the structural parameters for recurring plans, specifically governing the duration and ordering of billing cycles, likely used to configure how recurring invoices or subscription contracts are generated within the CRM module.

## Description
One row in this table represents a single recurring plan configuration, defining the duration in months and the sequence order for billing cycles. As a staging table, it serves as a raw, direct landing of the Odoo `crm.recurring.plan` model, preserving the system-generated audit fields and JSON-encoded metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_recurring_plan_id_seq`. |
| number_of_months | INTEGER | false | Duration of the plan | Represents the total months for the recurring cycle. |
| sequence | INTEGER | true | Display order | Used for sorting plans in the UI. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system users table. |
| name | JSONB | false | Plan name | Multilingual name stored as a JSON object. |
| active | BOOLEAN | true | Soft-delete flag | If false, the plan is hidden from active selection. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`; downstream consumers will need to extract the relevant language key (e.g., `name->>'en_US'`) to use it in reporting.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- The `active` column acts as a soft-delete; ensure queries filter by `active = TRUE` unless historical/archived data is explicitly required.
- This table contains audit fields (`create_uid`, `write_uid`) which link to internal system users; these may need to be joined against a user dimension for meaningful reporting.