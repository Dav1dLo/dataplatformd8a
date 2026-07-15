# account_payment_method_line

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the financial accounting and payment processing module. It maps specific payment methods to their corresponding accounting journals or accounts, facilitating the automated reconciliation and posting of payment transactions within the general ledger.

## Description
One row in this table represents a single configuration line linking a payment method to a specific accounting journal or account. It serves as a raw landed copy of the Odoo configuration entity, capturing the sequence and association logic required for payment processing.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_payment_method_line_id_seq`. |
| sequence | INTEGER | true | Display or processing order | Used to determine priority if multiple lines exist. |
| payment_method_id | INTEGER | false | Foreign key to payment method | Links to the definition of the payment method. |
| payment_account_id | INTEGER | true | Foreign key to chart of accounts | The specific GL account associated with this method. |
| journal_id | INTEGER | true | Foreign key to accounting journal | The journal where payments are recorded. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| name | VARCHAR | true | Descriptive label | Human-readable name for the payment line. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |
| payment_provider_id | INTEGER | true | Foreign key to payment provider | Links to the external payment gateway configuration. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `payment_method_id` → `account_payment_method.id` (Evidence: standard Odoo naming convention for payment method associations).
    - `payment_account_id` → `account_account.id` (Evidence: standard Odoo naming convention for GL account links).
    - `journal_id` → `account_journal.id` (Evidence: standard Odoo naming convention for journal associations).
    - `payment_provider_id` → `payment_provider.id` (Evidence: standard Odoo naming convention for provider links).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Sensitive Data:** No direct PII is present, but `create_uid` and `write_uid` link to internal user records which may contain sensitive employee information.
- **Data Integrity:** As this is a staging table, it may contain historical versions or orphaned records if the source system performs soft deletes or maintains audit logs.
- **Type Precision:** `VARCHAR` length is not explicitly defined in the source metadata; downstream consumers should handle variable-length strings accordingly.