# crm_lead_crm_lead2opportunity_partner_rel

## Source system
This table likely originates from a CRM system (such as Salesforce or a custom-built lead management platform). The naming convention `crm_lead2opportunity_partner_rel` strongly suggests a junction table used to manage many-to-many relationships between lead records and partner-associated opportunity entities.

## Functional process 
This table supports the lead-to-opportunity conversion and partner attribution process. It tracks the association between specific lead records and the partner entities involved in the transition or management of the resulting opportunity, ensuring that lead-partner attribution is maintained during the sales pipeline lifecycle.

## Description
One row in this table represents a single link between a lead record and a partner-related opportunity record. As a staging table, it serves as a raw, normalized representation of the relationship mapping, intended to be joined with lead and partner dimension tables in downstream modeling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_id | INTEGER | false | Surrogate primary key for the relationship record | Unique identifier for this specific link. |
| crm_lead_id | INTEGER |