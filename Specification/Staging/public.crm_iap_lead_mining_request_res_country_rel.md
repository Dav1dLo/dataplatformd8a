# crm_iap_lead_mining_request_res_country_rel

## Source system
This table likely originates from an Odoo ERP or CRM system. The naming convention `_res_country_rel` is a standard pattern used by Odoo to represent many-to-many relationship tables (often called "relation tables") between a primary business object (in this case, `crm_iap_lead_mining_request`) and a reference entity (`res_country`).

## Functional process 
This table supports the lead generation and enrichment process, specifically tracking the geographic scope or target countries associated with a lead mining request. It allows the system to associate multiple countries with a single IAP (In-App Purchase) lead mining request, facilitating targeted lead acquisition.

## Description
Each row represents a single association between a specific lead mining request and a target country. It acts as a join table to resolve a many-to-many relationship, ensuring that a single request can be scoped to one or more countries. This is a raw landing of the relationship table from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request | Links to the parent request entity. |
| res_country_id | INTEGER | false | Foreign key to the country definition | Links to the master country list. |

## Keys

- **Primary key (inferred):** The composite of (`crm_iap_lead_mining_request_id`, `res_country_id`).
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id`: This column references the primary request record.
    - `res_country_id` → `res_country.id`: This column references the standard Odoo country definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a link table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic should rely on the upstream source system's change tracking if available.
- Ensure inner joins are used when filtering by country, as this table only contains the mapping and not the country names themselves.