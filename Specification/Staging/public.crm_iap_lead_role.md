# crm_iap_lead_role

## Source system
This table originates from an Odoo ERP instance, indicated by the naming convention `crm_iap_lead_role`, the use of `create_uid`/`write_uid` audit columns, and the `JSONB` data type for multi-language field storage, which are characteristic of the Odoo ORM.

## Functional process 
This table supports the Lead-to-Cash pipeline by defining the roles or categories assigned to leads generated via In-App Purchasing (IAP) services. It manages the classification metadata used to segment incoming leads based on their specific business role or profile.

## Description
One row in this table represents a single lead role definition used within the CRM module. It serves as a raw landed copy of the configuration entity, capturing the identity, display name, and audit trail for each role.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo ORM. |
| color | INTEGER | true | UI color index | Used for visual categorization in the CRM dashboard. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| reveal_id | VARCHAR | false | External IAP identifier | Unique identifier provided by the IAP service provider. |
| name | JSONB | false | Role name | Multilingual string storage; typically contains keys for language codes. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** 
    - `reveal_id` (The external identifier provided by the IAP service is expected to be unique per role).

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified; this table contains configuration and metadata rather than customer PII.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **JSONB Handling:** The `name` column is stored as `JSONB`. Downstream consumers must use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract human-readable text.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (`active` column is missing), suggesting that records are either hard-deleted or always active.