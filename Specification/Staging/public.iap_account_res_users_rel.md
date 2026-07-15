# iap_account_res_users_rel

## Source system
The table likely originates from an Odoo ERP instance, as indicated by the naming convention `res_users` (a standard Odoo table for system users) and the `iap_account` prefix, which refers to Odoo's In-App Purchase (IAP) service integration.

## Functional process 
This table supports the management of In-App Purchase (IAP) account access, specifically mapping system users to their respective IAP accounts. It facilitates the authorization process for users to consume or manage IAP credits and services within the ERP environment.

## Description
This table represents a many-to-many relationship between Odoo system users and IAP accounts. Each row acts as a join record, linking a specific user to an IAP account to define access permissions. As a staging table, it provides a raw, landed representation of the association as it exists in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| iap_account_id | INTEGER | false | Foreign key to the IAP account | Represents the unique identifier for the IAP account entity. |
| res_users_id | INTEGER | false | Foreign key to the system user | Represents the unique identifier for the user in the `res_users` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(iap_account_id, res_users_id)`.
- **Foreign keys (inferred):** 
    - `iap_account_id` → `iap_account.id` (Inferred from naming convention).
    - `res_users_id` → `res_users.id` (Inferred from standard Odoo schema naming).
- **Natural keys (inferred):** The combination of `(iap_account_id, res_users_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table contains no timestamps or audit columns; it is a pure join table.
- There is no soft-delete flag; assume records are removed from this table when the association is revoked in the source system.
- Ensure joins to `res_users` are handled carefully, as this table only contains the IDs required to resolve the relationship.