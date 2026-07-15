# crm_quotation_partner

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the primary key sequence (`crm_quotation_partner_id_seq`), the presence of `create_uid`/`write_uid` audit columns, and the `crm_` prefix common to Odoo's Customer Relationship Management module.

## Functional process 
This table supports the sales pipeline and partner management process by linking specific sales leads to associated partners (such as resellers, distributors, or agents) during the quotation phase. It tracks the history of interactions or assignments between leads and partners, likely used to calculate commissions or attribute sales performance.

## Description
One row in this table represents a single association or action record between a CRM lead and a partner entity. It serves as a raw, landed staging record capturing the audit trail of who created or modified the relationship and when, maintaining the grain of one event per lead-partner interaction.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_quotation_partner_id_seq`. |
| lead_id | INTEGER | false | Foreign key to the lead | Links to the CRM lead entity. |
| partner_id | INTEGER | true | Foreign key to the partner | Links to the partner/reseller entity. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| action | VARCHAR | false | Business action type | Describes the nature of the link or event. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Inferred from standard Odoo naming conventions).
    - `partner_id` → `res_partner.id` (Inferred from standard Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may map to internal employee tables; ensure appropriate access controls.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all records are active unless otherwise specified by the source system logic.
- **Data Quality:** `partner_id` is nullable, suggesting some lead-action records may exist without a direct partner assignment.