# crm_lead

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `_id` suffixes for relational lookups. The structure is typical of Odoo's `crm.lead` model, which manages both leads and opportunities within their sales module.

## Functional process 
This table supports the Lead-to-Cash pipeline, specifically the lead management and opportunity tracking process. It captures the lifecycle of a sales prospect from initial acquisition (source, medium, campaign) through qualification and stage progression, ultimately tracking expected revenue and conversion metrics.

## Description
One row in this table represents a single lead or sales opportunity within the CRM system. It tracks contact details, qualification status, revenue projections, and historical timestamps for stage transitions. This table serves as a raw landed copy of the Odoo `crm_lead` model in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| campaign_id | INTEGER | true | Marketing campaign ID | Foreign key to campaign table. |
| source_id | INTEGER | true | Marketing source ID | E.g., Google, Newsletter. |
| medium_id | INTEGER | true | Marketing medium ID | E.g., Email, CPC. |
| message_bounce | INTEGER | true | Bounce count | Number of failed email deliveries. |
| user_id | INTEGER | true | Assigned salesperson ID | Owner of the lead. |
| team_id | INTEGER | true | Sales team ID | Departmental assignment. |
| company_id | INTEGER | true | Company ID | Multi-company context. |
| stage_id | INTEGER | true | Pipeline stage ID | Current status in the funnel. |
| color | INTEGER | true | UI color index | Used for Kanban board styling. |
| recurring_plan | INTEGER | true | Subscription plan ID | Links to recurring revenue settings. |
| partner_id | INTEGER | true | Customer/Partner ID | Links to the related contact record. |
| title | INTEGER | true | Honorific/Title ID | E.g., Mr., Ms. |
| lang_id | INTEGER | true | Language ID | Preferred communication language. |
| state_id | INTEGER | true | State/Province ID | Geographic region. |
| country_id | INTEGER | true | Country ID | Geographic location. |
| lost_reason_id | INTEGER | true | Lost reason ID | Reason for closing as 'Lost'. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for last update. |
| phone_sanitized | VARCHAR | true | E.164 formatted phone | Normalized for dialing. |
| email_normalized | VARCHAR | true | Lowercase/cleaned email | Used for deduplication. |
| email_cc | VARCHAR | true | CC email addresses | Comma-separated list. |
| name | VARCHAR | false | Lead/Opportunity name | Primary identifier/subject. |
| referred | VARCHAR | true | Referral source | Free-text referral info. |
| type | VARCHAR | false | Record type | 'lead' or 'opportunity'. |
| priority | VARCHAR | true | Priority level | E.g., 0-3 stars. |
| contact_name | VARCHAR | true | Contact person name | Individual name. |
| partner_name | VARCHAR | true | Company/Partner name | Organization name. |
| function | VARCHAR | true | Job title | Role of the contact. |
| email_from | VARCHAR | true | Sender email | Original email address. |
| email_domain_criterion | VARCHAR | true | Domain filter | Used for automated matching. |
| phone | VARCHAR | true | Raw phone number | As entered by user. |
| mobile | VARCHAR | true | Mobile number | As entered by user. |
| phone_state | VARCHAR | true | Validation status | E.g., 'correct', 'incorrect'. |
| email_state | VARCHAR | true | Validation status | E.g., 'correct', 'incorrect'. |
| website | VARCHAR | true | Website URL | Company website. |
| street | VARCHAR | true | Address line 1 | |
| street2 | VARCHAR | true | Address line 2 | |
| zip | VARCHAR | true | Postal code | |
| city | VARCHAR | true | City name | |
| date_deadline | DATE | true | Expected closing date | |
| lead_properties | JSONB | true | Custom fields | Flexible metadata storage. |
| description | TEXT | true | Internal notes | |
| expected_revenue | NUMERIC | true | Estimated value | |
| prorated_revenue | NUMERIC | true | Risk-adjusted revenue | |
| recurring_revenue | NUMERIC | true | Periodic revenue | |
| recurring_revenue_monthly | NUMERIC | true | Monthly recurring revenue | |
| recurring_revenue_monthly_prorated | NUMERIC | true | Prorated MRR | |
| recurring_revenue_prorated | NUMERIC | true | Prorated recurring revenue | |
| active | BOOLEAN | true | Soft-delete flag | False indicates archived. |
| date_closed | TIMESTAMP | true | Closure timestamp | |
| date_automation_last | TIMESTAMP | true | Last automation run | |
| date_open | TIMESTAMP | true | Qualification timestamp | |
| date_last_stage_update | TIMESTAMP | true | Stage change timestamp | |
| date_conversion | TIMESTAMP | true | Conversion timestamp | |
| create_date | TIMESTAMP | true | Record creation time | |
| write_date | TIMESTAMP | true | Last modification time | |
| day_open | DOUBLE PRECISION | true | Days to qualify | |
| day_close | DOUBLE PRECISION | true | Days to close | |
| probability | DOUBLE PRECISION | true | Win probability | 0.0 to 100.0. |
| automated_probability | DOUBLE PRECISION | true | System-calculated prob | |
| reveal_id | VARCHAR | true | Lead enrichment ID | |
| iap_enrich_done | BOOLEAN | true | Enrichment status | |
| lead_mining_request_id | INTEGER | true | Lead mining job ID | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `user_id` → `res_users.id` (Standard Odoo user association)
    - `team_id` → `crm_team.id` (Standard Odoo sales team association)
    - `stage_id` → `crm_stage.id` (Standard Odoo pipeline stage association)
    - `partner_id` → `res_partner.id` (Standard Odoo contact association)
- **Natural keys (inferred):**
    - `email_normalized` (often used as a business key for deduplication)

## Caveats for downstream consumers

- **Sensitive Data:** Contains PII including `email_from`, `phone`, `mobile`, and address fields. Masking is required for non-authorized users.
- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless performing historical analysis.
- **Revenue:** Revenue columns are `NUMERIC` and likely represent the currency of the company; check `company_id` if multi-currency is enabled.
- **JSONB:** The `lead_properties` column contains unstructured data; ensure your downstream processing can handle schema evolution within this field.