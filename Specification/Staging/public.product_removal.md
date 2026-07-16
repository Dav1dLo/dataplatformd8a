# product_removal

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized or structured fields like `name` and `method`.

## Functional process 
This table supports the inventory management and warehouse operations process, specifically tracking the removal strategies or policies applied to products within a warehouse location. It defines how products are selected for removal (e.g., FIFO, LIFO, or Closest Location) to fulfill outgoing stock moves.

## Description
One row represents a specific product removal strategy configuration defined within the system. This is a raw landed copy of the configuration entity, serving as the staging point for downstream inventory dimension tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.product_removal_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| name | JSONB | false | Display name of the removal strategy | Likely contains multi-language strings. |
| method | JSONB | false | Technical definition of the removal method | Stores structured configuration logic. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Format:** The `name` and `method` columns are `JSONB`; downstream consumers must use PostgreSQL JSON operators (e.g., `->>`) to extract specific values for reporting.
- **Soft Deletes:** This table does not appear to have a soft-delete flag; assume all records are active unless otherwise specified by business logic.