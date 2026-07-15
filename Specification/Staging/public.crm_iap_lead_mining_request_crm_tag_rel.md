# crm_iap_lead_mining_request_crm_tag_rel

## Source system
The table likely originates from a custom CRM or Lead Management application, given the specific naming convention `crm_iap_lead_mining_request`. The structure suggests an internal relational database used to track lead generation or mining activities and their associated metadata tags.

## Functional process 
This table supports the lead management and categorization process. It acts as a junction table to implement a many-to-many relationship between lead mining requests and descriptive tags, allowing multiple tags to be assigned to a single request for filtering, reporting, or workflow routing.

## Description
One row in this table represents a single association between a specific lead mining request and a tag. It is a raw landed copy of a junction table used to resolve many-to-many relationships in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request | Links to the primary entity table. |
| crm_tag_id | INTEGER | false | Foreign key to the tag definition | Links to the tag lookup table. |

## Keys

- **Primary key (inferred):** `(crm_iap_lead_mining_request_id, crm_tag_id)`
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id → crm_iap_lead_mining_request.id` (Inferred from naming convention).
    - `crm_tag_id → crm_tag.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a bridge table; ensure joins are handled correctly to avoid fan-out issues when aggregating metrics from the parent `crm_iap_lead_mining_request` table.
- No soft-delete or audit columns are present; assume this table reflects the current state of associations as captured during the last ingestion.
- There are no sensitive PII columns in this specific table, as it only contains integer identifiers.