# account_reconcile_model_res_partner_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `_rel` combined with the specific entity names `account_reconcile_model` and `res_partner` is characteristic of Odoo's automated many-to-many relationship tables generated for ORM models.

## Functional process 
This table supports the automated bank reconciliation process. It maps specific reconciliation models (which define rules for matching bank statement lines to journal items) to specific business partners (customers or vendors), restricting the applicability of those models to transactions involving those partners.

## Description
One row in this table represents a single association between a reconciliation model and a partner. It serves as a raw landing copy of the many-to-many join table used to filter reconciliation logic by partner.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_reconcile_model_id | INTEGER | false | Foreign key to the reconciliation model definition. | Links to the primary key of the reconciliation model table. |
| res_partner_id | INTEGER | false | Foreign key to the partner (customer/vendor) definition. | Links to the primary key of the res_partner table. |

## Keys

- **Primary key (inferred):** The composite of (`account_reconcile_model_id`, `res_partner_id`).
- **Foreign keys (inferred):** 
    - `account_reconcile_model_id` → `account_reconcile_model.id`: This column references the configuration entity for reconciliation rules.
    - `res_partner_id` → `res_partner.id`: This column references the master data entity for business partners.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading must rely on the source system's transaction logs or full-table snapshots.
- Ensure that joins to this table are handled as a composite key to avoid fan-out issues in downstream models.