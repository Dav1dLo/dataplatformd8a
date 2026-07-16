# privacy_lookup_wizard_line

## Source system
This table originates from an Odoo ERP system, evidenced by the naming convention (`res_model`, `res_id`, `create_uid`, `write_uid`) and the use of standard Odoo sequence generators for the primary key.

## Functional process 
This table supports the data privacy and GDPR compliance module within the ERP, specifically tracking the lines associated with a "Privacy Lookup Wizard." It logs the specific records (`res_id` and `res_model`) that have been processed or flagged during a privacy lookup or data cleanup operation.

## Description
One row represents a single line item within a privacy lookup wizard session, detailing a specific record that was evaluated for privacy compliance. It serves as a raw staging record capturing the state of a resource at the time of the wizard's execution, including flags for activity and unlinking status.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.privacy_lookup_wizard_line_id_seq`. |
| wizard_id | INTEGER | true | Foreign key to the parent wizard | Links to the main privacy wizard session. |
| res_id | INTEGER | false | Resource ID | The ID of the record being processed. |
| res_model_id | INTEGER | true | Model ID | Foreign key to the ir.model table. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated this line. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this line. |
| res_name | VARCHAR | true | Resource display name | Human-readable name of the target record. |
| res_model | VARCHAR | true | Model technical name | The technical name of the model (e.g., 'res.partner'). |
| execution_details | VARCHAR | true | Execution log/details | Textual description of the privacy lookup result. |
| has_active | BOOLEAN | true | Has active field | Indicates if the model supports an 'active' field. |
| is_active | BOOLEAN | true | Active status | The current active state of the target record. |
| is_unlinked | BOOLEAN | true | Unlinked status | Flag indicating if the record has been unlinked. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `privacy_lookup_wizard.id` (Guess: links to the parent wizard session).
    - `res_model_id` → `ir_model.id` (Guess: standard Odoo reference to the model definition).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `res_name` and `execution_details` columns may contain PII or sensitive business data depending on the model being audited.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table appears to be an audit/log of a process; it does not explicitly implement a soft-delete pattern, though `is_unlinked` acts as a business-logic flag for record state.
- **Data Precision:** `VARCHAR` columns do not have defined lengths in the metadata; downstream systems should be prepared for variable-length strings.