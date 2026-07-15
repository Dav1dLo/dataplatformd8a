# crm_iap_lead_mining_request_res_country_rel

## Source system
This table originates from an Odoo ERP or CRM system. The naming convention `_rel` combined with the prefix `crm_iap_lead_mining_request` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link business objects (in this case, lead mining requests and countries).

## Functional process 
This table supports the lead generation and prospecting process. It acts as a junction table that maps specific lead mining requests to the target countries or regions defined for those requests, allowing the system to filter or scope lead mining activities by geographic location.

## Description
One row in this table represents a single association between a lead mining request and a country. It is a raw landed copy of a many-to-many join table, serving as the bridge to resolve the relationship between mining requests and their associated target countries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request | Links to the primary request entity. |
| res_country_id | INTEGER | false | Foreign key to the country definition | Links to the master country list. |

## Keys

- **Primary key (inferred):** The composite of (`crm_iap_lead_mining_request_id`, `res_country_id`).
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id`: This column identifies the parent request record.
    - `res_country_id` → `res_country.id`: This column identifies the specific country associated with the request.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes other than the two foreign keys.
- There are no timestamps or audit columns present in this table; incremental loading logic should rely on upstream source system change tracking or full-table replacement.
- Ensure that joins to this table are handled as composite keys to avoid fan-out issues.