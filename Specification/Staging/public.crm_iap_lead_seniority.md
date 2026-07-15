# crm_iap_lead_seniority

## Source system
This table originates from an Odoo ERP or CRM system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys (`nextval` on `crm_iap_lead_seniority_id_seq`).

## Functional process 
This table supports the lead management and qualification process, specifically tracking the seniority levels of leads identified through an "IAP" (In-App Purchase or Integrated Account Provisioning) service. It maps external lead identifiers to localized or structured seniority metadata.

## Description
One row represents a specific seniority classification record for a lead, identified by an external `reveal_id`. This table serves as a raw landed staging entity, capturing the state of lead seniority definitions as they exist in the source CRM.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; do not rely on for business logic. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user table. |
| reveal_id | VARCHAR | false | External identifier for the lead | Likely a unique key provided by the IAP service. |
| name | JSONB | false | Seniority label/metadata | Stored as JSONB; likely contains multi-language strings or structured attributes. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC; audit field. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC; audit field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `reveal_id` (This appears to be the unique business identifier for the seniority record).

## Caveats for downstream consumers

- **Sensitive Data:** The `name` column contains JSONB data which may contain PII depending on the seniority labels or associated metadata.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **JSONB Handling:** Downstream consumers must use PostgreSQL JSONB operators (e.g., `->>`) to extract values from the `name` column.