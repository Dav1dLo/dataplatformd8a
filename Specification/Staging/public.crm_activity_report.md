# crm_activity_report

## Source system
The table likely originates from an Odoo or similar modular ERP/CRM system. The presence of specific naming conventions such as `mail_activity_type_id`, `partner_id`, and `stage_id` alongside a `crm_activity_report` naming pattern is highly characteristic of Odoo's internal reporting structures for tracking lead progression and communication history.

## Functional process 
This table supports the lead-to-opportunity conversion and sales pipeline monitoring process. It aggregates activity metrics, lead lifecycle timestamps (creation, conversion, closure), and organizational metadata (team, user, company) to provide visibility into sales performance and lead engagement.

## Description
One row in this table represents a snapshot or a record of a specific CRM activity associated with a lead at a point in time. It serves as a raw landed staging entity, capturing the state of lead progression, communication logs, and associated organizational assignments for downstream analytical reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely an internal database ID. |
| lead_create_date | TIMESTAMP | true | Lead creation timestamp | UTC assumed. |
| date_conversion | TIMESTAMP | true | Lead to opportunity conversion timestamp | Null if not yet converted. |
| date_deadline | DATE | true | Expected closing date | Date only, no time component. |
| date_closed | TIMESTAMP | true | Lead closure timestamp | Null if lead is still active. |
| subtype_id | INTEGER | true | Activity subtype identifier | Links to activity subtype definitions. |
| mail_activity_type_id | INTEGER | true | Mail activity type identifier | Categorizes the type of communication. |
| author_id | INTEGER | true | Author identifier | The user or system that created the activity. |
| date | TIMESTAMP | true | Activity occurrence timestamp | The specific time the activity took place. |
| body | TEXT | true | Activity content/notes | Contains the text body of the CRM activity. |
| lead_id | INTEGER | true | Lead identifier | Foreign key to the lead entity. |
| user_id | INTEGER | true | Assigned user identifier | The sales representative assigned to the activity. |
| team_id | INTEGER | true | Sales team identifier | The team responsible for the lead. |
| country_id | INTEGER | true | Country identifier | Geographic location of the lead/partner. |
| company_id | INTEGER | true | Company identifier | The multi-tenant or branch company ID. |
| stage_id | INTEGER | true | Pipeline stage identifier | The current status in the sales funnel. |
| partner_id | INTEGER | true | Partner/Customer identifier | The customer or contact associated with the lead. |
| lead_type | VARCHAR | true | Lead classification | e.g., 'lead' vs 'opportunity'. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the record is currently active. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Likely link to the primary lead record)
    - `user_id` → `res_users.id` (Likely link to system users)
    - `team_id` → `crm_team.id` (Likely link to sales teams)
    - `partner_id` → `res_partner.id` (Likely link to customer/contact records)
    - `stage_id` → `crm_stage.id` (Likely link to pipeline stage definitions)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` column may contain PII or sensitive communication notes; ensure masking is applied if exposed to non-authorized users.
- **Timezones:** Timestamps are assumed to be in UTC; verify against source system configuration if local time offsets are required.
- **Soft Deletes:** The `active` column should be used to filter out inactive records in all downstream queries.
- **Data Quality:** The `id` column is marked as nullable in the source metadata, which is unusual for a primary key; verify if this table contains duplicates or incomplete records.