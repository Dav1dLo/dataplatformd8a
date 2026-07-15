# crm_lead

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming conventions (e.g., `create_uid`, `write_uid`, `partner_id`, `crm_lead` table name) and the specific pattern of tracking `date_open`, `date_closed`, and `stage_id` are characteristic of the Odoo CRM module's lead/opportunity management schema.

## Functional process 
This table supports the Lead-to-Opportunity pipeline. It tracks the lifecycle of potential business prospects from initial acquisition (via `source_id`, `campaign_id`) through qualification, stage progression (`stage_id`), and final conversion or loss (`lost_reason_id`). It also handles financial forecasting via various revenue fields (`expected_revenue`, `recurring_revenue`).

## Description
One row represents a single lead or opportunity within the CRM system. The grain is one row per lead/opportunity record. In the Staging layer, this table serves as a raw, near-1:1 landed copy of the Odoo `crm.lead` model, intended for downstream transformation into analytical facts and dimensions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| campaign_id | INTEGER | true | Marketing campaign ID | Foreign key to campaign table. |
| source_id | INTEGER | true | Lead source ID | Foreign key to source table. |
| medium_id | INTEGER | true | Marketing medium ID | Foreign key to medium table. |
| message_bounce | INTEGER | true | Bounce count | Number of bounced emails. |
| user_id | INTEGER | true | Assigned salesperson ID | Foreign key to res.users. |
| team_id | INTEGER | true | Sales team ID | Foreign key to crm.team. |
| company_id | INTEGER | true | Company ID | Multi-company context. |
| stage_id | INTEGER | true | Current pipeline stage ID | Foreign key to crm.stage. |
| color | INTEGER | true | UI color index | Used for Kanban view styling. |
| recurring_plan | INTEGER | true | Subscription plan ID | Foreign key to recurring plan. |
| partner_id | INTEGER | true | Linked customer/partner ID | Foreign key to res.partner. |
| title | INTEGER | true | Contact title ID | Foreign key to res.partner.title. |
| lang_id | INTEGER | true | Language ID | Foreign key to res.lang. |
| state_id | INTEGER | true | State/Province ID | Foreign key to res.country.state. |
| country_id | INTEGER | true | Country ID | Foreign key to res.country. |
| lost_reason_id | INTEGER | true | Reason for loss ID | Foreign key to crm.lost.reason. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to res.users. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to res.users. |
| phone_sanitized | VARCHAR | true | E.164 formatted phone | Normalized for dialing. |
| email_normalized | VARCHAR | true | Normalized email address | Lowercase, trimmed. |
| email_cc | VARCHAR | true | CC email addresses | Comma-separated list. |
| name | VARCHAR | false | Lead/Opportunity name | Subject line or title. |
| referred | VARCHAR | true | Referral source | Free text. |
| type | VARCHAR | false | Record type | 'lead' or 'opportunity'. |
| priority | VARCHAR | true | Priority level | Usually '0', '1', '2', '3'. |
| contact_name | VARCHAR | true | Primary contact name | Individual name. |
| partner_name | VARCHAR | true | Company/Partner name | Organization name. |
| function | VARCHAR | true | Job title | Role of the contact. |
| email_from | VARCHAR | true | Sender email | Original email address. |
| email_domain_criterion | VARCHAR | true | Domain filter | Used for deduplication. |
| phone | VARCHAR | true | Raw phone number | As entered by user. |
| mobile | VARCHAR | true | Mobile number | As entered by user. |
| phone_state | VARCHAR | true | Phone validation status | e.g., 'correct', 'incorrect'. |
| email_state | VARCHAR | true | Email validation status | e.g., 'correct', 'incorrect'. |
| website | VARCHAR | true | Website URL | Company website. |
| street | VARCHAR | true | Address line 1 | |
| street2 | VARCHAR | true | Address line 2 | |
| zip | VARCHAR | true | Postal code | |
| city | VARCHAR | true | City name | |
| date_deadline | DATE | true | Expected closing date | |
| lead_properties | JSONB | true | Custom attributes | Flexible storage for metadata. |
| description | TEXT | true | Internal notes | |
| expected_revenue | NUMERIC | true | Expected revenue | Currency units. |
| prorated_revenue | NUMERIC | true | Prorated revenue | |
| recurring_revenue | NUMERIC | true | Recurring revenue | |
| recurring_revenue_monthly | NUMERIC | true | Monthly recurring revenue | |
| recurring_revenue_monthly_prorated | NUMERIC | true | Monthly prorated MRR | |
| recurring_revenue_prorated | NUMERIC | true | Prorated recurring revenue | |
| active | BOOLEAN | true | Soft-delete flag | False indicates archived. |
| date_closed | TIMESTAMP | true | Closure timestamp | |
| date_automation_last | TIMESTAMP | true | Last automation run | |
| date_open | TIMESTAMP | true | Qualification timestamp | |
| date_last_stage_update | TIMESTAMP | true | Last stage change | |
| date_conversion | TIMESTAMP | true | Conversion timestamp | |
| create_date | TIMESTAMP | true | Record creation time | |
| write_date | TIMESTAMP | true | Last modification time | |
| day_open | DOUBLE PRECISION | true | Days to open | |
| day_close | DOUBLE PRECISION | true | Days to close | |
| probability | DOUBLE PRECISION | true | Win probability | 0.0 to 100.0. |
| automated_probability | DOUBLE PRECISION | true | AI-calculated probability | |
| reveal_id | VARCHAR | true | Lead enrichment ID | External service reference. |
| iap_enrich_done | BOOLEAN | true | Enrichment status | In-App Purchase enrichment. |
| lead_mining_request_id | INTEGER | true | Mining request ID | Foreign key to lead mining. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Standard Odoo ownership pattern)
    - `team_id` → `crm_team.id` (Standard Odoo sales team pattern)
    - `stage_id` → `crm_stage.id` (Standard Odoo pipeline stage pattern)
    - `partner_id` → `res_partner.id` (Standard Odoo customer link)
- **Natural keys (inferred):** 
    - None. Odoo relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **PII/Sensitive Data:** Contains `email_from`, `phone`, `mobile`, and `name`. Ensure these are masked in non-production environments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless performing audit/historical analysis.
- **Timezones:** Timestamps are typically stored in UTC in Odoo; verify against the `postgresql` server configuration.
- **JSONB:** `lead_properties` contains unstructured data; use `->>` or `jsonb_extract_path_text` to access specific keys.
- **Revenue:** Financial fields are `NUMERIC` to avoid floating-point errors; ensure downstream aggregations maintain this precision.