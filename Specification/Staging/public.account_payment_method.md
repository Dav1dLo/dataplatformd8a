# account_payment_method

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized fields are characteristic of Odoo's ORM-to-PostgreSQL mapping.

## Functional process 
This table supports the financial configuration and payment processing pipeline. It defines the available payment methods (e.g., bank transfer, credit card, cash) that can be associated with invoices or customer accounts, ensuring that the system knows how to categorize incoming or outgoing funds.

## Description
One row in this table represents a single payment method configuration available within the system. It serves as a raw landed copy of the Odoo `account.payment.method` model, acting as a lookup table for downstream financial transactions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.account_payment_method_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users` table. |
| code | VARCHAR | false | Internal system code | Used for programmatic identification of the payment method. |
| payment_type | VARCHAR | false | Payment category | Defines if the method is for inbound or outbound payments. |
| name | JSONB | false | Display name | Multilingual label for the payment method. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming convention for audit fields).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming convention for audit fields).
- **Natural keys (inferred):** 
    - `code` (The internal system code is typically unique per payment method type).

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but `name` (JSONB) may contain internal business terminology.
- **Timestamps:** Assumed to be in UTC as per standard Odoo/PostgreSQL deployment practices.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are currently active unless filtered by business logic.
- **JSONB:** The `name` column requires extraction (e.g., `name->>'en_US'`) for standard reporting tools that do not support JSONB natively.