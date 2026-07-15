# crm_lead2opportunity_partner_mass

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the specific sequence pattern `nextval('"public".crm_lead2opportunity_partner_mass_id_seq'::regclass)` are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the lead-to-opportunity conversion process, specifically handling the mass assignment of leads to partners or sales teams. It tracks the configuration and execution of bulk lead processing, including deduplication logic and assignment overrides.

## Description
One row represents a single batch operation or configuration record for assigning leads to partners or internal users. It acts as a raw landing copy of the mass-assignment process state within the Staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by Odoo sequence. |
| lead_id | INTEGER | true | Foreign key to the lead | References the source lead record. |
| partner_id | INTEGER | true | Foreign key to the partner | The target partner for assignment. |
| user_id | INTEGER | true | Foreign key to the user | The sales representative assigned. |
| team_id | INTEGER | true | Foreign key to the sales team | The target sales team. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the mass action. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| name | VARCHAR | true | Operation name or label | Descriptive title for the mass assignment task. |
| action | VARCHAR | true | Action type | Defines the specific logic applied (e.g., 'exist', 'create'). |
| force_assignment | BOOLEAN | true | Force assignment flag | If true, overrides existing assignments. |
| deduplicate | BOOLEAN | true | Deduplication flag | If true, triggers lead deduplication logic. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Guess: standard Odoo lead reference)
    - `partner_id` → `res_partner.id` (Guess: standard Odoo partner reference)
    - `user_id` → `res_users.id` (Guess: standard Odoo user reference)
    - `team_id` → `crm_team.id` (Guess: standard Odoo sales team reference)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs and potentially sensitive lead/partner associations; ensure appropriate access controls.
- **Timestamps:** Assumed to be in UTC, consistent with Odoo standard behavior.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely hard-deleted or retained indefinitely.
- **Data Integrity:** As a staging table, it may contain transient state data from the mass-assignment wizard; verify if records are intended for long-term analytical use.