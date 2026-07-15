# base_partner_merge_automatic_wizard_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `base_partner_merge_automatic_wizard_res_partner_rel` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link wizard execution instances with the specific partner records being processed during a merge operation.

## Functional process 
This table supports the data cleansing and deduplication process within the CRM/Partner management module. It tracks which specific partner records (`res_partner`) are associated with a particular automated merge wizard session (`base_partner_merge_automatic_wizard`), facilitating the identification of duplicate records slated for consolidation.

## Description
One row represents a single association between a specific merge wizard execution and a partner record involved in that merge. It serves as a raw landing of the join table used by the Odoo framework to manage the state of batch deduplication tasks.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| base_partner_merge_automatic_wizard_id | INTEGER | false | Foreign key to the merge wizard instance. | Links to the specific deduplication job. |
| res_partner_id | INTEGER | false | Foreign key to the partner record. | The specific contact or company record being merged. |

## Keys

- **Primary key (inferred):** The combination of `base_partner_merge_automatic_wizard_id` and `res_partner_id` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `base_partner_merge_automatic_wizard_id` → `base_partner_merge_automatic_wizard.id` (Inferred from Odoo naming conventions for wizard models).
    - `res_partner_id` → `res_partner.id` (Standard Odoo foreign key pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a technical join table; it does not contain business logic or timestamps, only relational mappings.
- There are no sensitive PII columns in this table, as it only contains integer identifiers.
- The table is likely truncated or cleared by the Odoo framework once the merge wizard completes its execution; expect high volatility in row counts.
- Ensure joins to `res_partner` are handled as inner joins if you only require records currently involved in active merge processes.