# project_share_collaborator_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the project collaboration and sharing workflow. It tracks the state of a wizard process used to invite or manage external partners (collaborators) on specific projects, capturing the intent to send invitations and the requested access levels.

## Description
One row in this table represents a single instance of a collaboration sharing wizard session. It acts as a transient staging record that captures the configuration of a sharing invitation before it is finalized or persisted to the core project-partner relationship tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| parent_wizard_id | INTEGER | true | Reference to a parent wizard | Likely links to a broader multi-step wizard process. |
| partner_id | INTEGER | false | Target partner identifier | The partner being invited or managed. |
| create_uid | INTEGER | true | Creator user ID | User ID who initiated the wizard session. |
| write_uid | INTEGER | true | Last modifier user ID | User ID who last updated the wizard session. |
| access_mode | VARCHAR | false | Permission level | Defines the scope of access (e.g., 'read', 'write'). |
| send_invitation | BOOLEAN | true | Invitation trigger flag | If true, an email invitation is queued for the partner. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Guess: Standard Odoo pattern for partner references).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit trail for user creation).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit trail for user modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the database server's timezone (typically UTC in Odoo deployments); verify against system configuration.
- **Soft Deletes:** This table does not appear to implement soft deletes; records represent transient wizard states.
- **Data Sensitivity:** `partner_id` and user IDs (`create_uid`, `write_uid`) are internal identifiers; ensure appropriate access controls are applied when joining with PII-heavy tables.
- **Wizard Lifecycle:** As a "wizard" table, data here may be ephemeral or intended for short-term retention. Check for high volumes of records that may not be cleaned up automatically.