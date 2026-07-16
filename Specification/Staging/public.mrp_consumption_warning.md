# mrp_consumption_warning

## Source system
This table originates from an Odoo ERP system. The naming convention (`mrp_consumption_warning`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of PostgreSQL sequences for primary keys are characteristic of the Odoo framework's data architecture.

## Functional process 
This table supports the Manufacturing Resource Planning (MRP) process, specifically tracking warnings or alerts generated during the consumption of raw materials for production orders. It likely captures instances where material consumption deviates from the expected bill of materials (BOM) or inventory availability, providing a log for production managers to review.

## Description
One row in this table represents a single warning event triggered during the material consumption phase of a manufacturing order. It serves as a raw landed copy of the Odoo `mrp.consumption.warning` model, capturing the audit trail of when the warning was generated and by whom.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Unique surrogate primary key | Managed by `mrp_consumption_warning_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Inferred UTC based on Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure access control is applied if mapping to employee names.
- **Timezone:** Timestamps are assumed to be in UTC, consistent with standard Odoo PostgreSQL configurations.
- **Data Retention:** This table contains audit fields; it is likely an append-only or update-heavy log of system warnings.
- **Completeness:** The table structure provided is minimal; check for additional columns in the source system if business logic (e.g., `mrp_order_id`) appears missing.