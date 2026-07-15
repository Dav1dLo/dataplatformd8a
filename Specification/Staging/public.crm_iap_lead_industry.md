# crm_iap_lead_industry

## Source system
This table originates from an Odoo ERP instance, as evidenced by the naming convention (`crm_iap_lead_industry`), the use of `create_uid`/`write_uid` audit columns, and the `JSONB` type for the `name` field, which is characteristic of Odoo's multi-language field storage.

## Functional process 
This table supports the Lead-to-Cash pipeline by categorizing leads based on industry sectors. It is used by the In-App Purchasing (IAP) lead enrichment service to map discovered lead data to predefined industry classifications within the CRM module.

## Description
One row represents a single industry classification category used for lead enrichment. This is a raw landed staging table containing the configuration data for industry labels, including their display sequence and associated metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_iap_lead_industry_id_seq`. |
| color | INTEGER | true | UI color index | Used for visual categorization in the CRM interface. |
| sequence | INTEGER | true | Display order | Determines the sort order in dropdowns or lists. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated this record. |
| reveal_ids | VARCHAR | false | IAP mapping identifiers | Likely a comma-separated list of IDs used by the IAP service. |
| name | JSONB | false | Industry name | Multi-language field; stores translations as JSON objects. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone unknown. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone unknown. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit columns).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit columns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is `JSONB`; queries will require extraction (e.g., `name->>'en_US'`) to access specific language values.
- Timestamps (`create_date`, `write_date`) are provided as-is from the source; verify if the source system stores these in UTC or local server time.
- The `reveal_ids` column contains a string of IDs; this will require parsing (e.g., `string_to_array`) if used for joining against other tables.
- This table is a configuration/lookup table; it is unlikely to contain PII, but `reveal_ids` should be reviewed for potential sensitive mapping data.