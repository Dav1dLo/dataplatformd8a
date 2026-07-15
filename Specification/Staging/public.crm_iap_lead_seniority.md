# crm_iap_lead_seniority

## Source system
This table originates from an Odoo ERP or CRM system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys (`nextval` on `id`).

## Functional process 
This table supports the lead qualification and enrichment process, specifically tracking the seniority levels of leads identified through an IAP (In-App Purchase) or external lead intelligence service. It maps internal lead identifiers to localized or structured seniority metadata.

## Description
Each row represents a specific seniority classification record associated with a lead, likely used to categorize prospects by professional level. This is a staging table containing a raw, landed copy of the source system's seniority configuration or mapping data. The grain is one row per seniority definition or lead-seniority association.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; do not rely on for business logic. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user system. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user system. |
| reveal_id | VARCHAR | false | External lead intelligence identifier | Likely the natural key from the IAP provider. |
| name | JSONB | false | Seniority label/metadata | Stores multi-language or structured seniority data. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC; verify against application settings. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC; verify against application settings. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `reveal_id`: This appears to be the unique identifier provided by the external lead intelligence service.

## Caveats for downstream consumers

- **Sensitive Data:** The `name` column contains JSONB data which may include PII or proprietary classification labels; ensure appropriate masking if exposed to non-authorized users.
- **Timestamps:** Timestamps are stored as `TIMESTAMP` without timezone; assume UTC unless the application configuration specifies otherwise.
- **JSONB Handling:** The `name` column requires PostgreSQL JSONB operators (e.g., `->>`) to extract values for reporting.
- **Soft Deletes:** There is no explicit `active` or `deleted` flag; assume all records are current unless otherwise specified by the source system's business logic.