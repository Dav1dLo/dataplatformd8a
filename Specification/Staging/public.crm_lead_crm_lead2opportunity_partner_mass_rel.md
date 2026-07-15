# crm_lead_crm_lead2opportunity_partner_mass_rel

## Source system
This table likely originates from an Odoo or similar ERP/CRM system, given the naming convention `crm_lead2opportunity_partner_mass_rel`, which is characteristic of Odoo's many-to-many relationship tables (often suffixed with `_rel`).

## Functional process 
This table supports the lead-to-opportunity conversion process, specifically managing the many-to-many relationship between lead records and partner/mass-mailing associations. It facilitates the tracking of which partners or mass-mailing campaigns are linked to specific lead-to-opportunity conversion events.

## Description
One row in this table represents a single association link between a lead-to-opportunity conversion record and a partner or mass-mailing entity. As a staging table, it provides a raw, landed copy of the relationship mapping used to maintain referential integrity between these entities in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_mass_id | INTEGER | false | Surrogate key for the relationship record | Likely a foreign key to the parent conversion entity. |
| crm_lead_id | INTEGER | false | Identifier for the lead record | Foreign key to the `crm_lead` table. |

## Keys

- **Primary key (inferred):** The combination of `crm_lead2opportunity_partner_mass_id` and `crm_lead_id` likely forms the composite primary key.
- **Foreign keys (inferred):** 
    - `crm_lead_id` → `crm_lead.id`: This column references the primary identifier of the lead entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join-table (link table); expect high cardinality and frequent updates if the source system allows dynamic re-linking of leads.
- There are no timestamps or soft-delete flags present; assume this table represents the current state of relationships as captured during the last ingestion.
- Ensure joins to this table are handled carefully to avoid fan-out effects if the relationship is truly many-to-many.