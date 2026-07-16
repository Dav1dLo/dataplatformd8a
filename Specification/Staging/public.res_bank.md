# res_bank

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`res_bank`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value pattern (`nextval('"public".res_bank_id_seq'::regclass)`).

## Functional process 
This table supports the master data management of financial institutions within the ERP. It maintains a registry of banks used for processing payments, managing vendor/customer bank accounts, and facilitating bank reconciliation processes.

## Description
One row in this table represents a single bank entity or financial institution registered in the system. It serves as a raw landed copy of the Odoo `res.bank` model, capturing contact details, location, and the Bank Identifier Code (BIC).

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; internal Odoo ID. |
| state | INTEGER | true | Foreign key to state/province | References `res_country_state` table. |
| country | INTEGER | true | Foreign key to country | References `res_country` table. |
| create_uid | INTEGER | true | Creator user ID | References `res_users` table. |
| write_uid | INTEGER | true | Last modifier user ID | References `res_users` table. |
| name | VARCHAR | false | Bank name | Display name of the financial institution. |
| street | VARCHAR | true | Street address | Primary address line. |
| street2 | VARCHAR | true | Street address line 2 | Secondary address line. |
| zip | VARCHAR | true | Postal code | |
| city | VARCHAR | true | City name | |
| email | VARCHAR | true | Contact email | |
| phone | VARCHAR | true | Phone number | |
| bic | VARCHAR | true | Bank Identifier Code | SWIFT/BIC code for international transfers. |
| active | BOOLEAN | true | Soft-delete flag | If false, the bank is archived/hidden. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `state` → `res_country_state.id` (Standard Odoo relational pattern).
    - `country` → `res_country.id` (Standard Odoo relational pattern).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `bic` (While not strictly enforced as unique in all Odoo versions, it is the business identifier for banks).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column is used for soft deletes. Queries should generally filter by `WHERE active = TRUE` unless historical/archived data is required.
- **Sensitive Data:** Contains contact information (`email`, `phone`, `street`) which may be subject to GDPR or other privacy regulations.
- **Timestamps:** `create_date` and `write_date` are stored in the database timezone (typically UTC in Odoo deployments).
- **Data Quality:** `VARCHAR` fields in Odoo are often unbounded; expect varying string lengths.