# mrp_production_split

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the manufacturing execution process, specifically tracking the splitting of production orders. It manages the relationship between a parent manufacturing order and its split components, allowing for granular tracking of production batches or partial completions.

## Description
One row represents a single split instance or sub-segment of a manufacturing production order. It serves as a raw landed copy of the Odoo `mrp.production.split` model, capturing the audit trail and linkage between production records in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mrp_production_split_id_seq`. |
| production_split_multi_id | INTEGER | true | Foreign key to the parent split group | Links to a grouping entity for multiple splits. |
| production_id | INTEGER | true | Foreign key to the manufacturing order | Links to the main `mrp_production` record. |
| counter | INTEGER | true | Sequence counter for the split | Represents the ordinal position or iteration of the split. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users` table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `production_id` → `mrp_production.id` (Inferred from standard Odoo naming patterns).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit column pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the database's local time; verify if the Odoo instance is configured for UTC (standard practice).
- **Audit Columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs and will not resolve to meaningful names without joining to the `res_users` staging table.
- **Data Integrity:** As a staging table, this may contain transient records or duplicates if the ingestion process performs full refreshes; check for `write_date` recency to identify the latest state.
- **Soft Deletes:** Odoo typically does not use soft-delete flags; records are usually physically deleted from the source.