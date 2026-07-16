# res_currency_rate

## Source system
This table originates from Odoo ERP. The naming convention `res_currency_rate` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and sequence-based primary keys are characteristic of the Odoo `res.currency.rate` model.

## Functional process 
This table supports the multi-currency accounting and financial reporting process. It maintains the historical exchange rates used to convert transaction amounts into the company's base currency, allowing the system to calculate valuations across different reporting periods.

## Description
One row in this table represents a specific exchange rate for a given currency on a specific date. It serves as a raw landing copy of the Odoo currency rate configuration, providing the necessary historical data points to perform currency conversion calculations in downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| currency_id | INTEGER | false | Foreign key to currency | References the currency being defined. |
| company_id | INTEGER | true | Foreign key to company | Optional; if null, the rate may be global. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | References the user who last modified the record. |
| name | DATE | false | Rate effective date | The date for which this exchange rate is valid. |
| rate | NUMERIC | true | Exchange rate value | The conversion factor relative to the base currency. |
| create_date | TIMESTAMP | true | Record creation timestamp | Ingestion/creation time in UTC. |
| write_date | TIMESTAMP | true | Record modification timestamp | Last update time in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id`: This column links to the master currency definition table.
    - `company_id` → `res_company.id`: This column links to the specific company entity if the rate is company-scoped.
- **Natural keys (inferred):** 
    - `(currency_id, name, company_id)`: The combination of currency, date, and company scope typically defines a unique rate entry in Odoo.

## Caveats for downstream consumers

- **Sensitive Data:** No PII or financial secrets are present; however, internal user IDs (`create_uid`, `write_uid`) are exposed.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** The `rate` column is `NUMERIC` without defined precision; downstream consumers should cast this to a fixed-point type (e.g., `NUMERIC(18, 6)`) to avoid floating-point errors during currency conversion.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically managed via standard CRUD operations in the source.