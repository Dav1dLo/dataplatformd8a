# digest_digest

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`, `JSONB` for translatable fields) and the specific KPI column prefixes (e.g., `kpi_crm_lead_created`) are characteristic of Odoo's internal reporting and digest email configuration modules.

## Functional process 
This table supports the automated business reporting and "Digest" email subscription process. It stores the configuration for periodic summaries sent to users, defining which KPIs (such as CRM leads, sales totals, or project tasks) should be included in the digest and the frequency at which these reports are generated.

## Description
One row in this table represents a single digest configuration record, which defines the schedule and the set of performance indicators to be tracked for a specific company. It serves as a raw landed copy of the Odoo `digest.digest` model, capturing the state, periodicity, and active KPIs for automated reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `digest_digest_id_seq`. |
| company_id | INTEGER | true | Foreign key to company | Links the digest to a specific organization. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| periodicity | VARCHAR | false | Frequency of the digest | e.g., 'daily', 'weekly', 'monthly'. |
| state | VARCHAR | true | Lifecycle status | Current status of the digest configuration. |
| next_run_date | DATE | true | Scheduled execution date | The date the next digest is due to be sent. |
| name | JSONB | false | Digest name | Stored as JSONB for multi-language support. |
| kpi_res_users_connected | BOOLEAN | true | Include active users KPI | Flag to track connected users. |
| kpi_mail_message_total | BOOLEAN | true | Include total emails KPI | Flag to track total mail messages. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |
| kpi_account_total_revenue | BOOLEAN | true | Include total revenue KPI | Flag to track financial revenue. |
| kpi_crm_lead_created | BOOLEAN | true | Include new leads KPI | Flag to track CRM lead generation. |
| kpi_crm_opportunities_won | BOOLEAN | true | Include won opportunities KPI | Flag to track CRM success. |
| kpi_project_task_opened | BOOLEAN | true | Include open tasks KPI | Flag to track project management activity. |
| kpi_pos_total | BOOLEAN | true | Include POS total KPI | Flag to track Point of Sale totals. |
| kpi_all_sale_total | BOOLEAN | true | Include total sales KPI | Flag to track overall sales performance. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may be linked to PII in the `res_users` table.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database deployments.
- **Data Deletion:** This table typically follows Odoo's standard behavior where records are hard-deleted; there is no explicit `active` or `deleted_at` flag present here.
- **JSONB:** The `name` column is a JSONB object; ensure your SQL dialect supports `->>` operators for extracting text values from this field.