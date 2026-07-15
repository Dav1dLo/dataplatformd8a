# crm_lead2opportunity_partner

## Source system
This table likely originates from an Odoo ERP or CRM system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences are characteristic of Odoo's PostgreSQL-based ORM layer.

## Functional process 
This table supports the lead-to-opportunity conversion process, specifically tracking the assignment of leads to partners (resellers or distributors) and internal sales teams. It manages the routing logic that determines which partner or internal user is responsible for a lead as it progresses through the sales pipeline.

## Description
One row in this table represents a single assignment or routing configuration linking a lead to a specific partner, user, or team. It serves as a raw landing copy of the assignment metadata, capturing the state of lead distribution at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_lead2opportunity_partner_id_seq`. |
| lead_id | INTEGER | false | Foreign key to the lead | Identifies the lead being processed. |
| partner_id | INTEGER | true | Foreign key to the partner | The partner assigned to the lead. |
| user_id | INTEGER | true | Foreign key to the user | The internal sales representative assigned. |
| team_id | INTEGER | true | Foreign key to the sales team | The sales team responsible for the lead. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| name | VARCHAR | true | Assignment name or description | Often contains a descriptive label for the assignment action. |
| action | VARCHAR | true | Assignment action type | Defines the nature of the lead-to-opportunity conversion action. |
| force_assignment | BOOLEAN | true | Manual override flag | Indicates if the assignment was forced manually. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Guess: standard Odoo naming for lead references).
    - `partner_id` → `res_partner.id` (Guess: standard Odoo naming for partner/customer references).
    - `user_id` → `res_users.id` (Guess: standard Odoo naming for system users).
    - `team_id` → `crm_team.id` (Guess: standard Odoo naming for sales teams).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `user_id` and potentially identifiable assignment names; ensure access is restricted to authorized sales operations personnel.
- **Timestamps:** Assumed to be in UTC; verify against source system configuration if precision to the millisecond is required.
- **Soft Deletes:** This table does not explicitly show a `deleted_at` or `active` flag, but Odoo tables often use an `active` boolean column (not present here) for soft deletes. Assume all rows are currently active unless otherwise specified by business logic.
- **Data Integrity:** As a staging table, this may contain duplicates or incomplete records if the source system allows partial updates to assignment configurations.