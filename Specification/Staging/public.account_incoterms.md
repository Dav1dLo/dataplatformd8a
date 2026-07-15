# account_incoterms

## Source system
This table originates from an Odoo ERP system, evidenced by the characteristic naming convention of `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for localized field values (common in Odoo's multi-language support).

## Functional process 
This table supports the logistics and supply chain management process by defining International Commercial Terms (Incoterms). These codes dictate the responsibilities of buyers and sellers regarding shipping, insurance, and risk transfer during international trade transactions.

## Description
One row in this table represents a single Incoterm definition (e.g., FOB, CIF, EXW) used within the ERP system. It serves as a raw landing copy of the master data table, capturing the unique code, its localized description, and audit metadata for tracking record lifecycle.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| create_uid | INTEGER | true | User ID who created the record | References the users table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the users table. |
| code | VARCHAR(3) | false | Standard 3-letter Incoterm code | e.g., 'FOB', 'CIF'. |
| name | JSONB | false | Localized name/description | Contains language-specific strings. |
| active | BOOLEAN | true | Soft-delete status | False indicates the term is archived. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** 
    - `code` (The 3-letter Incoterm code is the unique business identifier).

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified; this is master reference data.
- **Timestamps:** Assumed to be in UTC as per standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless historical analysis is required.
- **JSONB Handling:** The `name` column requires PostgreSQL JSONB operators (e.g., `name->>'en_US'`) to extract specific language values.