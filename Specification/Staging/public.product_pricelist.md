# product_pricelist

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions (`create_uid`, `write_uid`, `write_date`), the use of `JSONB` for multi-language fields (`name`), and the sequence-based primary key pattern.

## Functional process 
This table supports the pricing and sales management process by defining various price lists used to determine product pricing for different customers, regions, or sales channels. It acts as the header entity for price list configurations, which are subsequently linked to specific price rules or product variants.

## Description
One row represents a single price list configuration, defining the currency and organizational scope for a set of pricing rules. This is a raw landed copy of the Odoo `product.pricelist` model, serving as a staging entity for downstream dimension modeling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `product_pricelist_id_seq`. |
| sequence | INTEGER | true | Display order | Used to determine priority when multiple price lists apply. |
| currency_id | INTEGER | false | Foreign key to currency | References the currency used for this price list. |
| company_id | INTEGER | true | Foreign key to company | Restricts the price list to a specific company/branch. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| name | JSONB | false | Price list name | Multi-language string stored as JSON. |
| active | BOOLEAN | true | Soft-delete flag | If false, the price list is hidden from active selection. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id` (Guess: standard Odoo naming for currency references).
    - `company_id` → `res_company.id` (Guess: standard Odoo naming for multi-company scoping).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo audit trail pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** No direct PII, though `create_uid` and `write_uid` link to user identities.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` unless historical analysis is required.
- **JSONB:** The `name` column contains JSON data; use PostgreSQL `->>` operator to extract text values (e.g., `name->>'en_US'`).