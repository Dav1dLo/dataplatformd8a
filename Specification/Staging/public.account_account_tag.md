# account_account_tag

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`account_account_tag`), the use of `JSONB` for localized fields like `name`, and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the financial accounting module, specifically the categorization of accounts for reporting and tax purposes. It manages tags that can be applied to accounts to influence financial statements or tax calculations, as indicated by the `tax_negate` and `applicability` columns.

## Description
One row represents a single account tag definition used to classify or group accounts within the general ledger. This is a raw landing table in the Staging layer, capturing the configuration state of account tags directly from the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_account_tag_id_seq`. |
| color | INTEGER | true | UI color index | Used for visual grouping in the application interface. |
| country_id | INTEGER | true | Foreign key to country | Links the tag to a specific fiscal jurisdiction. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| applicability | VARCHAR | false | Scope of the tag | Defines where the tag can be applied (e.g., 'accounts', 'taxes'). |
| name | JSONB | false | Tag label | Multilingual label stored as a JSON object. |
| active | BOOLEAN | true | Soft-delete flag | If false, the tag is hidden from the UI. |
| tax_negate | BOOLEAN | true | Tax calculation flag | If true, negates the tax amount for this tag. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `country_id` → `res_country.id` (Guess: standard Odoo pattern for country-specific configurations).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` to retrieve only currently valid tags.
- **JSONB:** The `name` column contains JSON data; use PostgreSQL `->>` operator to extract text values (e.g., `name->>'en_US'`).
- **Sensitivity:** No direct PII, but contains internal configuration data that should be handled according to internal data governance policies.