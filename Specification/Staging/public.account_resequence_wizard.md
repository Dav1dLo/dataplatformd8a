# account_resequence_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence for the `id` column are characteristic of Odoo's ORM-generated tables.

## Functional process 
This table supports a UI-driven administrative process for reordering or resequencing account-related records. It acts as a temporary state holder or "wizard" object used to capture user inputs—such as names, ordering logic, and date ranges—before applying changes to the core accounting or customer master data.

## Description
One row in this table represents a single execution instance of the account resequencing wizard. It serves as a raw landing copy of the wizard's configuration state, capturing the parameters defined by a user during a specific session.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the wizard session. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the wizard state. |
| first_name | VARCHAR | false | Name parameter | The primary name or identifier used for the resequencing logic. |
| ordering | VARCHAR | false | Sort order configuration | Defines the sequence logic (e.g., 'asc', 'desc') applied to the accounts. |
| first_date | DATE | true | Start date filter | The beginning of the date range for the resequencing operation. |
| end_date | DATE | true | End date filter | The end of the date range for the resequencing operation. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp of when the wizard session was initialized. |
| write_date | TIMESTAMP | true | Record modification timestamp | Timestamp of the last update to the wizard session. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure access controls are applied if these are joined to user metadata.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Persistence:** As a "wizard" table, rows may be transient or subject to cleanup routines; do not treat this as a permanent system-of-record for accounting data.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; assume standard variable length handling.