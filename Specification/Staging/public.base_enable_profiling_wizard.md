# base_enable_profiling_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention `base_enable_profiling_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and sequence-based primary keys are characteristic of Odoo's internal wizard and configuration models.

## Functional process 
This table supports the administrative profiling or diagnostic configuration process within the application. It tracks the lifecycle of profiling sessions or wizard-driven diagnostic tasks, likely used by system administrators to enable performance monitoring or feature-specific profiling for a limited duration.

## Description
One row represents a single instance of a profiling wizard configuration or diagnostic session. It captures the temporal bounds of the profiling task and the administrative users responsible for its creation and modification. This table serves as a raw landed copy of the Odoo model state within the Staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_enable_profiling_wizard_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| duration | VARCHAR | true | Duration of the profiling session | Likely stores a string representation of time (e.g., "1 hour"). |
| expiration | TIMESTAMP | true | Expiration timestamp of the session | Indicates when the profiling task should cease. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the application server. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the application server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record ownership.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timezone:** Timestamps (`create_date`, `write_date`, `expiration`) are typically stored in UTC in Odoo; verify against system configuration if local time conversion is required.
- **Data Integrity:** As a staging table, this may contain transient or incomplete records if the wizard process was interrupted.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely hard-deleted by the application.