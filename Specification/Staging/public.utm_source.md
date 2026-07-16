# utm_source

## Source system
This table originates from an Odoo ERP or similar modular business application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns is a standard pattern for Odoo's ORM-managed tables, which track record creation and modification metadata.

## Functional process 
This table supports the marketing attribution and tracking process. It acts as a lookup or dimension table for UTM source parameters (e.g., 'google', 'newsletter', 'facebook'), which are used to categorize the origin of traffic or leads within the marketing pipeline.

## Description
One row represents a unique UTM source identifier used to track the origin of marketing campaigns or inbound traffic. As a staging table, it serves as a raw landed copy of the source system's configuration data, intended for use in downstream marketing analytics and attribution modeling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.utm_source_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user directory. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user directory. |
| name | VARCHAR | false | The UTM source name | The human-readable identifier (e.g., 'google'). |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** 
    - `name` (the unique business identifier for the source).

## Caveats for downstream consumers

- **Sensitive Data:** None identified; this table contains configuration/lookup data.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are current unless otherwise specified by the source system's business logic.
- **Data Quality:** The `name` column is the primary business value; ensure downstream joins handle potential case-sensitivity differences if the source system allows mixed-case entries.