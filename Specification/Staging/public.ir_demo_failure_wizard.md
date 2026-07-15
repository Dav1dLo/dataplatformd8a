# ir_demo_failure_wizard

## Source system
This table originates from an Odoo ERP environment. The naming convention (`ir_` prefix, `_uid`, `_date` suffixes) and the use of `nextval` on a sequence for the primary key are characteristic of Odoo's internal registry (`ir` stands for "internal registry") and its standard ORM audit pattern.

## Functional process 
This table supports the "Failure Wizard" process, likely a UI-driven workflow for handling system errors, batch processing failures, or diagnostic reporting within the Odoo application. It tracks the lifecycle of these wizard instances, including who initiated the process and who last modified the record.

## Description
One row represents a single instance of a failure wizard session or diagnostic task. It serves as a raw landing record in the staging layer, capturing the audit trail of the wizard's creation and subsequent updates.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `ir_demo_failure_wizard_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure access controls are applied if mapping to PII in `res_users`.
- **Timezones:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have an `active` flag; assume records are hard-deleted if they disappear from the source.
- **Audit Fields:** `create_date` and `write_date` are system-generated; they may not reflect the actual business event time if the wizard was processed in a batch.