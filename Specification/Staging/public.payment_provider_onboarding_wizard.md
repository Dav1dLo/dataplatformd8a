# payment_provider_onboarding_wizard

## Source system
The table likely originates from an Odoo ERP instance, indicated by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the "Payment Provider Configuration" business process. It acts as a temporary state-tracking mechanism for the onboarding wizard used to configure various payment gateways (e.g., PayPal, manual bank transfers) within the accounting or e-commerce module.

## Description
One row represents a single instance of a payment provider onboarding session initiated by a user. It captures the configuration parameters and credentials required to set up a specific payment method. As a staging table, it serves as a raw landed copy of the wizard's state before the data is persisted into the core payment provider configuration entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user table. |
| payment_method | VARCHAR | true | Type of payment provider being configured | e.g., 'paypal', 'manual'. |
| paypal_email_account | VARCHAR | true | PayPal account email address | Sensitive PII; used for PayPal integration. |
| manual_name | VARCHAR | true | Display name for manual payment method | Used for bank transfer descriptions. |
| journal_name | VARCHAR | true | Associated accounting journal name | Links the provider to a specific ledger. |
| acc_number | VARCHAR | true | Bank account number | Used for manual payment configurations. |
| manual_post_msg | TEXT | true | Custom message for payment confirmation | Displayed to the end customer. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `paypal_email_account` and `acc_number`, which are PII/financial data and should be masked in non-production environments.
- **Timestamps:** Assumed to be in UTC; verify against system configuration if precision to the millisecond is required.
- **Data Lifecycle:** This table represents a wizard state; rows may be transient or represent incomplete onboarding attempts.
- **Schema:** The table uses a sequence for the `id` column; ensure downstream ingestion handles the `nextval` logic if performing manual inserts.