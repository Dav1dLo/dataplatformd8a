# payment_method

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of `nextval` sequences and `JSONB` for localized names, is highly characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the payment processing and checkout configuration pipeline. It defines the available payment methods (e.g., credit card, bank transfer, digital wallets) and their specific capabilities, such as whether they support refunds, tokenization for recurring billing, or express checkout flows.

## Description
One row in this table represents a single payment method configuration available within the application. It acts as a raw landed copy of the system's payment provider definitions, capturing both the operational metadata and the functional capabilities of each method.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.payment_method_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort methods in the UI. |
| primary_payment_method_id | INTEGER | true | Parent payment method reference | Self-referencing FK for grouping methods. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| code | VARCHAR | false | Internal system code | Unique identifier for the payment provider. |
| support_refund | VARCHAR | false | Refund capability flag | Likely stores a string-based status or capability code. |
| name | JSONB | false | Display name | Multilingual name stored as a JSON object. |
| active | BOOLEAN | true | Soft-delete flag | If false, the payment method is hidden from the UI. |
| support_tokenization | BOOLEAN | true | Tokenization support | Indicates if the method supports saved payment tokens. |
| support_express_checkout | BOOLEAN | true | Express checkout support | Indicates if the method supports one-click checkout. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `primary_payment_method_id` → `public.payment_method.id`: References a parent payment method for hierarchical grouping.
    - `create_uid` → `public.res_users.id` (guess): Standard Odoo pattern for tracking record ownership.
    - `write_uid` → `public.res_users.id` (guess): Standard Odoo pattern for tracking record modification.
- **Natural keys (inferred):** 
    - `code`: The internal system code is typically unique per provider implementation.

## Caveats for downstream consumers

- **PII/Sensitive Data:** No direct PII, but `create_uid` and `write_uid` link to internal user identities.
- **Timestamps:** Assumed to be in UTC; verify against application server settings if precision is critical.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` to retrieve only currently enabled methods.
- **JSONB:** The `name` column contains JSON; use PostgreSQL `->>` operator to extract text values (e.g., `name->>'en_US'`).
- **Data Precision:** `VARCHAR` lengths are not explicitly defined in the metadata; assume standard variable length and handle potential truncation if mapping to fixed-width downstream systems.