# portal_wizard_user

## Source system
This table originates from an Odoo ERP system. The naming convention (`portal_wizard_user`), the presence of `create_uid`, `write_uid`, `create_date`, and `write_date` audit columns, and the use of `nextval` sequences for primary keys are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the customer portal management process, specifically tracking which partners (contacts) are associated with specific portal wizard configurations. It facilitates the invitation or access management flow where users are granted access to the portal via a wizard interface.

## Description
One row in this table represents a single association between a portal wizard instance and a specific partner (user). It serves as a raw landed copy of the Odoo `portal.wizard.user` model, capturing the state of portal access assignments at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.portal_wizard_user_id_seq`. |
| wizard_id | INTEGER | false | Foreign key to the parent wizard | Links to the `portal_wizard` table. |
| partner_id | INTEGER | false | Foreign key to the partner | Links to the `res_partner` table. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users`. |
| email | VARCHAR | true | Contact email address | Used for portal invitation/access. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `portal_wizard.id`: Links the user association to its parent wizard configuration.
    - `partner_id` → `res_partner.id`: Identifies the specific contact/partner being granted portal access.
    - `create_uid` / `write_uid` → `res_users.id`: Identifies the internal system users responsible for the record lifecycle.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `email` column contains PII and should be handled according to data privacy policies.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD behavior where rows are removed upon deletion in the source.
- **Data Integrity:** As a staging table, this data is a direct reflection of the source; verify the existence of referenced `partner_id` and `wizard_id` records in their respective master tables before performing joins.