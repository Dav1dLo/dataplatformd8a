# crm_lead2opportunity_partner_mass

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the lead-to-opportunity conversion process, specifically handling the mass assignment of leads to partners or sales teams. It tracks the configuration and execution of automated lead distribution logic, including deduplication settings and forced assignment overrides.

## Description
One row in this table represents a single execution or configuration record for a mass lead-to-opportunity assignment task. This is a raw landing table in the Staging layer, capturing the state of assignment operations as they are processed by the CRM module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `crm_lead2opportunity_partner_mass_id_seq`. |
| lead_id | INTEGER | true | Foreign key to the lead | Identifies the specific lead being processed. |
| partner_id | INTEGER | true | Foreign key to the partner | The partner assigned to the lead. |
| user_id | INTEGER | true | Foreign key to the user | The sales representative assigned to the lead. |
| team_id | INTEGER | true | Foreign key to the sales team | The sales team responsible for the lead. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the assignment record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | true | Operation name | Descriptive label for the mass assignment task. |
| action | VARCHAR | true | Action type | Defines the specific CRM action taken (e.g., 'exist', 'create'). |
| force_assignment | BOOLEAN | true | Force flag | If true, overrides existing assignments. |
| deduplicate | BOOLEAN | true | Deduplication flag | If true, triggers lead deduplication logic. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `lead_id` → `crm_lead.id` (Guess: links to the primary lead record)
    - `partner_id` → `res_partner.id` (Guess: links to the partner/customer entity)
    - `user_id` → `res_users.id` (Guess: links to the system user)
    - `team_id` → `crm_team.id` (Guess: links to the sales team definition)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs and potentially sensitive lead/partner associations; ensure appropriate access controls.
- **Timestamps:** Assumed to be in UTC as per standard Odoo configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
- **Data Integrity:** As a staging table, it may contain transient state or incomplete records from failed mass-assignment jobs.