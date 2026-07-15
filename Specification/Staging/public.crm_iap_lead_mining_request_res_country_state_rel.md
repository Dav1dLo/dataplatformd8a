# crm_iap_lead_mining_request_res_country_state_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the naming convention `res_country_state` (a standard Odoo model for geographical states/provinces) and the `_rel` suffix, which is characteristic of Odoo's automated many-to-many relationship tables.

## Functional process 
This table supports the Lead-to-Cash pipeline, specifically the "Lead Mining" feature within the CRM module. It manages the many-to-many relationship between lead generation requests and the specific geographical states or provinces targeted for those requests.

## Description
Each row represents a single association between a lead mining request and a specific geographical state. This is a raw landed junction table used to resolve the many-to-many relationship between CRM lead mining requests and country states.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request | Links to the primary request entity. |
| res_country_state_id | INTEGER | false | Foreign key to the country state | Identifies the specific state/province included in the request. |

## Keys

- **Primary key (inferred):** The combination of `crm_iap_lead_mining_request_id` and `res_country_state_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id`: This column references the parent lead mining request record.
    - `res_country_state_id` → `res_country_state.id`: This column references the master list of geographical states.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume this table reflects the current state of associations as captured during the last ingestion.
- Ensure that joins to the target tables handle potential orphans if the source system's referential integrity is not strictly enforced during the extraction process.