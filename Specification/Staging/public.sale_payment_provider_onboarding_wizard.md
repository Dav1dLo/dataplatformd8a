# sale_payment_provider_onboarding_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the primary key sequence (`public.sale_payment_provider_onboarding_wizard_id_seq`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the "Payment Provider Onboarding" business process, specifically capturing the configuration state of a wizard used to set up payment methods (such as PayPal or manual bank transfers) for sales transactions. It stores the temporary or persistent configuration details required to link a payment provider to a specific accounting journal.

## Description
One row in this table represents a single instance of a payment provider configuration session within the onboarding wizard. It serves as a staging entity that holds user-inputted credentials and settings before they are finalized and applied to the core accounting or sales modules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-incrementing values. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| payment_method | VARCHAR | true | Selected payment provider type | e.g., 'paypal', 'manual'. |
| paypal_email_account | VARCHAR | true | PayPal account email address | PII; sensitive data. |
| manual_name | VARCHAR | true | Display name for manual payment | Used for custom payment descriptions. |
| journal_name | VARCHAR | true | Associated accounting journal name | Links the provider to a specific ledger. |
| acc_number | VARCHAR | true | Bank account number | Sensitive financial data. |
| manual_post_msg | TEXT | true | Custom message for manual payments | Free-text field for payment instructions. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for record ownership).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains PII (`paypal_email_account`) and financial data (`acc_number`). Ensure appropriate masking or access controls are applied.
- **Timestamps:** All date fields are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Lifecycle:** This table acts as a wizard state store; rows may represent incomplete or transient onboarding sessions rather than finalized configuration records.
- **Nullability:** Most configuration fields are nullable, suggesting that different payment methods populate different subsets of columns.