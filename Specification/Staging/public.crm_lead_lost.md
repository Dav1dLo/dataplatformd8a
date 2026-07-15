# crm_lead_lost

## Source system
The table likely originates from an Odoo ERP or CRM system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences for primary keys, is highly characteristic of the Odoo framework's database schema.

## Functional process 
This table supports the sales pipeline management process, specifically tracking the "lost lead" lifecycle. It captures the qualitative and categorical reasons why a potential sales opportunity was not converted, providing the necessary data for sales performance analysis and churn mitigation strategies.

## Description
One row in this table represents a single instance of a lead being marked as "lost" within the CRM. It serves as a raw staging entity, storing the feedback and metadata associated with the loss event to facilitate downstream reporting on sales conversion rates and loss trends.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_lead_lost_id_seq`. |
| lost_reason_id | INTEGER | true | Foreign key to the lost reason lookup table | Categorical identifier for why the lead was lost. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who logged the loss. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the entry. |
| lost_feedback | TEXT | true | Qualitative notes on the loss | Free-text field for sales representative comments. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lost_reason_id` → `crm_lost_reason.id` (Guess: standard Odoo pattern for linking to a lookup table).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user audit trails).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user audit trails).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `lost_feedback` column may contain unstructured text with PII; ensure appropriate masking if exposing to non-authorized users.
- **Timestamps:** All date fields (`create_date`, `write_date`) are assumed to be in UTC.
- **Soft Deletes:** This table does not explicitly show a `deleted_at` or `active` flag; assume all rows are active unless a separate audit log exists.
- **Data Quality:** As a staging table, `lost_feedback` may contain inconsistent formatting or empty strings; validate for nulls before performing text analysis.