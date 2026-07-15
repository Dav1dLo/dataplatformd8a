# crm_convert_lead_mass_lead_rel

## Source system
The table likely originates from a CRM system (e.g., Salesforce or a custom-built lead management application). The naming convention `crm_lead2opportunity_partner_mass_id` suggests a bulk processing or mass-conversion utility used to map multiple leads to partner-related opportunities.

## Functional process 
This table supports the lead-to-opportunity conversion pipeline, specifically handling bulk or mass-assignment operations. It acts as a bridge or mapping table to track the relationship between a specific lead and a mass-conversion event or partner-linked opportunity process.

## Description
One row in this table represents a single association between a lead and a mass-conversion record. It serves as a raw landing copy of the join relationship, ensuring that the link between lead identifiers and mass-conversion identifiers is preserved for downstream transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_mass_id | INTEGER | false | Surrogate key for the mass conversion event | Likely a foreign key to a parent mass-processing table. |
| crm_lead_id | INTEGER | false | Identifier for the lead | Natural key or foreign key referencing the primary lead table. |

## Keys

- **Primary key (inferred):** The combination of `crm_lead2opportunity_partner_mass_id` and `crm_lead_id` is likely the composite primary key.
- **Foreign keys (inferred):** 
    - `crm_lead2opportunity_partner_mass_id` → `crm_lead2opportunity_partner_mass.id` (guess: links to the parent mass-conversion event).
    - `crm_lead_id` → `crm_lead.id` (guess: links to the source lead record).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join-mapping table; expect high cardinality and frequent joins to parent entities.
- No audit timestamps (e.g., `created_at`) are present; rely on the parent tables for ingestion lineage.
- The table structure implies a many-to-many relationship between leads and mass-conversion events.
- Assume no soft-delete logic is present; this is a raw landing table representing the state of the source system at the time of extraction.