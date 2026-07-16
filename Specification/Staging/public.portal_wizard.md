# portal_wizard

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework application. The naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default value for the `id` column are characteristic patterns of the Odoo ORM.

## Functional process 
This table supports the configuration and state management of user-facing onboarding or setup wizards within the portal. It tracks the content of welcome messages and the audit trail of who created or modified the wizard configuration, facilitating the "User Onboarding" or "Portal Configuration" business process.

## Description
One row in this table represents a single instance or configuration of a portal wizard. It serves as a raw landed copy of the wizard's metadata and content, capturing the initial setup and subsequent updates made by system users.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `portal_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References the users table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the users table. |
| welcome_message | TEXT | true | Content of the wizard's welcome message | May contain HTML or plain text. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo naming for creator reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo naming for modifier reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` are internal system IDs; ensure they are joined against the appropriate user dimension to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** The `welcome_message` field is `TEXT` and may contain unformatted or legacy content; validate for injection or malformed strings if rendering in a UI.
- **Soft Deletes:** This table does not explicitly show a `deleted` or `active` flag; assume all records are currently active unless otherwise specified by business logic.