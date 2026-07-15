# crm_iap_lead_role

## Source system
This table originates from an Odoo ERP system. The naming convention `crm_iap_lead_role`, the presence of `create_uid`/`write_uid` audit columns, and the use of `JSONB` for localized fields (common in Odoo's multi-language support) are characteristic of the Odoo CRM module's In-App Purchase (IAP) lead enrichment features.

## Functional process 
This table supports the lead management and enrichment process within the CRM. It defines the roles or categories assigned to leads identified through IAP services, allowing the system to classify incoming leads based on their organizational or professional profile.

## Description
One row in this table represents a specific lead role definition used to categorize CRM leads. This is a raw landing table in the Staging layer, containing the direct database representation of the role configuration, including localized names and audit metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_iap_lead_role_id_seq`. |
| color | INTEGER | true | UI color index | Used for visual categorization in the CRM interface. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated this record. |
| reveal_id | VARCHAR | false | External IAP identifier | The unique identifier for the role provided by the IAP service. |
| name | JSONB | false | Localized role name | Stores the name in multiple languages; access via `name->>'en_US'` etc. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `reveal_id`: This appears to be the unique business key provided by the external IAP service.

## Caveats for downstream consumers

- **PII/Sensitivity:** Contains no direct PII, but `name` (JSONB) may contain internal business terminology.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Structure:** The `name` column is a `JSONB` object; downstream queries must use PostgreSQL JSON operators (e.g., `->>`) to extract specific language values.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if missing from source.