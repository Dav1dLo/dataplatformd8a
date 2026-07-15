# crm_lead_crm_lead2opportunity_partner_mass_rel

## Source system
This table likely originates from an Odoo ERP or CRM system. The naming convention `crm_lead2opportunity_partner_mass_rel` is characteristic of Odoo's internal relational mapping tables, which are automatically generated to manage many-to-many relationships between lead-to-opportunity conversion processes and partner entities.

## Functional process 
This table supports the Lead-to-Cash pipeline, specifically managing the association between lead conversion events and partner organizations. It acts as a join table to facilitate the mass assignment or linking of partners to lead-to-opportunity conversion records.

## Description
One row in this table represents a single association between a specific lead-to-opportunity conversion record and a partner entity. As a staging table, it provides a raw, landed copy of the relational link data, serving as the foundation for building downstream fact tables that track lead conversion attribution.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_mass_id | INTEGER | false | Surrogate key for the relationship record | Likely a foreign key to the parent mass-conversion process table. |
| crm_lead_id | INTEGER | false | Foreign key to the lead record | Identifies the specific lead involved in the conversion process. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of both columns.
- **Foreign keys (inferred):** 
    - `crm_lead_id` → `crm_lead.id`: This column references the primary lead record being processed.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; expect high cardinality and frequent updates if the source system performs bulk operations.
- There is no audit timestamp (e.g., `created_at` or `updated_at`) provided in this schema; incremental loading logic will need to rely on other mechanisms or full-table refreshes.
- The table contains no PII, but it does contain relational metadata that maps leads to partners, which should be handled according to internal data privacy policies.