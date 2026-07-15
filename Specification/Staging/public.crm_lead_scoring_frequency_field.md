# crm_lead_scoring_frequency_field

## Source system
This table originates from an Odoo ERP or CRM system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of the Odoo ORM framework's standard audit and tracking columns.

## Functional process 
This table supports the lead scoring configuration process, specifically managing the frequency settings for fields used in lead scoring models. It acts as a join or configuration table that links specific fields to scoring frequency parameters, ensuring that lead scores are recalculated or updated based on defined business cadences.

## Description
One row in this table represents a specific configuration entry linking a field to a scoring frequency rule. It serves as a raw landed copy of the Odoo configuration entity, capturing the audit trail and identity of the record within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_lead_scoring_frequency_field_id_seq`. |
| field_id | INTEGER | false | Foreign key to the field definition | Identifies the specific field being configured for scoring. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated this configuration. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified this configuration. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC; audit timestamp from the source system. |
| write_date | TIMESTAMP | true | Record last update timestamp | Inferred UTC; audit timestamp from the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `field_id → ir_model_fields.id`: This column likely references the standard Odoo model field registry.
    - `create_uid → res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid → res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit Columns:** `create_uid` and `write_uid` are internal system IDs; they will not resolve to meaningful names without joining to the `res_users` table.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Data Integrity:** As a staging table, ensure that `field_id` is validated against the master field registry before performing joins in downstream models.