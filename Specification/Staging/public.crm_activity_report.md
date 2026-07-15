# crm_activity_report

## Source system
The table likely originates from an Odoo ERP or a similar modular CRM system. The naming convention of columns such as `mail_activity_type_id`, `partner_id`, and `stage_id` is highly characteristic of Odoo's relational data structure, where activities are tracked against leads or opportunities.

## Functional process 
This table supports the Lead-to-Cash or Sales Pipeline management process. It tracks the lifecycle of sales activities, including lead creation, conversion milestones, and activity logging (e.g., emails, meetings), allowing for the analysis of sales team performance and lead velocity.

## Description
This table represents a raw landing of CRM activity logs, where each row corresponds to a specific interaction or status change associated with a lead or sales opportunity. It serves as a staging entity, capturing the state of activities at the grain of one row per activity event, intended for downstream transformation into analytical fact tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely the internal Odoo ID. |
| lead_create_date | TIMESTAMP | true | Timestamp of lead creation | Used to calculate lead age. |
| date_conversion | TIMESTAMP | true | Timestamp of lead-to-opportunity conversion | Null if not converted. |
| date_deadline | DATE | true | Target date for activity completion | Date only, no time component. |
| date_closed | TIMESTAMP | true | Timestamp when the activity or lead was closed | Indicates completion or loss. |
| subtype_id | INTEGER | true | Foreign key to activity subtype | Categorizes the nature of the activity. |
| mail_activity_type_id | INTEGER | true | Foreign key to activity type definition | Defines if the activity is a call, email, etc. |
| author_id | INTEGER | true | Foreign key to the user who created the record | The creator of the activity log. |
| date | TIMESTAMP | true | Timestamp of the activity event | Primary event timestamp. |
| body | TEXT | true | Content or notes of the activity | Contains unstructured interaction details. |
| lead_id | INTEGER | true | Foreign key to the associated lead | Links activity to a specific lead. |
| user_id | INTEGER | true | Foreign key to the assigned sales representative | The owner of the activity. |
| team_id | INTEGER | true | Foreign key to the sales team | Used for departmental reporting. |
| country_id | INTEGER | true | Foreign key to country reference | Geographic context of the lead. |
| company_id | INTEGER | true | Foreign key to the company/branch | Multi-company support identifier. |
| stage_id | INTEGER | true | Foreign key to the pipeline stage | Current status in the sales funnel. |
| partner_id | INTEGER | true | Foreign key to the customer/partner | The entity associated with the lead. |
| lead_type | VARCHAR | true | Classification of the lead | e.g., 'lead' vs 'opportunity'. |
| active | BOOLEAN | true | Soft-delete flag | True if the record is currently active. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `lead_id` → `crm_lead.id` (Inferred from standard Odoo schema patterns)
    - `user_id` → `res_users.id` (Inferred from standard Odoo schema patterns)
    - `team_id` → `crm_team.id` (Inferred from standard Odoo schema patterns)
    - `partner_id` → `res_partner.id` (Inferred from standard Odoo schema patterns)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` column may contain PII or sensitive customer communication; ensure masking if exposing to non-authorized users.
- **Timezones:** Timestamps are assumed to be in UTC, but verify against the source system configuration as Odoo often stores in UTC but displays in local time.
- **Soft Deletes:** The `active` column should be used to filter out inactive records in all downstream queries.
- **Data Quality:** As a staging table, expect potential nulls in foreign key columns if the source system allows orphaned records or incomplete activity logging.