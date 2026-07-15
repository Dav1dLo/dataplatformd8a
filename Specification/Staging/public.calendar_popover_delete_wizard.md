# calendar_popover_delete_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the UI-driven deletion workflow within the calendar module. It acts as a transient or wizard-state table that tracks user-initiated deletion requests for specific calendar records, likely managing the state or confirmation logic before a record is permanently removed from the system.

## Description
One row in this table represents a single instance of a "delete wizard" session triggered by a user in the calendar interface. It serves as a raw landing copy of the wizard's state, capturing which record is being targeted for deletion and the audit trail of the wizard's creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `calendar_popover_delete_wizard_id_seq`. |
| record | INTEGER | true | Target record ID | The ID of the calendar entry being processed for deletion. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the wizard state. |
| delete | VARCHAR | true | Deletion flag or status | Likely stores a status string or confirmation flag for the deletion process. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the ingestion job; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table appears to be a transient wizard state; expect high churn and potentially short-lived data.
- No PII is explicitly identified, but `create_uid` and `write_uid` link to user identity tables.
- The `delete` column is a `VARCHAR` and may contain non-standardized status strings; validate distinct values before filtering.