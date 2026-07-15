# account_reconcile_model_res_partner_category_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `account_reconcile_model` and `res_partner_category` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link reconciliation models with partner categories.

## Functional process 
This table supports the automated bank reconciliation process. It defines which partner categories are associated with specific reconciliation models, allowing the system to filter or suggest reconciliation rules based on the category of the business partner involved in a transaction.

## Description
One row in this table represents a single association between a reconciliation model and a partner category. It serves as a raw landing copy of the join table from the source database, maintaining the many-to-many relationship required for reconciliation logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_reconcile_model_id | INTEGER | false | Foreign key to the reconciliation model | Links to the parent reconciliation rule definition. |
| res_partner_category_id | INTEGER | false | Foreign key to the partner category | Links to the category assigned to business partners. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(account_reconcile_model_id, res_partner_category_id)`.
- **Foreign keys (inferred):** 
    - `account_reconcile_model_id` → `account_reconcile_model.id`: This column links to the primary reconciliation model definition.
    - `res_partner_category_id` → `res_partner_category.id`: This column links to the definition of the partner category.
- **Natural keys (inferred):** The combination of `(account_reconcile_model_id, res_partner_category_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; it is a pure structural mapping.
- Ensure that joins to the target tables handle potential missing records if the source system has experienced partial data ingestion.