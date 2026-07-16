# spreadsheet_dashboard

## Source system
The table likely originates from an Odoo ERP or a similar modular business application, given the naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for localized or multi-language fields like `name`.

## Functional process 
This table supports the configuration and management of dashboard layouts within a reporting or business intelligence module. It tracks the organizational grouping, sequencing, and publication status of dashboards, likely used to control user access and display order within the application interface.

## Description
Each row represents a single dashboard configuration entry, defining its metadata, display sequence, and publication status. As a staging table, it serves as a raw, direct reflection of the source system's dashboard definition entity, capturing the state of dashboard records at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.spreadsheet_dashboard_id_seq`. |
| dashboard_group_id | INTEGER | false | Foreign key to the dashboard group | Links the dashboard to a specific category or container. |
| sequence | INTEGER | true | Display order index | Used to sort dashboards in the UI. |
| company_id | INTEGER | true | Owning company identifier | Multi-tenant identifier for the record. |
| create_uid | INTEGER | true | Creator user ID | References the user who initially created the record. |
| write_uid | INTEGER | true | Last updater user ID | References the user who last modified the record. |
| sample_dashboard_file_path | VARCHAR | true | Path to dashboard template | Location of the underlying file or asset. |
| name | JSONB | false | Dashboard name | Likely contains localized strings; requires parsing. |
| is_published | BOOLEAN | true | Publication status | Flag indicating if the dashboard is visible to end users. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `dashboard_group_id` → `spreadsheet_dashboard_group.id` (Guess: standard Odoo-style naming convention for grouping entities).
    - `company_id` → `res_company.id` (Guess: standard Odoo-style naming for multi-company isolation).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo-style naming for user audit trails).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `create_uid` and `write_uid` columns link to user identities and should be handled according to internal privacy policies.
- **Timestamps:** Timestamps are assumed to be in the source system's local time or UTC; verify against the application server configuration.
- **JSONB Parsing:** The `name` column is stored as `JSONB`. Downstream queries will need to use the `->>` operator (e.g., `name->>'en_US'`) to extract specific values.
- **Soft Deletes:** This table does not explicitly show a `deleted_at` or `active` flag, though `is_published` may serve a similar functional purpose for visibility.