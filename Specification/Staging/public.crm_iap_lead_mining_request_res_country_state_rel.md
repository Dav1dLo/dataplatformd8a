# crm_iap_lead_mining_request_res_country_state_rel

## Source system
The table likely originates from an Odoo ERP or CRM system, indicated by the naming convention `res_country_state` (a standard Odoo model for geographical states) and the `crm_iap_lead_mining_request` prefix, which corresponds to Odoo's "Lead Mining" (In-App Purchase) feature.

## Functional process 
This table supports the lead generation and qualification process. It acts as a junction table mapping specific lead mining requests to the geographical states (e.g., US states or provinces) targeted or associated with those requests, allowing the system to filter or attribute lead generation activities by region.

## Description
This table represents a many-to-many relationship between lead mining requests and geographical states. Each row links a single lead mining request to a specific state, defining the regional scope or criteria for that request. It serves as a raw landing copy of the association table from the source CRM.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request | Links to the parent request record. |
| res_country_state_id | INTEGER | false | Foreign key to the country state definition | Identifies the specific state/province involved. |

## Keys

- **Primary key (inferred):** The combination of `crm_iap_lead_mining_request_id` and `res_country_state_id` forms a composite primary key.
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id`: This column references the primary request entity.
    - `res_country_state_id` → `res_country_state.id`: This column references the standard geographical state lookup table.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; queries should expect to perform `JOIN` operations against the parent `crm_iap_lead_mining_request` and `res_country_state` tables to retrieve meaningful business attributes.
- There are no timestamps or soft-delete flags present; this table represents the current state of the relationship as captured during the last ingestion.
- Ensure that joins handle the composite nature of the relationship to avoid fan-out issues.