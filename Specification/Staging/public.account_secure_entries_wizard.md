# account_secure_entries_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys (`nextval` on a `_seq` object) are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the audit and security integrity process for financial or operational entries. It appears to be a wizard-based utility used to generate or verify cryptographic hashes for records, ensuring that entries (likely accounting or ledger entries) have not been tampered with over time.

## Description
One row in this table represents a single execution or configuration instance of a security hashing wizard for a specific company. It acts as a staging record for the audit trail of data integrity checks. This table serves as a raw landed copy of the wizard's state, used to track when and by whom security hashes were generated or updated.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the organization scope for the wizard. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| hash_date | DATE | false | Hashing reference date | The business date for which the security hash is calculated. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC; audit field. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC; audit field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo pattern for multi-company isolation).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined to a user directory to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployment practices.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely permanent audit logs.
- **Data Integrity:** As a "wizard" table, it may contain transient state data; verify if records are intended for long-term analytical use or if they are purely operational logs.