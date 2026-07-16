# spreadsheet_dashboard_share

## Source system
This table originates from an Odoo ERP or a similar modular business application framework. The naming convention of `create_uid`, `write_uid`, and `*_date` columns, combined with the use of `nextval` sequences for primary keys, is characteristic of the Odoo ORM metadata pattern.

## Functional process 
This table supports the "Dashboard Sharing" or "External Reporting" process. It manages the generation and tracking of secure access tokens that allow external users or systems to view specific dashboard instances without requiring full authenticated access to the core platform.

## Description
One row in this table represents a unique share configuration or access link for a specific dashboard. It serves as a raw landing record in the staging layer, capturing the audit trail of who created or modified the share link and the associated security token.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.spreadsheet_dashboard_share_id_seq`. |
| dashboard_id | INTEGER | false | Foreign key to the dashboard | Identifies the dashboard being shared. |
| create_uid | INTEGER | true | User ID of the creator | References the system user who generated the share link. |
| write_uid | INTEGER | true | User ID of the last modifier | References the system user who last updated the share settings. |
| access_token | VARCHAR | false | Security token | The unique string used to authorize access to the dashboard. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `dashboard_id` → `spreadsheet_dashboard.id` (Inferred from naming convention common in Odoo-like schemas).
    - `create_uid` → `res_users.id` (Inferred from standard Odoo `*_uid` naming patterns).
    - `write_uid` → `res_users.id` (Inferred from standard Odoo `*_uid` naming patterns).
- **Natural keys (inferred):** 
    - `access_token` (Likely acts as the unique business identifier for the share link).

## Caveats for downstream consumers

- **Sensitive Data:** The `access_token` column should be treated as a secret; ensure it is masked or excluded in reporting environments accessible to unauthorized users.
- **Timezone:** Timestamps are typically stored in UTC by the Odoo framework, but verify against the application configuration.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows are active unless a secondary lookup table indicates otherwise.
- **Data Integrity:** `create_uid` and `write_uid` may be null if the record was created via a system process rather than a specific user action.