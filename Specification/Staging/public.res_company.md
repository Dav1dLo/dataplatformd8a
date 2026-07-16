# res_company

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `res_company` is a standard Odoo core table, and the presence of columns like `partner_id`, `chart_template`, and various `account_*` and `stock_*` fields confirms its role as the central configuration entity for multi-company Odoo environments.

## Functional process 
This table supports the "Enterprise Configuration and Multi-Company Management" process. It acts as the master record for each legal entity within the Odoo instance, defining global settings for accounting (fiscal years, tax rounding, chart of accounts), inventory (lead times, stock validation), sales (quotation validity, payment terms), and human resources (presence control).

## Description
One row in this table represents a single company or legal entity configured within the Odoo platform. It serves as the primary configuration hub, storing operational defaults, contact information, and accounting/logistics parameters that govern the behavior of other modules for that specific company. This is a raw landed copy of the Odoo `res_company` table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| name | VARCHAR | false | Company name | Display name of the entity. |
| partner_id | INTEGER | false | Linked partner ID | Foreign key to `res_partner`. |
| currency_id | INTEGER | false | Default currency ID | Foreign key to `res_currency`. |
| sequence | INTEGER | true | Display sequence | Used for sorting in UI. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| parent_path | VARCHAR | true | Materialized path | Used for hierarchical company structures. |
| parent_id | INTEGER | true | Parent company ID | Self-referencing FK for multi-company hierarchy. |
| paperformat_id | INTEGER | true | Report paper format | FK to report configuration. |
| external_report_layout_id | INTEGER | true | Report layout ID | FK to report template. |
| create_uid | INTEGER | true | Creator user ID | FK to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | FK to `res_users`. |
| email | VARCHAR | true | Company email | Contact email address. |
| phone | VARCHAR | true | Company phone | Contact phone number. |
| mobile | VARCHAR | true | Company mobile | Contact mobile number. |
| font | VARCHAR | true | Report font | CSS/Font configuration for reports. |
| primary_color | VARCHAR | true | Primary brand color | Hex code for branding. |
| secondary_color | VARCHAR | true | Secondary brand color | Hex code for branding. |
| layout_background | VARCHAR | false | Background style | Configuration for report layouts. |
| report_header | JSONB | true | Header configuration | JSON structure for report headers. |
| report_footer | JSONB | true | Footer configuration | JSON structure for report footers. |
| company_details | JSONB | true | Legal details | JSON structure for company info. |
| active | BOOLEAN | true | Active status | Soft-delete flag. |
| uses_default_logo | BOOLEAN | true | Logo flag | Indicates if default logo is used. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| logo_web | BYTEA | true | Binary logo data | Base64/Binary image data. |
| social_twitter | VARCHAR | true | Twitter URL | Social media link. |
| social_facebook | VARCHAR | true | Facebook URL | Social media link. |
| social_github | VARCHAR | true | GitHub URL | Social media link. |
| social_linkedin | VARCHAR | true | LinkedIn URL | Social media link. |
| social_youtube | VARCHAR | true | YouTube URL | Social media link. |
| social_instagram | VARCHAR | true | Instagram URL | Social media link. |
| social_tiktok | VARCHAR | true | TikTok URL | Social media link. |
| nomenclature_id | INTEGER | true | Nomenclature ID | FK for POS/Inventory. |
| resource_calendar_id | INTEGER | true | Working calendar ID | FK to `resource_calendar`. |
| alias_domain_id | INTEGER | true | Alias domain ID | FK to email domain config. |
| alias_domain_name | VARCHAR | true | Alias domain name | String representation of domain. |
| email_primary_color | VARCHAR | true | Email primary color | Branding for outgoing emails. |
| email_secondary_color | VARCHAR | true | Email secondary color | Branding for outgoing emails. |
| partner_gid | INTEGER | true | Global ID | External partner identifier. |
| iap_enrich_auto_done | BOOLEAN | true | IAP enrichment flag | Odoo IAP service status. |
| snailmail_color | BOOLEAN | true | Snailmail color | Print service setting. |
| snailmail_cover | BOOLEAN | true | Snailmail cover | Print service setting. |
| snailmail_duplex | BOOLEAN | true | Snailmail duplex | Print service setting. |
| payment_onboarding_payment_method | VARCHAR | true | Payment method | Onboarding status. |
| fiscalyear_last_day | INTEGER | false | Fiscal year end day | Integer (1-31). |
| transfer_account_id | INTEGER | true | Transfer account ID | Accounting configuration. |
| default_cash_difference_income_account_id | INTEGER | true | Cash income diff account | Accounting configuration. |
| default_cash_difference_expense_account_id | INTEGER | true | Cash expense diff account | Accounting configuration. |
| account_journal_suspense_account_id | INTEGER | true | Suspense account ID | Accounting configuration. |
| account_journal_early_pay_discount_gain_account_id | INTEGER | true | Early pay gain account | Accounting configuration. |
| account_journal_early_pay_discount_loss_account_id | INTEGER | true | Early pay loss account | Accounting configuration. |
| account_sale_tax_id | INTEGER | true | Default sale tax ID | Accounting configuration. |
| account_purchase_tax_id | INTEGER | true | Default purchase tax ID | Accounting configuration. |
| currency_exchange_journal_id | INTEGER | true | Exchange journal ID | Accounting configuration. |
| income_currency_exchange_account_id | INTEGER | true | Income exchange account | Accounting configuration. |
| expense_currency_exchange_account_id | INTEGER | true | Expense exchange account | Accounting configuration. |
| incoterm_id | INTEGER | true | Default incoterm ID | Logistics configuration. |
| batch_payment_sequence_id | INTEGER | true | Batch payment seq ID | Accounting configuration. |
| account_opening_move_id | INTEGER | true | Opening move ID | Accounting configuration. |
| account_default_pos_receivable_account_id | INTEGER | true | POS receivable account | Accounting configuration. |
| expense_accrual_account_id | INTEGER | true | Expense accrual account | Accounting configuration. |
| revenue_accrual_account_id | INTEGER | true | Revenue accrual account | Accounting configuration. |
| automatic_entry_default_journal_id | INTEGER | true | Auto entry journal ID | Accounting configuration. |
| account_fiscal_country_id | INTEGER | true | Fiscal country ID | Accounting configuration. |
| tax_cash_basis_journal_id | INTEGER | true | Cash basis journal ID | Accounting configuration. |
| account_cash_basis_base_account_id | INTEGER | true | Cash basis base account | Accounting configuration. |
| account_discount_income_allocation_id | INTEGER | true | Discount income alloc | Accounting configuration. |
| account_discount_expense_allocation_id | INTEGER | true | Discount expense alloc | Accounting configuration. |
| fiscalyear_last_month | VARCHAR | false | Fiscal year end month | String (e.g., '12'). |
| chart_template | VARCHAR | true | Chart template code | Accounting configuration. |
| bank_account_code_prefix | VARCHAR | true | Bank account prefix | Accounting configuration. |
| cash_account_code_prefix | VARCHAR | true | Cash account prefix | Accounting configuration. |
| transfer_account_code_prefix | VARCHAR | true | Transfer account prefix | Accounting configuration. |
| tax_calculation_rounding_method | VARCHAR | true | Tax rounding method | Accounting configuration. |
| terms_type | VARCHAR | true | Terms type | Invoice terms configuration. |
| quick_edit_mode | VARCHAR | true | Quick edit mode | UI configuration. |
| account_price_include | VARCHAR | false | Price include setting | Accounting configuration. |
| fiscalyear_lock_date | DATE | true | Fiscal year lock date | Accounting configuration. |
| tax_lock_date | DATE | true | Tax lock date | Accounting configuration. |
| sale_lock_date | DATE | true | Sale lock date | Accounting configuration. |
| purchase_lock_date | DATE | true | Purchase lock date | Accounting configuration. |
| hard_lock_date | DATE | true | Hard lock date | Accounting configuration. |
| account_opening_date | DATE | false | Opening date | Accounting configuration. |
| invoice_terms | JSONB | true | Invoice terms | JSON content. |
| invoice_terms_html | JSONB | true | Invoice terms HTML | JSON content. |
| expects_chart_of_accounts | BOOLEAN | true | Chart of accounts flag | Accounting configuration. |
| anglo_saxon_accounting | BOOLEAN | true | Anglo-Saxon accounting | Accounting configuration. |
| qr_code | BOOLEAN | true | QR code enabled | Invoice configuration. |
| display_invoice_amount_total_words | BOOLEAN | true | Amount in words flag | Invoice configuration. |
| display_invoice_tax_company_currency | BOOLEAN | true | Tax currency flag | Invoice configuration. |
| account_use_credit_limit | BOOLEAN | true | Credit limit flag | Accounting configuration. |
| tax_exigibility | BOOLEAN | true | Tax exigibility flag | Accounting configuration. |
| account_storno | BOOLEAN | true | Storno accounting flag | Accounting configuration. |
| check_account_audit_trail | BOOLEAN | true | Audit trail flag | Accounting configuration. |
| autopost_bills | BOOLEAN | true | Autopost bills flag | Accounting configuration. |
| hr_presence_control_email_amount | INTEGER | true | Presence email threshold | HR configuration. |
| hr_presence_control_ip_list | VARCHAR | true | Allowed IP list | HR configuration. |
| employee_properties_definition | JSONB | true | Employee properties | JSON configuration. |
| hr_presence_control_login | BOOLEAN | true | Login presence control | HR configuration. |
| hr_presence_control_email | BOOLEAN | true | Email presence control | HR configuration. |
| hr_presence_control_ip | BOOLEAN | true | IP presence control | HR configuration. |
| hr_presence_control_attendance | BOOLEAN | true | Attendance control | HR configuration. |
| internal_transit_location_id | INTEGER | true | Transit location ID | Inventory configuration. |
| stock_mail_confirmation_template_id | INTEGER | true | Mail template ID | Inventory configuration. |
| annual_inventory_day | INTEGER | true | Annual inventory day | Inventory configuration. |
| annual_inventory_month | VARCHAR | true | Annual inventory month | Inventory configuration. |
| stock_move_email_validation | BOOLEAN | true | Email validation flag | Inventory configuration. |
| website_id | INTEGER | true | Website ID | FK to `website`. |
| manufacturing_lead | DOUBLE PRECISION | false | Manufacturing lead time | Days. |
| po_lock | VARCHAR | true | PO lock setting | Purchase configuration. |
| po_double_validation | VARCHAR | true | PO validation setting | Purchase configuration. |
| po_double_validation_amount | NUMERIC | true | PO validation amount | Purchase configuration. |
| po_lead | DOUBLE PRECISION | false | PO lead time | Days. |
| account_production_wip_account_id | INTEGER | true | WIP account ID | Accounting configuration. |
| account_production_wip_overhead_account_id | INTEGER | true | WIP overhead account ID | Accounting configuration. |
| stock_sms_confirmation_template_id | INTEGER | true | SMS template ID | Inventory configuration. |
| stock_move_sms_validation | BOOLEAN | true | SMS validation flag | Inventory configuration. |
| has_received_warning_stock_sms | BOOLEAN | true | SMS warning flag | Inventory configuration. |
| point_of_sale_update_stock_quantities | VARCHAR | true | POS stock update mode | POS configuration. |
| point_of_sale_ticket_portal_url_display_mode | VARCHAR | false | POS ticket URL mode | POS configuration. |
| point_of_sale_use_ticket_qr_code | BOOLEAN | true | POS QR code flag | POS configuration. |
| point_of_sale_ticket_unique_code | BOOLEAN | true | POS unique code flag | POS configuration. |
| days_to_purchase | DOUBLE PRECISION | true | Days to purchase | Lead time. |
| quotation_validity_days | INTEGER | true | Quotation validity | Days. |
| sale_discount_product_id | INTEGER | true | Discount product ID | Sale configuration. |
| sale_onboarding_payment_method | VARCHAR | true | Sale onboarding method | Sale configuration. |
| portal_confirmation_sign | BOOLEAN | true | Portal sign flag | Sale configuration. |
| portal_confirmation_pay | BOOLEAN | true | Portal pay flag | Sale configuration. |
| prepayment_percent | DOUBLE PRECISION | true | Prepayment percentage | Percentage. |
| sale_order_template_id | INTEGER | true | Sale order template ID | Sale configuration. |
| security_lead | DOUBLE PRECISION | false | Security lead time | Days. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `partner_id` → `res_partner.id` (Standard Odoo link between company and partner record)
    - `currency_id` → `res_currency.id` (Defines the base currency for the company)
    - `parent_id` → `res_company.id` (Self-reference for multi-company hierarchy)
- **Natural keys (inferred):**
    - `name` (While not strictly unique in all Odoo setups, it is the primary business identifier for a company)

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless historical analysis of inactive companies is required.
- **Sensitive Data:** Contains `email`, `phone`, and `mobile` fields which may be considered PII.
- **Binary Data:** The `logo_web` column contains `BYTEA` (binary) data; exclude this from standard analytical queries to avoid performance degradation.
- **JSONB:** Several columns (`report_header`, `report_footer`, `company_details`, `invoice_terms`) use `JSONB`. Ensure your SQL dialect supports `->>` or `->` operators for extraction.

```sql
-- Get all active companies with their base currency
SELECT 
    "name", 
    "email", 
    "currency_id" 
FROM "public"."res_company" 
WHERE "active" = TRUE;
```

```sql
-- Count companies by parent hierarchy
SELECT 
    "parent_id", 
    COUNT(*) as "company_count" 
FROM "public"."res_company" 
GROUP BY "parent_id";
```

```sql
-- Identify companies with specific accounting lock dates
SELECT 
    "name", 
    "fiscalyear_lock_date", 
    "tax_lock_date" 
FROM "public"."res_company" 
WHERE "fiscalyear_lock_date" IS NOT NULL 
LIMIT 10;
```