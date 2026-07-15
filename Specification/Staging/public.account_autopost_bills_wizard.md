# account_autopost_bills_wizard

## Source system
This table originates from Odoo (OpenERP), as evidenced by the naming convention `wizard` (a common Odoo pattern for transient UI-driven processes), the `create_uid`/`write_uid` audit columns, and the sequence-based `id` default.

## Functional process 
This table supports the automated billing or invoice processing workflow. It tracks the state of a "wizard" or background job that identifies and processes bills for specific partners, specifically tracking the count of unmodified bills that may require manual intervention or batch processing.

## Description
One row represents a single execution or session of the "autopost bills" wizard process. It acts as a transient staging record for the configuration and status of a batch operation, capturing which partner is being processed and the count of bills affected.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_autopost_bills_wizard_id_seq`. |
| partner_id | INTEGER | true | Foreign key to the partner | References the business entity associated with the bills. |
| nb_unmodified_bills | INTEGER | true | Count of bills | Number of bills that remained unmodified during the wizard run. |
| create_uid | INTEGER | true | Creator user ID | References the system user who initiated the wizard. |
| write_uid | INTEGER | true | Last updater user ID | References the system user who last modified the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the wizard session was initialized. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Guess: standard Odoo naming convention for partner references).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid`, which link to internal user IDs; ensure these are mapped to user dimensions rather than exposed directly.
- **Timezone:** Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo; verify against system configuration.
- **Data Persistence:** As a "wizard" table, this may contain transient data that is periodically purged or truncated by the application; do not rely on this for long-term historical reporting.
- **Nullability:** Most fields are nullable, suggesting that wizard sessions may be partially initialized or abandoned before completion.