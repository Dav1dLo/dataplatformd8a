# crm_lead_crm_lead2opportunity_partner_rel

## Source system
This table likely originates from a CRM system (such as Odoo or a similar modular ERP/CRM platform) that manages lead-to-opportunity conversion workflows. The naming convention `crm_lead2opportunity_partner_rel` is characteristic of a join table used to manage many-to-many relationships between lead conversion records and partner entities.

## Functional process 
This table supports the lead-to-opportunity conversion process, specifically tracking the association between lead conversion events and partner entities. It acts as a bridge to ensure that when a lead is converted into an opportunity, the relevant partner relationship is persisted and linked correctly.

## Description
One row in this table represents a single association between a lead conversion record and a partner entity. It serves as a raw landing copy of a join table, maintaining the relational integrity between lead conversion processes and partner accounts within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_id | INTEGER | false | Surrogate primary key for the relationship record | Unique identifier for this specific link. |
| crm_lead_id | INTEGER | false | Foreign key referencing the lead conversion record | Links to the primary lead conversion entity. |

## Keys

- **Primary key (inferred):** `crm_lead2opportunity_partner_id`
- **Foreign keys (inferred):** 
    - `crm_lead_id` → `crm_lead.id` (Inferred based on the `crm_lead_` prefix).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; ensure joins to parent tables handle potential duplicates if the relationship logic in the source system allows multiple entries for the same lead.
- No PII is present in this table, as it only contains relational identifiers.
- This table represents a raw snapshot; check for orphaned records if the source system does not enforce strict referential integrity.