# crm_lead_scoring_frequency_field

## Source system
This table originates from an Odoo ERP or CRM system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the lead scoring configuration process, specifically managing the frequency settings for fields used in lead scoring models. It tracks which fields are monitored for frequency-based scoring updates and maintains the audit trail for those configuration records.

## Description
One row in this table represents a specific field configuration entry within a lead scoring frequency rule. It serves as a raw landed copy of the Odoo configuration table, capturing the metadata and audit history for field-level scoring parameters.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `crm_lead_scoring_frequency_field_id_seq`. |
| field_id | INTEGER | false | Reference to the field being scored | Likely links to an `ir_model_fields` table. |
| create_uid | INTEGER | true | User ID who created the record | Links to the system's user directory. |
| write_uid | INTEGER | true | User ID who last updated the record | Links to the system's user directory. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
    - `field_id` → `ir_model_fields.id` (Standard Odoo pattern for referencing system fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names; no direct PII is present.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a soft-delete flag (e.g., `active` column); assume all records are current unless otherwise specified by the source system logic.
- **Audit Fields:** `create_date` and `write_date` should be used for incremental loading strategies.