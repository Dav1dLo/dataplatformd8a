# portal_wizard

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework, as evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo models, alongside the use of `nextval` on a sequence for the primary key.

## Functional process 
This table supports the configuration and management of user-facing portal onboarding or setup wizards. It tracks the content of welcome messages and the administrative users responsible for creating or updating these wizard configurations within the application's portal management module.

## Description
One row in this table represents a single instance of a portal wizard configuration. It serves as a raw landed copy of the application's wizard settings, capturing the welcome message text and the associated audit trail for record creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.portal_wizard_id_seq` for auto-increment. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system's user table. |
| welcome_message | TEXT | true | Content of the wizard's welcome message | Stores the display text shown to users. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `welcome_message` column may contain arbitrary text; ensure it is scanned for PII if exposed to non-privileged users.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard PostgreSQL/Odoo practices.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume records are hard-deleted if they disappear from the source.
- **Audit Fields:** `create_uid` and `write_uid` are likely internal system IDs and may not be human-readable without joining to a user directory table.