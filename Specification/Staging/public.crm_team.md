# crm_team

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`, `JSONB` for translatable fields) and the specific column structure are characteristic of Odoo's internal ORM model for sales teams or CRM pipelines.

## Functional process 
This table supports the CRM sales team management process. It defines the organizational structure of sales teams, their operational settings (such as whether they handle leads or opportunities), and their performance targets, facilitating the assignment of incoming sales inquiries to specific groups.

## Description
One row in this table represents a single CRM sales team or department within the organization. It serves as a raw landed copy of the team configuration, capturing metadata about team capabilities, assignment logic, and financial targets.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order | Used for UI sorting. |
| company_id | INTEGER | true | Foreign key to company | Links team to a specific business entity. |
| user_id | INTEGER | true | Team leader/manager ID | Reference to a user record. |
| color | INTEGER | true | UI color index | Used for dashboard visualization. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| name | JSONB | false | Team name | Multi-language support via JSONB. |
| active | BOOLEAN | true | Soft-delete flag | If false, the team is archived. |
| create_date | TIMESTAMP | true | Creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |
| alias_id | INTEGER | false | Email alias ID | Links to an email routing alias. |
| assignment_domain | VARCHAR | true | Lead assignment rules | Domain filter for automated lead routing. |
| lead_properties_definition | JSONB | true | Custom lead fields | Schema definition for dynamic lead attributes. |
| use_leads | BOOLEAN | true | Lead management enabled | Flag for CRM lead pipeline usage. |
| use_opportunities | BOOLEAN | true | Opportunity management enabled | Flag for CRM opportunity pipeline usage. |
| assignment_optout | BOOLEAN | true | Assignment exclusion | Flag to exclude team from auto-assignment. |
| invoiced_target | DOUBLE PRECISION | true | Revenue target | Financial goal for the team. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `company_id` → `res_company.id` (Likely reference to company master data).
    - `user_id` → `res_users.id` (Likely reference to system users).
    - `create_uid` → `res_users.id` (Audit reference).
    - `write_uid` → `res_users.id` (Audit reference).
    - `alias_id` → `mail_alias.id` (Likely reference to email routing configuration).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs and potentially internal business logic in `assignment_domain` and `lead_properties_definition`.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `active = true` unless historical analysis is required.
- **JSONB:** The `name` and `lead_properties_definition` columns require PostgreSQL JSONB operators for extraction.
- **Precision:** `invoiced_target` uses `DOUBLE PRECISION`; be aware of potential floating-point rounding issues when aggregating financial targets.