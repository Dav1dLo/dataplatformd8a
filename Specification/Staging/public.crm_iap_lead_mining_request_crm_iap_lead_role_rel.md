# crm_iap_lead_mining_request_crm_iap_lead_role_rel

## Source system
The table likely originates from an internal CRM or Lead Management system, possibly a custom-built application or a module within a larger ERP suite. The naming convention `crm_iap_lead_mining_request` suggests a specific business workflow related to lead generation or data enrichment, while the `_rel` suffix indicates this is a junction table managing a many-to-many relationship.

## Functional process 
This table supports the lead management and assignment process, specifically linking lead mining requests to specific lead roles. It facilitates the mapping of business requirements (mining requests) to the functional roles responsible for executing or overseeing those requests within the CRM ecosystem.

## Description
One row in this table represents a single association between a lead mining request and a specific lead role. As a staging table, it serves as a raw, landed representation of the many-to-many relationship mapping between these two entities, intended for use in downstream join operations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request entity | Represents the source request identifier. |
| crm_iap_lead_role_id | INTEGER | false | Foreign key to the lead role entity | Represents the role identifier assigned to the request. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of (`crm_iap_lead_mining_request_id`, `crm_iap_lead_role_id`).
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id` (Inferred from naming convention).
    - `crm_iap_lead_role_id` → `crm_iap_lead_role.id` (Inferred from naming convention).
- **Natural keys (inferred):** The combination of (`crm_iap_lead_mining_request_id`, `crm_iap_lead_role_id`) acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; ensure joins are performed on both columns to avoid Cartesian products.
- No audit timestamps (e.g., `created_at`, `updated_at`) are present; assume the data reflects the state at the time of the last ingestion.
- There is no explicit soft-delete flag; assume the presence of a row indicates an active relationship.
- Ensure referential integrity is validated during transformation, as staging tables may contain orphaned records if the source system does not enforce strict constraints.