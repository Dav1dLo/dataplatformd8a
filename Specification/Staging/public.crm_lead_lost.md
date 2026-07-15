# crm_lead_lost

## Source system
This table originates from an Odoo-based CRM system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the sales pipeline management process, specifically tracking the "lost lead" workflow. It captures the qualitative feedback and categorical reasons why a potential sales opportunity was not converted, which is essential for sales performance analysis and churn mitigation.

## Description
One row in this table represents a single instance of a lead being marked as "lost" within the CRM. It serves as a raw landing record in the staging layer, preserving the metadata and feedback associated with the loss event for downstream analytical reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| lost_reason_id | INTEGER | true | Foreign key to the lost reason lookup table | Categorizes the reason for loss. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user system. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user system. |
| lost_feedback | TEXT | true | Qualitative notes on why the lead was lost | Free-text field; may contain PII. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lost_reason_id` → `crm_lost_reason.id` (Guess: standard Odoo pattern for linking loss categories).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit trails).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit trails).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `lost_feedback` column is a free-text field and may contain PII or sensitive customer information; ensure appropriate masking if exposed to non-authorized users.
- **Timestamps:** All timestamps (`create_date`, `write_date`) are assumed to be in UTC.
- **Soft Deletes:** This table does not explicitly show a soft-delete flag; however, Odoo-based systems often use `active` columns (not present here) to manage lifecycle.
- **Data Quality:** As a staging table, `lost_feedback` may contain inconsistent formatting or empty strings.