# crm_convert_lead_mass_lead_rel

## Source system
The table likely originates from a CRM system (such as Salesforce or a custom-built lead management platform) that supports bulk lead conversion processes. The naming convention `crm_convert_lead_mass_lead_rel` suggests a junction table used to track the relationship between a mass-conversion event and the individual leads included in that batch.

## Functional process 
This table supports the "Lead-to-Opportunity" conversion pipeline, specifically handling bulk or mass-conversion operations. It acts as a link between a specific mass-conversion job (identified by `crm_lead2opportunity_partner_mass_id`) and the individual lead records (`crm_lead_id`) processed during that event.

## Description
One row represents a single association between a specific mass lead conversion event and an individual lead record. As a staging table, it provides a raw, landed copy of the relationship mapping used to track which leads were included in which bulk conversion batch.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_mass_id | INTEGER | false | Surrogate key for the mass conversion event | Links to the parent batch/event record. |
| crm_lead_id | INTEGER | false | Surrogate key for the individual lead | Links to the lead entity record. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of (`crm_lead2opportunity_partner_mass_id`, `crm_lead_id`).
- **Foreign keys (inferred):** 
    - `crm_lead2opportunity_partner_mass_id` → `crm_lead2opportunity_partner_mass.id` (guess: links to the header record for the mass conversion).
    - `crm_lead_id` → `crm_lead.id` (guess: links to the individual lead record).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; expect many-to-many relationships between conversion events and leads if the source system allows re-processing.
- No audit timestamps (e.g., `created_at`) are present in this staging table; rely on the ingestion metadata or the parent tables for lineage.
- As a staging table, this data may be truncated and reloaded; do not assume historical persistence of these relationships unless verified by the ingestion pipeline.