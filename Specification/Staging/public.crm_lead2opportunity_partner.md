# crm_lead2opportunity_partner

## Source system
This table likely originates from an Odoo ERP or CRM system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the lead-to-opportunity conversion process, specifically tracking the assignment of leads to partners, internal users, or teams. It acts as a junction or configuration table that governs how leads are routed or attributed during the sales pipeline progression.

## Description
One row in this table represents a specific assignment or configuration record linking a lead to a partner, user, or team. It serves as a raw landed copy of the assignment metadata, capturing the state of lead routing at the time of creation or modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_lead2opportunity_partner_id_seq`. |
| lead_id | INTEGER | false | Foreign key to the lead | Identifies the lead being processed. |
| partner_id | INTEGER | true | Foreign key to the partner | The partner assigned to the lead. |
| user_id | INTEGER | true | Foreign key to the user | The internal user assigned to the lead. |
| team_id | INTEGER | true | Foreign key to the sales team | The sales team responsible for the lead. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | true | Assignment name or description | Descriptive label for the assignment action. |
| action | VARCHAR | true | Assignment action type | Defines the specific routing logic applied. |
| force_assignment | BOOLEAN | true | Manual override flag | Indicates if the assignment was forced manually. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Inferred from naming convention).
    - `partner_id` → `res_partner.id` (Inferred from standard Odoo naming).
    - `user_id` → `res_users.id` (Inferred from standard Odoo naming).
    - `team_id` → `crm_team.id` (Inferred from standard Odoo naming).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume standard CRUD behavior where rows are removed if deleted in the source.
- **Data Quality:** Columns like `partner_id`, `user_id`, and `team_id` are nullable, suggesting that not all assignment records require all three dimensions to be populated simultaneously.
- **PII:** While this table contains IDs, ensure that any joined tables (like `res_partner`) are checked for PII (names, emails) before exposing to non-authorized users.