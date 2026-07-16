# portal_wizard_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_partner` is the standard internal identifier for the "Partner" (customer/vendor/contact) model in Odoo, and `portal_wizard` typically refers to an Odoo transient model used for managing portal access invitations.

## Functional process 
This table supports the "Portal Access Management" process. It acts as a join table to associate specific portal wizard instances with the partners (users or contacts) who are being granted or managed for portal access, facilitating the batch invitation or configuration of external user accounts.

## Description
One row in this table represents a single association between a portal wizard session and a partner record. It serves as a raw, landing-layer link table used to maintain the many-to-many relationship required for portal access provisioning.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| portal_wizard_id | INTEGER | false | Foreign key to the portal wizard instance | Links to the parent wizard session. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Identifies the contact receiving portal access. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`portal_wizard_id`, `res_partner_id`).
- **Foreign keys (inferred):** 
    - `portal_wizard_id` → `portal_wizard.id` (Inferred from Odoo naming conventions).
    - `res_partner_id` → `res_partner.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** The combination of (`portal_wizard_id`, `res_partner_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a link table; expect no descriptive attributes other than the two foreign keys.
- There is no audit timestamp (e.g., `created_at`) present in this table; temporal analysis of when access was granted is not possible from this table alone.
- As a staging table, this may contain transient data that is truncated or cleared by the source system once the wizard process is completed.