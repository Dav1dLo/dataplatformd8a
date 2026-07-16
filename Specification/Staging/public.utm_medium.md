# utm_medium

## Source system
This table originates from an Odoo ERP or similar modular business application. The presence of `create_uid`, `write_uid`, and the `nextval` sequence pattern on the `id` column are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the marketing attribution and campaign tracking process. It acts as a lookup or dimension table for "UTM Mediums" (e.g., 'email', 'cpc', 'organic'), which are used to categorize the source of traffic or leads within the marketing pipeline.

## Description
One row represents a single UTM medium definition used to classify marketing channels. It serves as a raw landed copy of the configuration entity, providing the master list of valid mediums used across the platform.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.utm_medium_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| name | VARCHAR | false | The name of the UTM medium | e.g., 'email', 'social', 'cpc'. |
| active | BOOLEAN | true | Soft-delete flag | If false, the medium is no longer in use. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** 
    - `name` (The medium name is typically unique within the application context).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column indicates a soft-delete pattern; ensure queries filter by `active = true` unless historical analysis is required.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Integrity:** The `name` column is the functional business key; ensure downstream joins account for potential case sensitivity depending on the collation settings of the source database.