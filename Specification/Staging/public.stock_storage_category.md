# stock_storage_category

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the presence of sequence-based primary keys are characteristic of Odoo's PostgreSQL backend schema.

## Functional process 
This table supports the warehouse management process by defining categories for storage locations. It allows the system to classify storage areas based on constraints such as weight limits and product acceptance policies, which are used during inventory put-away and picking logic.

## Description
One row in this table represents a single storage category definition used to classify warehouse locations. This is a raw landed copy of the Odoo `stock.storage.category` model, serving as the staging entity for downstream inventory and warehouse dimension modeling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `stock_storage_category_id_seq`. |
| company_id | INTEGER | true | Foreign key to the owning company | Links to the multi-company configuration. |
| create_uid | INTEGER | true | User ID who created the record | References the `res.users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res.users` table. |
| name | VARCHAR | false | Name of the storage category | Human-readable label for the category. |
| allow_new_product | VARCHAR | false | Policy for new product placement | Likely stores a code or status string (e.g., 'all', 'empty'). |
| max_weight | NUMERIC | true | Maximum weight capacity | Unit of measure is typically defined by the company settings. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Inferred from standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Standard Odoo audit trail pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit trail pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Sensitivity:** No PII is present; however, `create_uid` and `write_uid` link to internal user records.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; standard Odoo behavior is hard deletion unless an `active` boolean column is present (which is absent here).
- **Precision:** The `VARCHAR` and `NUMERIC` types lack explicit length/precision constraints in the metadata; downstream consumers should handle potential overflow or truncation if these are mapped to fixed-width fields.