# product_combo

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences for the primary key, is characteristic of the Odoo framework's standard audit and tracking fields.

## Functional process 
This table supports product catalog management, specifically the grouping or bundling of products. It likely facilitates the "Product Configuration" or "Bill of Materials" business processes, where multiple items are associated under a single combo identifier for sales or inventory purposes.

## Description
One row in this table represents a single product combo definition or bundle header. It serves as a raw landed copy of the source system's product configuration entity, capturing the identity, sequence, and audit metadata for each combo record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.product_combo_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort combos in UI/reports. |
| company_id | INTEGER | true | Owning company identifier | Links to a multi-tenant company entity. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| name | VARCHAR | false | Combo name | The descriptive label for the product bundle. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be mapped to anonymized user tables if PII constraints apply.
- **Timezone:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo, but verify against the source system configuration.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are currently active unless otherwise specified by the source system's business logic.
- **Data Precision:** The `VARCHAR` type for `name` does not specify a length; downstream systems should be prepared for varying string lengths.