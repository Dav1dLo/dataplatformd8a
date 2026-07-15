# crm_iap_lead_industry

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized fields like `name`, which is characteristic of Odoo's multi-language support.

## Functional process 
This table supports the Lead-to-Cash pipeline by categorizing leads based on industry segments. It is used to map lead data to specific industry classifications, likely powering segmentation features within the CRM module.

## Description
One row in this table represents a single industry classification record used for tagging CRM leads. It serves as a raw landed reference table in the staging layer, capturing the metadata and configuration for industry-based lead filtering.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_iap_lead_industry_id_seq`. |
| color | INTEGER | true | UI color index | Used for visual representation in the CRM interface. |
| sequence | INTEGER | true | Sort order | Determines the display order in dropdowns or lists. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| reveal_ids | VARCHAR | false | Reveal service mapping IDs | Likely a comma-separated list of IDs from an external IAP (In-App Purchase) service. |
| name | JSONB | false | Industry name | Localized name stored as a JSON object; requires parsing for specific locales. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for record ownership).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified; this table contains configuration and metadata.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column), so assume all rows are current unless otherwise specified by the source system.
- **JSONB Parsing:** The `name` column requires extraction logic (e.g., `name->>'en_US'`) to be used in reporting or downstream dimensions.
- **Data Pattern:** As a staging table, this data is subject to change and should be validated for schema drift before being promoted to the silver/gold layers.