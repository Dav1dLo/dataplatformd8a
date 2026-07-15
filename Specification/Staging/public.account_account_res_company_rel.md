# account_account_res_company_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `model_a_model_b_rel` is the standard pattern used by the Odoo ORM to manage many-to-many relationship tables between two entities (in this case, `account.account` and `res.company`).

## Functional process 
This table supports multi-company accounting configurations. It defines the mapping between specific financial accounts and the companies that are authorized to use or view them within the ERP, ensuring proper data segregation in a multi-tenant or multi-subsidiary environment.

## Description
One row in this table represents a single association between a financial account and a company. It acts as a join table to facilitate many-to-many relationships, allowing an account to be shared across multiple companies or a company to access a specific set of accounts. This is a raw landing of the association table from the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_account_id | INTEGER | false | Foreign key to the account definition | References `account_account.id`. |
| res_company_id | INTEGER | false | Foreign key to the company definition | References `res_company.id`. |

## Keys

- **Primary key (inferred):** The composite of (`account_account_id`, `res_company_id`).
- **Foreign keys (inferred):** 
    - `account_account_id` → `account_account.id`: Links to the master account definition.
    - `res_company_id` → `res_company.id`: Links to the master company definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no surrogate primary key; joins should be performed on the composite key.
- As a join table, it does not contain descriptive attributes, only the relationship mapping.
- Ensure that downstream queries filter by the relevant `res_company_id` if the reporting scope is restricted to a single legal entity.