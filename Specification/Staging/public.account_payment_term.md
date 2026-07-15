# account_payment_term

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `JSONB` for translatable fields, and the sequence-based ID) is characteristic of the Odoo ORM framework used for managing financial configuration data.

## Functional process 
This table supports the "Order-to-Cash" and "Procure-to-Pay" business processes by defining the payment terms available for invoices and vendor bills. It governs the logic for due dates and early payment discounts, which are applied during the generation of financial documents.

## Description
One row in this table represents a single payment term configuration, such as "Net 30" or "2% 10, Net 30". It serves as a raw landed copy of the Odoo `account.payment.term` model, capturing the structural rules for calculating payment deadlines and associated discount incentives.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `account_payment_term_id_seq`. |
| company_id | INTEGER | true | Foreign key to the owning company | Links to the multi-company configuration. |
| sequence | INTEGER | false | Display order | Used to sort terms in UI dropdowns. |
| discount_days | INTEGER | true | Days allowed for early discount | Number of days from invoice date to qualify for discount. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| early_pay_discount_computation | VARCHAR | true | Discount calculation method | Defines how the discount is applied (e.g., 'fixed', 'percentage'). |
| name | JSONB | false | Payment term name | Multilingual label for the payment term. |
| note | JSONB | true | Description/Note | Multilingual text displayed on invoices. |
| active | BOOLEAN | true | Soft-delete flag | If false, the term is hidden from selection. |
| display_on_invoice | BOOLEAN | true | Visibility toggle | Determines if the term is printed on the invoice. |
| early_discount | BOOLEAN | true | Early discount enabled | Flag indicating if early payment incentives are active. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| discount_percentage | DOUBLE PRECISION | true | Discount rate | The percentage value applied for early payment. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Inferred based on Odoo standard multi-company architecture).
    - `create_uid` → `res_users.id` (Inferred based on Odoo standard audit fields).
    - `write_uid` → `res_users.id` (Inferred based on Odoo standard audit fields).
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Sensitive Data:** No PII or financial transaction data, but contains configuration metadata.
- **Timezones:** Timestamps (`create_date`, `write_date`) are stored in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` unless historical analysis is required.
- **JSONB Fields:** The `name` and `note` columns are `JSONB` types; downstream consumers will need to use the `->>` operator (e.g., `name->>'en_US'`) to extract specific language values.
- **Data Pattern:** This is a raw staging table; expect Odoo-specific internal IDs that may not be human-readable without joining to reference tables.