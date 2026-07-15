# base_language_install

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`) and the use of PostgreSQL sequence-based defaults are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the localization and internationalization process within the ERP. It tracks the installation status and configuration of language packs, ensuring that the system knows which languages are available for the user interface and document generation.

## Description
One row in this table represents a single language installation event or configuration record within the system. It acts as a raw landed copy of the language installation state, capturing audit metadata such as who created or modified the record and whether existing translations should be overwritten.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the install record. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who initiated the language installation. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated this record. |
| overwrite | BOOLEAN | true | Overwrite flag | Indicates if existing translations should be replaced during the install. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of when the record was created; timezone is typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification; timezone is typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user accounts; ensure access is restricted if user identity is considered sensitive.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column), which is common in other Odoo tables; assume records are hard-deleted if missing.
- **Data Integrity:** As a staging table, verify if `overwrite` defaults to `false` in the application logic if nulls are encountered.