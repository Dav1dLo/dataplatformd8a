# account_analytic_applicability

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the specific use of sequence-based primary keys (`nextval` on `id`).

## Functional process 
This table supports the configuration of analytic accounting rules, specifically defining how analytic plans are applied to business documents. It determines the mapping between business domains (e.g., invoices, expenses) and analytic accounts based on product categories or account prefixes.

## Description
One row represents a single configuration rule that dictates whether and how an analytic plan should be applied to a specific business context. This is a raw landing table in the staging layer, capturing the configuration state of analytic applicability rules as they exist in the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_analytic_applicability_id_seq`. |
| analytic_plan_id | INTEGER | true | Foreign key to the analytic plan | Links to the specific analytic plan being configured. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the organization scope for this rule. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who defined this rule. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified this rule. |
| business_domain | VARCHAR | false | Business domain scope | Defines the area of application (e.g., 'invoice', 'expense'). |
| applicability | VARCHAR | false | Applicability mode | Defines the rule behavior (e.g., 'optional', 'mandatory'). |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | In UTC. |
| product_categ_id | INTEGER | true | Foreign key to product category | Optional filter to apply the rule to specific product categories. |
| account_prefix | VARCHAR | true | Account code prefix | Optional filter to apply the rule to specific GL account prefixes. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `analytic_plan_id` → `account_analytic_plan.id` (Guess: standard Odoo naming for analytic plan relations).
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company architecture).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo audit trail pattern).
    - `product_categ_id` → `product_category.id` (Guess: standard Odoo product module relation).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC as per standard Odoo behavior.
- **Sensitivity:** Contains `create_uid` and `write_uid`, which are internal system identifiers; ensure these are mapped to user names via the `res_users` table if needed for reporting.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically hard-deleted in the source system.
- **Data Quality:** `account_prefix` is a string field; ensure downstream joins handle potential variations in formatting or trailing spaces.