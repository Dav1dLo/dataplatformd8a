# crm_lead2opportunity_partner_mass_res_users_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `crm_lead2opportunity_partner_mass_res_users_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link a primary business object (the lead-to-opportunity mass conversion wizard) to system users.

## Functional process 
This table supports the "Lead-to-opportunity conversion" business process. It tracks the association between mass conversion operations and the specific system users involved in or assigned to those operations, facilitating multi-user access or audit tracking during bulk lead processing.

## Description
One row in this table represents a single link between a specific lead-to-opportunity mass conversion record and a system user. It serves as a raw, junction-table copy from the source system, maintaining the many-to-many relationship required for the application's user-permission or assignment logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_mass_id | INTEGER | false | Foreign key to the mass conversion operation | Links to the parent wizard/process record. |
| res_users_id | INTEGER | false | Foreign key to the system user | Identifies the user associated with the conversion process. |

## Keys

- **Primary key (inferred):** The combination of `crm_lead2opportunity_partner_mass_id` and `res_users_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `crm_lead2opportunity_partner_mass_id` → `crm_lead2opportunity_partner_mass.id` (Inferred from Odoo naming conventions for junction tables).
    - `res_users_id` → `res_users.id` (Standard Odoo reference to the system users table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There is no surrogate primary key; queries should join on the composite key.
- As a staging table, it reflects the raw state of the source database; ensure inner joins are used if you only require records with valid parent/user associations.