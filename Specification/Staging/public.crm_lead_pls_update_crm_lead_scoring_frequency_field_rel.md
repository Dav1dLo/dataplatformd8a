# crm_lead_pls_update_crm_lead_scoring_frequency_field_rel

## Source system
This table likely originates from a custom CRM or a lead management application. The naming convention `_rel` and the association of two distinct ID fields suggest this is a junction table (associative entity) managing a many-to-many relationship between lead update events and scoring frequency configurations.

## Functional process 
This table supports the lead scoring lifecycle, specifically mapping lead update events to their corresponding scoring frequency parameters. It enables the system to track which scoring rules or frequency settings were applied to specific lead update processes.

## Description
One row represents a single association between a lead update event and a scoring frequency field configuration. As a staging table, it serves as a raw landing of the relationship mapping, intended to be joined with parent entities to reconstruct the scoring logic applied to leads.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead_pls_update_id | INTEGER | false | Foreign key to the lead update event | Represents the source event ID. |
| crm_lead_scoring_frequency_field_id | INTEGER | false | Foreign key to the scoring frequency configuration | Represents the scoring rule ID. |

## Keys

- **Primary key (inferred):** Not confidently inferable. The table lacks a surrogate ID; the PK is likely a composite of both columns.
- **Foreign keys (inferred):** 
    - `crm_lead_pls_update_id` → `crm_lead_pls_update.id` (Inferred from naming convention).
    - `crm_lead_scoring_frequency_field_id` → `crm_lead_scoring_frequency_field.id` (Inferred from naming convention).
- **Natural keys (inferred):** The combination of `(crm_lead_pls_update_id, crm_lead_scoring_frequency_field_id)` is the natural key representing the unique relationship.

## Caveats for downstream consumers

- This is a junction table; ensure joins are handled carefully to avoid fan-out if a lead update is associated with multiple scoring frequencies.
- No audit timestamps (e.g., `created_at`) are present; rely on the parent tables for temporal context.
- The table contains no PII, but represents internal system logic mapping.