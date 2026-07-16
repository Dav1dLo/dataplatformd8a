# payment_token

## Source system
The table likely originates from an Odoo ERP or a similar modular business management system, evidenced by the presence of `create_uid`, `write_uid`, `create_date`, and `write_date` audit columns, which are standard patterns in Odoo's ORM layer.

## Functional process 
This table supports the payment processing and subscription billing pipeline by managing secure references to external payment gateways. It links internal company or partner entities to specific payment methods and their corresponding provider-side tokens, facilitating recurring billing and automated transaction processing.

## Description
One row in this table represents a single payment token or instrument stored within a third-party payment provider, associated with a specific partner or company. This is a raw staging table containing a direct copy of the source system's payment token records, serving as the foundation for downstream payment reconciliation and financial reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| provider_id | INTEGER | false | Payment provider identifier | Foreign key to the payment provider configuration. |
| company_id | INTEGER | true | Company identifier | Links the token to a specific business entity. |
| payment_method_id | INTEGER | false | Payment method identifier | Links the token to a specific payment method type. |
| partner_id | INTEGER | false | Partner identifier | The customer or entity owning the payment token. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| payment_details | VARCHAR | true | Masked payment info | Likely contains JSON or stringified details about the card/method. |
| provider_ref | VARCHAR | false | External provider reference | The unique token ID issued by the payment gateway. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the token is currently enabled for use. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `provider_id` → `payment_provider.id` (Inferred from naming convention).
    - `partner_id` → `res_partner.id` (Inferred from standard Odoo schema patterns).
    - `company_id` → `res_company.id` (Inferred from standard Odoo schema patterns).
- **Natural keys (inferred):** 
    - `provider_ref` (The unique identifier provided by the external gateway).

## Caveats for downstream consumers

- **Sensitive Data:** The `payment_details` column may contain sensitive information; ensure appropriate masking or access control is applied.
- **Timezone:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` to retrieve only currently valid tokens.
- **Data Precision:** `VARCHAR` lengths were not explicitly defined in the source metadata; downstream systems should handle variable-length strings accordingly.