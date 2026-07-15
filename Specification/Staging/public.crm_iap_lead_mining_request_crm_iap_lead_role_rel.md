# crm_iap_lead_mining_request_crm_iap_lead_role_rel

## Source system
The table likely originates from a custom CRM or Lead Management application, given the specific naming convention `crm_iap_lead_mining_request` and `crm_iap_lead_role`. The suffix `_rel` strongly suggests this is a junction table exported from a relational database management system (RDBMS) that manages many-to-many relationships between lead mining requests and lead roles.

## Functional process 
This table supports the lead qualification and assignment process. It maps specific lead mining requests (which represent a search or data extraction task for potential leads) to the specific roles (e.g., "Sales Development Rep", "Account Executive") associated with those requests.

## Description
Each row in this table represents a single association between a lead mining request and a lead role. It acts as a bridge table in the staging layer, preserving the many-to-many relationship structure found in the source system to ensure referential integrity during downstream transformations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request entity. | Links to the primary request record. |
| crm_iap_lead_role_id | INTEGER | false | Foreign key to the lead role definition. | Identifies the specific role assigned to the request. |

## Keys

- **Primary key (inferred):** The combination of `crm_iap_lead_mining_request_id` and `crm_iap_lead_role_id` is the composite primary key.
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id` (guessed based on naming convention).
    - `crm_iap_lead_role_id` → `crm_iap_lead_role.id` (guessed based on naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this against two other tables to retrieve meaningful business attributes.
- There are no timestamps or audit columns present; it is impossible to determine the creation or modification time of these relationships from this table alone.
- The table contains no PII, but it does define the structural relationship between sensitive lead mining activities and internal roles.