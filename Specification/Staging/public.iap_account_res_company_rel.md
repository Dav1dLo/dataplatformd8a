# iap_account_res_company_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `res_company` and `iap_account` (In-App Purchase) is characteristic of Odoo's internal data model, where `res_company` represents the multi-company structure and `iap_account` manages service credits or subscriptions.

## Functional process 
This table supports the multi-company configuration for In-App Purchase (IAP) services. It acts as a bridge to manage which IAP accounts are associated with which legal entities (companies) within the ERP, ensuring that service consumption and billing are correctly attributed to the appropriate organizational unit.

## Description
One row in this table represents a many-to-many relationship mapping between an IAP account and a company. It serves as a raw landing copy of the association table, used to resolve which IAP service credits are available to specific companies in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| iap_account_id | INTEGER | false | Foreign key to the IAP account record | Links to the primary account definition. |
| res_company_id | INTEGER | false | Foreign key to the company record | Links to the organizational entity definition. |

## Keys

- **Primary key (inferred):** The combination of (`iap_account_id`, `res_company_id`) forms the composite primary key.
- **Foreign keys (inferred):** 
    - `iap_account_id` → `iap_account.id`: This column references the unique identifier of the IAP account.
    - `res_company_id` → `res_company.id`: This column references the unique identifier of the company entity.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join/link table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this table, making it difficult to determine the history of associations without joining to parent tables.
- Ensure that joins to `res_company` and `iap_account` are handled as inner joins if you only require active associations.