# utm_campaign

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` is a standard pattern for Odoo's ORM audit fields, and the `JSONB` type for `title` suggests a modern PostgreSQL-backed implementation.

## Functional process 
This table supports the marketing automation and lead tracking process. It manages the definition and configuration of UTM campaigns, allowing the business to categorize traffic sources and track the performance of various marketing initiatives across different company entities.

## Description
One row in this table represents a single marketing campaign definition, including its configuration, status, and ownership. This is a raw landing table in the staging layer, providing a direct, un-transformed copy of the campaign metadata used for tracking marketing attribution.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.utm_campaign_id_seq`. |
| user_id | INTEGER | false | Owner user ID | Likely references a user in the system. |
| stage_id | INTEGER | false | Campaign stage ID | References the current lifecycle stage of the campaign. |
| color | INTEGER | true | UI color index | Used for visual categorization in the source UI. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Campaign name | The internal identifier or name of the campaign. |
| title | JSONB | false | Localized/Structured title | Stores multi-language or structured title data. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the campaign is currently active. |
| is_auto_campaign | BOOLEAN | true | Automation flag | Indicates if the campaign is managed automatically. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |
| company_id | INTEGER | true | Company ID | Multi-tenant identifier for the owning company. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company pattern).
- **Natural keys (inferred):** 
    - `name` (Assuming campaign names are unique within the system).

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but `title` (JSONB) may contain internal marketing strategy details.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard PostgreSQL configurations for Odoo.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = TRUE` unless historical analysis is required.
- **JSONB:** The `title` column requires PostgreSQL-specific JSON operators (e.g., `->>`) for extraction in downstream transformations.