# crm_lead_pls_update

## Source system
This table originates from an Odoo ERP or CRM system. The naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` is characteristic of Odoo's ORM audit fields, and the sequence-based default for the `id` column is standard for PostgreSQL-backed Odoo installations.

## Functional process 
This table supports the "Predictive Lead Scoring" (PLS) process within the CRM. It tracks the lifecycle and update history of lead scoring parameters, specifically capturing when a scoring model or lead evaluation period was initiated and subsequently modified by system users.

## Description
One row in this table represents a specific update or configuration event for a lead scoring record. It serves as a raw landing copy of the staging data, capturing the audit trail of who created or modified the lead scoring configuration and when those actions occurred.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_lead_pls_update_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user table. |
| pls_start_date | DATE | false | Start date of the scoring period | The business date when the PLS logic became active. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for user audit fields).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for user audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Data Integrity:** The `create_date` and `write_date` fields are nullable; ensure null handling is implemented in downstream transformations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system logic.