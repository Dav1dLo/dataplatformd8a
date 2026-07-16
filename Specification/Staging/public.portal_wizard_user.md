# portal_wizard_user

## Source system
The table likely originates from an Odoo ERP instance, indicated by the naming convention `portal_wizard_user` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, alongside the use of PostgreSQL sequence-based primary keys.

## Functional process 
This table supports the customer portal onboarding or configuration process, specifically tracking which users or partners are associated with specific wizard-driven workflows. It acts as a join or configuration table linking partners to specific portal wizard instances.

## Description
One row in this table represents a single association between a portal wizard instance and a specific partner or user. It serves as a raw landed copy of the staging data, capturing the state of wizard-user assignments at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.portal_wizard_user_id_seq`. |
| wizard_id | INTEGER | false | Foreign key to the portal wizard | Links to the specific wizard definition. |
| partner_id | INTEGER | false | Foreign key to the partner | Identifies the partner associated with the wizard. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user table. |
| email | VARCHAR | true | Contact email address | Likely used for notifications or portal access. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `portal_wizard.id` (Guess: links to the parent wizard definition).
    - `partner_id` → `res_partner.id` (Guess: standard Odoo pattern for partner associations).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII:** The `email` column contains personally identifiable information and should be masked in non-production environments.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a dedicated `active` or `deleted_at` flag; assume all records are active unless otherwise specified by business logic.
- **Data Integrity:** As a staging table, ensure that `wizard_id` and `partner_id` are validated against their respective master tables before joining in downstream models.