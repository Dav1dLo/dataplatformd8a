# crm_lead2opportunity_partner_mass_res_users_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `crm_lead2opportunity_partner_mass_res_users_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link a primary business object (in this case, a mass lead-to-opportunity conversion wizard or process) to system users.

## Functional process 
This table supports the lead-to-opportunity conversion process, specifically tracking the association between mass conversion operations and the system users involved in or assigned to those operations. It acts as a join table to manage the many-to-many relationship between the conversion wizard instances and user accounts.

## Description
One row in this table represents a single association between a specific lead-to-opportunity mass conversion process and a system user. It serves as a raw landing copy of the relationship table from the source Odoo database, maintaining the link between operational processes and user entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_mass_id | INTEGER | false | Foreign key to the mass conversion process | References the primary ID of the lead-to-opportunity wizard instance. |
| res_users_id | INTEGER | false | Foreign key to the system user | References the ID of the user associated with the conversion process. |

## Keys

- **Primary key (inferred):** The combination of `crm_lead2opportunity_partner_mass_id` and `res_users_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `crm_lead2opportunity_partner_mass_id` → `crm_lead2opportunity_partner_mass.id` (Inferred from Odoo naming convention for join tables).
    - `res_users_id` → `res_users.id` (Standard Odoo reference to the user table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; temporal analysis of these relationships is not possible using this table alone.
- As a staging table, it reflects the raw state of the Odoo database; ensure that downstream joins handle potential orphan records if referential integrity is not strictly enforced in the source.