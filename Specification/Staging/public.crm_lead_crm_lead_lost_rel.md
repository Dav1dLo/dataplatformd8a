# crm_lead_crm_lead_lost_rel

## Source system
This table likely originates from an Odoo or similar modular ERP/CRM system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables (join tables) between two entities, in this case, linking leads to their lost-reason or lost-status records.

## Functional process 
This table supports the sales pipeline management process, specifically tracking the relationship between lead records and the reasons or metadata associated with a "lost" status. It acts as a bridge to associate specific lost-reason entities with individual lead records.

## Description
One row in this table represents a single association between a lead and a lost-reason record. It is a raw landing copy of a join table, intended to maintain referential integrity between lead entities and their corresponding lost-status metadata in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead_lost_id | INTEGER | false | Surrogate key for the lost-reason entity. | Likely a foreign key to a `crm_lead_lost` table. |
| crm_lead_id | INTEGER | false | Surrogate key for the lead entity. | Likely a foreign key to a `crm_lead` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`crm_lead_lost_id`, `crm_lead_id`).
- **Foreign keys (inferred):** 
    - `crm_lead_id` → `crm_lead.id`: This column links the relationship to the primary lead record.
    - `crm_lead_lost_id` → `crm_lead_lost.id`: This column links the relationship to the specific lost-reason record.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a join table; expect no descriptive attributes other than the two foreign keys.
- There are no timestamps or audit columns provided in this table; tracking when the relationship was created is not possible from this source alone.
- Ensure joins to parent tables handle potential orphans if the source system does not enforce strict referential integrity at the database level.