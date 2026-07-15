# crm_iap_lead_mining_request_crm_tag_rel

## Source system
The table likely originates from a custom CRM or Lead Management application, given the specific naming convention `crm_iap_lead_mining_request`. The structure suggests an internal tool used for tracking lead generation or enrichment requests and their associated metadata tags.

## Functional process 
This table supports the lead management and categorization pipeline. It functions as a junction table that maps specific lead mining requests to various CRM tags, allowing for multi-tag classification of individual mining tasks.

## Description
One row in this table represents a single association between a lead mining request and a CRM tag. It serves as a raw landing copy of a many-to-many relationship table, enabling the linking of mining requests to organizational or functional categories.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request entity | Represents the source mining request ID. |
| crm_tag_id | INTEGER | false | Foreign key to the CRM tag entity | Represents the identifier for the associated tag. |

## Keys

- **Primary key (inferred):** The combination of `crm_iap_lead_mining_request_id` and `crm_tag_id` forms a composite primary key.
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id` (guess: links to the parent request table).
    - `crm_tag_id` → `crm_tag.id` (guess: links to the master tag definition table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a bridge table; ensure joins are handled correctly to avoid fan-out issues when aggregating data from the parent tables.
- No timestamps or audit columns are present; it is impossible to determine the temporal order of associations from this table alone.
- The table contains no sensitive PII, but it does expose the internal relationship structure between lead requests and tags.