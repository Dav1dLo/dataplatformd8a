# account_setup_bank_manual_config

## Source system
This table originates from an Odoo ERP environment. The naming convention (e.g., `res_partner_bank_id`, `create_uid`, `write_uid`, `_seq` sequences) is characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the bank account configuration and journal setup process within the accounting module. It tracks manual configurations for bank journals, linking specific bank partner records (`res_partner_bank_id`) to new journal names (`new_journal_name`) and tracking the count of journals pending account assignment.

## Description
One row represents a single manual bank journal configuration event linked to a partner bank record. This table serves as a raw landing copy of the Odoo model `account.setup.bank.manual.config`, capturing the state of manual bank setups at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.account_setup_bank_manual_config_id_seq`. |
| res_partner_bank_id | INTEGER | false | Foreign key to bank partner | Links to the `res_partner_bank` table. |
| num_journals_without_account | INTEGER | true | Count of journals | Number of journals created without an associated account. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| new_journal_name | VARCHAR | false | Journal name | The name assigned to the new bank journal. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last record update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `res_partner_bank_id` → `res_partner_bank.id` (Inferred from Odoo naming convention `res_partner_bank_id`).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The table contains user IDs (`create_uid`, `write_uid`) which may link to sensitive employee or user information in other tables.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo, but verify against the application server configuration.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are active unless otherwise specified by Odoo's internal logic.
- **Data Precision:** The `VARCHAR` type for `new_journal_name` does not specify a length; downstream consumers should account for potential truncation if mapping to fixed-width fields.